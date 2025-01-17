#!/usr/bin/env bash

set -Eeuo pipefail

# TODO: maybe just use the .gitignore file to create all of these
mkdir -vp /data/.cache \
  /data/embeddings \
  /data/config/ \
  /data/models/ \
  /data/models/Stable-diffusion \
  /data/models/GFPGAN \
  /data/models/RealESRGAN \
  /data/models/LDSR \
  /data/models/VAE


git lfs clone -b main --single-branch https://huggingface.co/openai/clip-vit-large-patch14 /data/hf/clip-vit-large-patch14 && rm -rf /data/hf/clip-vit-large-patch14/.git

mkdir -p /data/config/comfy/custom_nodes/comfyui_controlnet_aux/ckpts/lllyasviel

cd /data/config/comfy/custom_nodes/comfyui_controlnet_aux/ckpts/lllyasviel/

git lfs clone -b main --single-branch  https://huggingface.co/lllyasviel/Annotators.git && rm -rf Annotators/.git


echo "Downloading, this might take a while..."

aria2c -x 10 --disable-ipv6 --input-file /docker/links.txt --dir /data/models --continue

echo "Checking SHAs..."

parallel --will-cite -a /docker/checksums.sha256 "echo -n {} | sha256sum -c"

cat <<EOF
By using this software, you agree to the following licenses:
https://github.com/AbdBarho/stable-diffusion-webui-docker/blob/master/LICENSE
https://github.com/CompVis/stable-diffusion/blob/main/LICENSE
https://github.com/AUTOMATIC1111/stable-diffusion-webui/blob/master/LICENSE.txt
https://github.com/invoke-ai/InvokeAI/blob/main/LICENSE
And licenses of all UIs, third party libraries, and extensions.
EOF
