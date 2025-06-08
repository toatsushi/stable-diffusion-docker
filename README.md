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

2. 環境設定スクリプトの実行

以下のコマンドを実行して、必要なディレクトリやファイルをセットアップします。
   ```bash
   bash setup_sd_env.sh
   ```

3. Docker イメージをビルドします
   ```bash
   docker build -t sd-webui:custom . --no-cache
   ```

4. Docker コンテナをビルドして起動します。

   ```bash
   docker-compose up -d
   ```

5. ブラウザで以下の URL にアクセスします。

   ```
   http://localhost:7860
   ```

## ボリューム設定

以下のボリュームが設定されています：

- `./models`: 学習済みモデルを保存するフォルダ
- `./outputs`: 生成された画像や結果を保存するフォルダ
- `./extensions`: サードパーティの拡張機能を保存するフォルダ
- `./config`: アプリケーションの設定ファイルを保存するフォルダ

## 使用方法

- コンテナを起動した後、ブラウザでアクセスして、Stable Diffusion Web UI を使用できます。

## ライセンス

このプロジェクトは MIT ライセンスの下で公開されています。