import torch
from diffusers import AutoPipelineForImage2Image
from PIL import Image
from pathlib import Path
from enum import Enum
from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import StreamingResponse
import io

_PIPE = None


def get_render_pipe():
    global _PIPE

    if _PIPE is not None:
        return _PIPE

    print("Loading pipeline...")
    
    # Match local configuration: detect device and set appropriate dtype/variant
    device = "cpu"
    variant = None
    dtype = torch.float32
    
    if torch.backends.mps.is_available():
        device = "mps"
        dtype = torch.float32
        variant = None
        print("Detected Apple Silicon (MPS). Enabling GPU acceleration (Float32 for stability).")
    elif torch.cuda.is_available():
        device = "cuda"
        dtype = torch.float16
        variant = "fp16"
        print("Detected Nvidia CUDA. Enabling GPU acceleration.")
    else:
        print("No GPU detected. Using CPU.")
    
    _PIPE = AutoPipelineForImage2Image.from_pretrained(
        "stabilityai/sdxl-turbo",
        torch_dtype=dtype,
        variant=variant,
    ).to(device)
    
    print(f"Pipeline loaded (Device: {device}, Dtype: {dtype})")
    return _PIPE

app = FastAPI(title="SDXL Image Renderer API")

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["https://axis5-dfm.netlify.app"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

NEGATIVE_PROMPT = (
    "wobbly lines, shaky, uneven, distorted wheels, bad perspective, "
    "stagnant lines, uniform line weight, boring, messy, "
    "bad anatomy, ugly, pixelated, low resolution, amateur"
)

class RenderStyle(str, Enum):
    STUDIO = "studio"
    OUTDOOR = "outdoor"
    NIGHT = "night"
    CLAY = "clay"
    METALLIC = "metallic"
    MARKER = "marker"
    DIGITAL = "digital"
    ANALOG = "analog"
    GESTURAL = "gestural"
    PENCIL_6B = "pencil_6b"
    DYNAMIC_LINE = "dynamic_line"


STYLE_PROMPTS = {
    RenderStyle.STUDIO: (
        "Photorealistic car render, professional automotive photography, "
        "studio lighting, clean white cyclorama background, "
        "highly detailed, sharp focus, octane render quality, "
        "automotive showroom, reflective floor"
    ),
    RenderStyle.OUTDOOR: (
        "Photorealistic car in outdoor environment, "
        "natural daylight, scenic mountain road background, "
        "automotive photography, sharp details, "
        "dramatic landscape, golden hour lighting"
    ),
    RenderStyle.NIGHT: (
        "Photorealistic car at night, dramatic lighting, "
        "city lights reflection, neon ambiance, "
        "moody atmosphere, sharp details, "
        "urban environment, cinematic"
    ),
    RenderStyle.CLAY: (
        "Clay model car render, matte gray surface, "
        "sculptural quality, soft studio lighting, "
        "automotive design studio, clean background, "
        "professional clay model visualization"
    ),
    RenderStyle.METALLIC: (
        "Photorealistic metallic car, chrome reflections, "
        "mirror-like finish, studio lighting, "
        "highly polished surface, sparkle highlights, "
        "automotive showroom quality"
    ),
    RenderStyle.MARKER: (
        "Professional automotive design sketch, alcohol marker coloring, "
        "Copic marker style, confident loose strokes, energetic lines, "
        "design studio concept art, vibrant colors, white background, "
        "high quality illustration"
    ),
    RenderStyle.DIGITAL: (
        "Digital concept art, automotive speedpaint, "
        "Wacom tablet aesthetic, clean crisp details, "
        "atmospheric lighting, soft shadows, "
        "modern concept car design, ArtStation quality"
    ),
    RenderStyle.ANALOG: (
        "High fidelity pencil sketch, graphite shading, "
        "technical illustration, cross-hatching details, "
        "crisp sharp lines, monochromatic, "
        "hand-drawn masterpiece, paper texture"
    ),
    RenderStyle.GESTURAL: (
        "Expressive automotive sketch, dynamic brush strokes, "
        "ink wash, watercolor splatters, varying line weight, "
        "gestural energy, loose artistic style, "
        "traditional media, masterpiece, fluid motion"
    ),
    RenderStyle.PENCIL_6B: (
        "Graphite pencil sketch, 4B pencil, 6B shading, "
        "clean technical drawing, automotive design sketch, "
        "pencil texture, grain, monochromatic, "
        "varying line weight, crisp details"
    ),
    RenderStyle.DYNAMIC_LINE: (
        "Professional automotive design sketch, dynamic line weight, "
        "pressure sensitivity, thick and thin strokes, tapered lines, "
        "confident gestural curves, perfect geometric ellipses, "
        "precise wheel arches, detailed B-pillar and window graphics, "
        "6B dark accents for ground shadow, H light construction lines, "
        "crisp clean aesthetic, accurate details"
    ),
}


def render(
    image: Image.Image,
    *,
    style: RenderStyle = RenderStyle.STUDIO,
    target_size: int = 1024,
    num_inference_steps: int = 25,
    strength: float = 0.4,
    guidance_scale: float = 7.5,
):
    pipe = get_render_pipe()
    if pipe is None:
        raise Exception("SDXL pipeline could not be loaded")

    width, height = image.size

    ratio = min(target_size / width, target_size / height)
    new_width = int(width * ratio)
    new_height = int(height * ratio)
    scaled = image.resize((new_width, new_height), Image.Resampling.LANCZOS)

    square_img = Image.new("RGB", (target_size, target_size), (255, 255, 255))
    offset_x = (target_size - new_width) // 2
    offset_y = (target_size - new_height) // 2
    square_img.paste(scaled, (offset_x, offset_y))

    # Always use DYNAMIC_LINE prompt
    prompt = STYLE_PROMPTS[RenderStyle.DYNAMIC_LINE]

    print("  [Render] Running SDXL...")
    output = pipe(
        prompt=prompt,
        negative_prompt=NEGATIVE_PROMPT,
        image=square_img,
        num_inference_steps=num_inference_steps,
        strength=strength,
        guidance_scale=guidance_scale,
    ).images[0]

    output_cropped = output.crop(
        (
            offset_x,
            offset_y,
            offset_x + new_width,
            offset_y + new_height,
        )
    )
    return output_cropped


@app.post("/render")
async def render_image(
    file: UploadFile = File(...),
    num_inference_steps: int = 25,
    strength: float = 0.4,
    guidance_scale: float = 7.5,
):
    """
    Upload an image and receive a rendered version using SDXL.
    
    Parameters:
    - file: Image file to render
    - num_inference_steps: Number of inference steps (default: 25)
    - strength: Transformation strength (default: 0.4)
    - guidance_scale: Guidance scale (default: 7.5)
    """
    try:
        # Read uploaded image
        contents = await file.read()
        input_image = Image.open(io.BytesIO(contents)).convert("RGB")
        
        print(f"Received image: {input_image.size}")
        
        # Render the image
        output_image = render(
            input_image,
            style=RenderStyle.DYNAMIC_LINE,
            num_inference_steps=num_inference_steps,
            strength=strength,
            guidance_scale=guidance_scale,
        )
        
        # Convert output to bytes
        img_byte_arr = io.BytesIO()
        output_image.save(img_byte_arr, format='PNG')
        img_byte_arr.seek(0)
        
        return StreamingResponse(
            img_byte_arr,
            media_type="image/png",
            headers={"Content-Disposition": "attachment; filename=rendered_image.png"}
        )
        
    except Exception as e:
        print(f"Error processing image: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Error processing image: {str(e)}")


@app.get("/")
async def root():
    return {
        "message": "SDXL Image Renderer API",
        "endpoint": "/render",
        "method": "POST",
        "description": "Upload an image to receive a rendered version"
    }


if __name__ == "__main__":
    import uvicorn
    print("Starting SDXL Render API Server...")
    uvicorn.run(app, host="0.0.0.0", port=8000)
