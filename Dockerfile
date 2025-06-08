FROM siutin/stable-diffusion-webui-docker:latest-cuda-12.1.1

USER root

# 0) 必要なパッケージをインストール
RUN apt-get update
RUN apt-get install -y wget

# 1) venv内でpipをアップグレード＆必要なパッケージをインストール
WORKDIR /app/stable-diffusion-webui

RUN echo '#!/bin/bash\n\
. /app/stable-diffusion-webui/venv/bin/activate && \
pip install --upgrade pip && \
pip install basicsr insightface' > /app/setup_pip.sh && \
chmod +x /app/setup_pip.sh

USER app
RUN /app/setup_pip.sh