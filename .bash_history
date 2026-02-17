nvidia-smi
curl http://169.254.169.254/latest/meta-data/instance-type
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
curl -H "X-aws-ec2-metadata-token: $TOKEN"   http://169.254.169.254/latest/meta-data/instance-type
clear
sudo yum update -y
sudo amazon-linux-extras | grep -i nvidia
cat /etc/os-release
sudo dnf install -y kernel-devel kernel-headers gcc make dkms
sudo dnf config-manager --add-repo=https://developer.download.nvidia.com/compute/cuda/repos/amzn2023/x86_64/cuda-amzn2023.repo
sudo dnf clean all
sudo dnf -y install nvidia-driver
clear
nvidia-smi
sudo dnf clean all
sudo dnf -y install nvidia-driver
nvidia-smi
sudo reboot
nvidia-smi
lsmod | grep nvidia
/usr/libexec/nvidia/nvidia-smi
ls /usr/libexec/nvidia/nvidia-smi
/usr/bin/nvidia-smi
ls /usr/bin/nvidia-smi
/usr/libexec/nvidia/nvidia-smi
sudo dnf install -y nvidia-driver-NVML
sudo dnf install -y nvidia-utils
sudo dnf search nvidia
sudo dnf install -y nvidia-driver-cuda
which nvidia-smi
nvidia-smi
clear
sudo dnf install -y python3.10 python3.10-venv
python3 --version
python3 -m pip --version
sudo dnf install -y python3-pip
python3 -m pip --version
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install torch torchvision --index-url https://download.pytorch.org/whl/cu118
python -c "import torch; print(torch.cuda.is_available())"
clear
pip install diffusers transformers accelerate safetensors pillow
nano test_sdxl.py
clear
python test_sdxl.py
nano test_sdxl.py
python test_sdxl.py
nano test_sdxl.py
python test_sdxl.py
pip uninstall diffusers -y
pip install diffusers==0.27.2
pip install accelerate==0.27.2
nano test_sdxl.py
clear
python test_sdxl.py
nano test_sdxl.py
python test_sdxl.py
pip install huggingface_hub==0.20.3
pip uninstall transformers -y
pip install transformers==4.37.2
clear
python test_sdxl.py
clear
nano test_sdxl.py 
python test_sdxl.py
pip uninstall torch torchvision -y
pip install torch torchvision --index-url https://download.pytorch.org/whl/cu121
python -c "import torch; print(torch.version.cuda)"
df -h
sudo growpart /dev/nvme0n1 1
sudo resize2fs /dev/nvme0n1p1
lsblk
df -h
sudo xfs_growfs -d /
df -h
pip install torch torchvision --index-url https://download.pytorch.org/whl/cu121
python -c "import torch; print(torch.version.cuda)"
python test_sdxl.py
nano test_sdxl.py 
python test_sdxl.py
nano test_sdxl.py 
python test_sdxl.py
clear
ls
hostname
pwd
ls -la
python test_sdxl.py
clear
python test_sdxl.py
