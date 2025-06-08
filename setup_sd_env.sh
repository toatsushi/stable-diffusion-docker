#!/bin/bash

# --- 初期設定 ---
set -e  # エラー時に即終了
WEBUI_DIR="./stable-diffusion-docker"
EXT_DIR="$WEBUI_DIR/extensions"
MODEL_DIR="$WEBUI_DIR/models/Stable-diffusion"
LORA_DIR="$WEBUI_DIR/models/Lora"
EMBED_DIR="$WEBUI_DIR/embeddings"
DIRS=("outputs" "models" "extensions" "config" "embeddings")

# --- 拡張機能のclone ---
echo "Cloning extensions..."
mkdir -p "$EXT_DIR"
cd "$EXT_DIR"
git clone https://github.com/Mikubill/sd-webui-controlnet.git
git clone https://github.com/adieyal/sd-dynamic-prompts.git
git clone https://github.com/DominikDoom/a1111-sd-webui-tagcomplete.git
git clone https://github.com/Fannovel16/openpose-editor.git
git clone https://github.com/mattyamonaca/PBRemTools.git
git clone https://github.com/KutsuyaYuki/ABG_extension.git
git clone https://github.com/Coyote-A/ultimate-upscale-for-automatic1111.git

# --- git safe.directory の設定 ---
echo "Setting git safe.directory..."
git config --global --add safe.directory "$WEBUI_DIR"

# --- モデルのダウンロード ---
echo "Downloading models..."
mkdir -p "$MODEL_DIR"
cd "$MODEL_DIR"
wget --content-disposition "https://civitai.com/api/download/models/1761560?type=Model&format=SafeTensor&size=pruned&fp=fp16"

# --- LoRAのダウンロード ---
echo "Downloading LoRA..."
mkdir -p "$LORA_DIR"
cd "$LORA_DIR"
wget --content-disposition "https://civitai.com/api/download/models/62833?type=Model&format=SafeTensor"

# --- embeddings のダウンロード ---
echo "Downloading embeddings..."
mkdir -p "$EMBED_DIR"
cd "$EMBED_DIR"
wget --content-disposition "https://huggingface.co/datasets/gsdf/EasyNegative/resolve/main/EasyNegative.safetensors?download=true"
wget --content-disposition "https://huggingface.co/gsdf/Counterfeit-V3.0/resolve/main/embedding/EasyNegativeV2.safetensors?download=true"
wget --content-disposition "https://huggingface.co/yesyeahvh/bad-hands-5/resolve/main/bad-hands-5.pt?download=true"
wget --content-disposition "https://huggingface.co/datasets/Nerfgun3/bad_prompt/resolve/main/bad_prompt.pt?download=true"
wget --content-disposition "https://huggingface.co/datasets/Nerfgun3/bad_prompt/resolve/main/bad_prompt_version2.pt?download=true"
wget --content-disposition "https://huggingface.co/nick-x-hacker/bad-artist/resolve/main/bad-artist.pt?download=true"
wget --content-disposition "https://huggingface.co/nick-x-hacker/bad-artist/resolve/main/bad-artist-anime.pt?download=true"
wget --content-disposition "https://huggingface.co/p1atdev/badquality/resolve/main/badquality.pt?download=true"
wget --content-disposition "https://huggingface.co/nolanaatama/embeddings/resolve/main/bad-picture-chill-75v.pt?download=true"

# --- パーミッションの設定 ---
echo "Setting permissions..."
for dir in "${DIRS[@]}"; do
    if [ -d "$WEBUI_DIR/$dir" ]; then
        sudo chown -R $USER:$USER "$WEBUI_DIR/$dir"
        sudo chmod -R 755 "$WEBUI_DIR/$dir"
    fi
done

echo "環境構築が完了しました"