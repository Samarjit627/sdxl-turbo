#!/bin/bash

/home/ec2-user/.venv/bin/python /home/ec2-user/test_sdxl.py &
sleep 5
exec /home/ec2-user/ngrok http 8000
