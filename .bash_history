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
ngrok http 8000
./ngrok http 8000
./ngrok config add-authtoken 39Z5niMvwcZMdNhSWaCG0DWmgA7_4BN7LaDfAFNHTWwiZFYHr
./ngrok http 8000
clear
./ngrok http 8000
./ngrok config remove-authtoken
./ngrok config edit
./ngrok http 8000
source .venv/bin/activate
clear
pip install torch diffusers pillow fastapi uvicorn[standard] python-multipart
clear
python test_sdxl.py 
clear
python test_sdxl.py 
source .venv/bin/activate
pip freeze > requirements.txt
git init
deactivate
sudo dnf install git
git init -y
git add .
git init
git add .
git commit -m "initial commit"
git branch -M main
git remote add origin https://github.com/Samarjit627/sdxl-turbo.git
git push -u origin main
git status
sudo dnf update -y
sudo dnf install git -y
git --version
git config --global user.name "shreevathsar-2002"
git config --global user.email "shreevathsa.r@yulu.bike"
git config --list
git push -u origin main
git add .
git commit -m "added readme"
git reset --soft HEAD~1
git status
git commit -m "added readme"
git status
git reset --soft HEAD~1
git add .
git status
git commit -m "added readme"
git push -u origin main
which ngrok
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
tar xvzf ngrok-v3-stable-linux-amd64.tgz
./ngrok --version
./ngrok http 8000
source .venv/bin/activate
clear
python test_sdxl.py 
./ngrok http 8000
git add .
git commit -m "updated default strength parameter from 0.4 to 0.47"
git push origin
source .venv/bin/activate
python test_sdxl.py
source .venv/bin/activate
python test_sdxl.py 
source .venv/bin/activate
python test_sdxl.py 
.ngrok http 8001
./ngrok http 8001
./ngrok http 8000
./ngrok
./ngrok authtoken 3A3hNC0lPcdiLwFgsvRJkdRDSsx_4g4T9v2a946NVAFCJ4zyg
./ngrok http 8000
source .venv/bin/activate
python test_sdxl.py 
clear
python test_sdxl.py 
source .venv/bin/activate
python test_sdxl.py 
source .venv/bin/activate
python test_sdxl.py 
./ngrok http 8000
source .venv/bin/activate
python test_sdxl.py 
source .venv/bin/activate
python test_sdxl.py 
.ng
./ngrok http 8000
source .venv/bin/activate
python test_sdxl.py 
source .venv/bin/activate
python test_sdxl.py 
nano start_app.sh
chmod +x start_app.sh
./start_app.sh
sudo nano /etc/systemd/system/sdxl.service
sudo systemctl daemon-reload
sudo systemctl enable sdxl
sudo systemctl restart sdxl
sudo systemctl status sdxl
ls /home/ec2-user/.venv/bin/python
sudo nano /etc/systemd/system/sdxl.service
sudo systemctl restart sdxl
sudo systemctl daemon-reload
sudo systemctl restart sdxl
sudo systemctl status sdxl
journalctl -u sdxl -n 50 --no-pager
ls -l /home/ec2-user | grep ngrok
sudo nano /etc/systemd/system/sdxl.service
clear
sudo systemctl daemon-reload
sudo systemctl restart sdxl
sudo systemctl status sdxl
ls
ls -la
nano start_app.sh 
chmod +x /home/ec2-user/start_app.sh 
sudo nano /etc/systemd/system/sdxl.service
sudo systemctl daemon-reload
sudo systemctl restart sdxl
sudo systemctl status sdxl
journalctl -u sdxl -f
pkill ngrok
sudo systemctl restart sdxl
journalctl -u sdxl -f
sudo systemctl status sdxl
./ngrok http 8000
source .venv/bin/activate
python test_sdxl.py 
journalctl -u sdxl -f
ls
nano test_sdxl.py 
sudo systemctl restart sdxl
journalctl -u sdxl -f
set +o ignoreeof
set -o interactive-comments
set +o keyword
set -o monitor
set +o noclobber
set +o noexec
set +o noglob
set +o nolog
set +o notify
set +o onecmd
set +o physical
set +o posix
set +o privileged
set +o verbose
set +o xtrace
sudo journalctl -u sdxl -f
sudo systemctl status sdxl
journalctl -u sdxl -f
ls
set +o ignoreeof
set -o interactive-comments
set +o keyword
set -o monitor
set +o noclobber
set +o noexec
set +o noglob
set +o nolog
set +o notify
set +o onecmd
set +o physical
set +o posix
set +o privileged
set +o verbose
set +o xtrace
