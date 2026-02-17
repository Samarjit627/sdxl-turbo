# SDXL Turbo Image Renderer API

FastAPI server for rendering images using Stable Diffusion XL Turbo with dynamic line art style.

## Features

- Image-to-image transformation using SDXL Turbo
- RESTful API endpoint for easy integration
- CORS enabled for web applications
- GPU acceleration support (CUDA/MPS)
- Automatic image padding and cropping

## Prerequisites

- Python 3.9+
- CUDA-capable GPU (optional, but recommended for faster processing)
- Virtual environment (recommended)

## Installation

1. Clone the repository:
```bash
git clone https://github.com/Samarjit627/sdxl-turbo.git
cd sdxl-turbo
```

2. Create and activate virtual environment:
```bash
python -m venv .venv
source .venv/bin/activate  # On Linux/Mac
# .venv\Scripts\activate   # On Windows
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

## Running the Server

Start the FastAPI server:
```bash
python test_sdxl.py
```

The server will start on `http://0.0.0.0:8000`

## API Usage

### Endpoint: POST `/render`

Upload an image and receive a rendered version using SDXL.

**Parameters:**
- `file` (required): Image file to render
- `num_inference_steps` (optional): Number of inference steps (default: 25)
- `strength` (optional): Transformation strength (default: 0.4)
- `guidance_scale` (optional): Guidance scale (default: 7.5)

**Example using cURL:**
```bash
curl -X POST "http://localhost:8000/render" \
  -F "file=@your_image.jpg" \
  -F "num_inference_steps=25" \
  -F "strength=0.4" \
  -F "guidance_scale=7.5" \
  --output rendered_output.png
```

**Example using JavaScript:**
```javascript
const formData = new FormData();
formData.append('file', imageFile);
formData.append('num_inference_steps', 25);
formData.append('strength', 0.4);
formData.append('guidance_scale', 7.5);

const response = await fetch('http://localhost:8000/render', {
  method: 'POST',
  body: formData
});

const blob = await response.blob();
const imageUrl = URL.createObjectURL(blob);
```

## Using with ngrok (HTTPS Tunnel)

To expose your local server with HTTPS:

1. Download and extract ngrok (already included):
```bash
./ngrok http 8000
```

2. Use the provided HTTPS URL in your web application

## CORS Configuration

The server is configured to accept requests from:
- `https://axis5-dfm.netlify.app`

To add more origins, edit the `allow_origins` list in `test_sdxl.py`.

## API Documentation

Once the server is running, visit:
- Swagger UI: `http://localhost:8000/docs`
- ReDoc: `http://localhost:8000/redoc`

## Model Information

This project uses:
- **Model:** stabilityai/sdxl-turbo
- **Style:** Dynamic line art with pressure-sensitive strokes
- **Target Size:** 1024x1024 (automatically padded/cropped)

## License

MIT License
