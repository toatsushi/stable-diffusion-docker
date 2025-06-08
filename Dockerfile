FROM siutin/stable-diffusion-webui-docker:latest-cuda-12.1.1

# 0) 必要なパッケージをインストール
RUN apt-get update
RUN apt-get install -y wget

# 1) venv内でpipをアップグレード＆必要なパッケージをインストール
WORKDIR /app/stable-diffusion-webui
RUN /app/stable-diffusion-webui/venv/bin/pip install --upgrade pip && \
    /app/stable-diffusion-webui/venv/bin/pip install basicsr insightface

# 2) 拡張機能のclone
WORKDIR /app/stable-diffusion-webui/extensions
RUN git clone https://github.com/Mikubill/sd-webui-controlnet.git && \
    git clone https://github.com/adieyal/sd-dynamic-prompts.git && \
    git clone https://github.com/DominikDoom/a1111-sd-webui-tagcomplete.git && \
    git clone https://github.com/Fannovel16/openpose-editor.git && \
    git clone https://github.com/mattyamonaca/PBRemTools.git && \
    git clone https://github.com/KutsuyaYuki/ABG_extension.git

# 3) git safe.directoryの設定
RUN git config --global --add safe.directory /app/stable-diffusion-webui

# 4) モデルをCivitAI APIからダウンロード
WORKDIR /app/stable-diffusion-webui/models/Stable-diffusion
RUN wget --content-disposition "https://civitai.com/api/download/models/1761560?type=Model&format=SafeTensor&size=pruned&fp=fp16"

# 5) LoRAをダウンロード
WORKDIR /app/stable-diffusion-webui/models/Lora
RUN wget --content-disposition "https://civitai.com/api/download/models/62833?type=Model&format=SafeTensor"

# 5) 必要に応じてファイルパーミション調整
RUN chmod 644 /app/stable-diffusion-webui/models/Stable-diffusion/*.safetensors

# 6) embeddings のダウンロード
WORKDIR /app/stable-diffusion-webui/embeddings
RUN wget --content-disposition "https://huggingface.co/datasets/gsdf/EasyNegative/resolve/main/EasyNegative.safetensors?download=true" && \
    wget --content-disposition "https://huggingface.co/gsdf/Counterfeit-V3.0/resolve/main/embedding/EasyNegativeV2.safetensors?download=true" && \
    wget --content-disposition "https://huggingface.co/yesyeahvh/bad-hands-5/resolve/main/bad-hands-5.pt?download=true" && \
    wget --content-disposition "https://huggingface.co/datasets/Nerfgun3/bad_prompt/resolve/main/bad_prompt.pt?download=true" && \
    wget --content-disposition "https://huggingface.co/datasets/Nerfgun3/bad_prompt/resolve/main/bad_prompt_version2.pt?download=true" && \
    wget --content-disposition "https://huggingface.co/nick-x-hacker/bad-artist/resolve/main/bad-artist.pt?download=true" && \
    wget --content-disposition "https://huggingface.co/nick-x-hacker/bad-artist/resolve/main/bad-artist-anime.pt?download=true" && \
    wget --content-disposition "https://huggingface.co/p1atdev/badquality/resolve/main/badquality.pt?download=true" && \
    wget --content-disposition "https://huggingface.co/nolanaatama/embeddings/resolve/main/bad-picture-chill-75v.pt?download=true"
