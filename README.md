# Stable Diffusion Docker

このリポジトリは、Stable Diffusion Web UI を Docker コンテナで実行するための設定を提供します。

## 必要条件

- Docker
- Docker Compose

## セットアップ

1. リポジトリをクローンします。

   ```bash
   git clone https://github.com/toatsushi/stable-diffusion-docker.git
   cd stable-diffusion-docker
   ```

2. Docker イメージをビルドします
   ```bash
   docker build -t stable-diffusion-webui .
   ```

3. Docker コンテナをビルドして起動します。

   ```bash
   docker-compose up -d
   ```

4. ブラウザで以下の URL にアクセスします。

   ```
   http://localhost:7860
   ```

## ボリューム設定

以下のボリュームが設定されています：

- `./outputs`: 生成された画像や結果を保存するフォルダ

## 使用方法

- コンテナを起動した後、ブラウザでアクセスして、Stable Diffusion Web UI を使用できます。

## ライセンス

このプロジェクトは MIT ライセンスの下で公開されています。