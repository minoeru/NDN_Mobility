# Configuration
- DockerImage
  - /configuration
    - makeConfigで作成を行う情報
  - /Dockerfiles
    - NLSRルータ用のDocker Config
  - /my_conf
    - nlsr.confの集合
  - /my_program
    - DockerImage作成時に変更したプログラム置き場
  - /script
    - Dockerに移植するスクリプト
  - makeConfig.R
    - nlsr.confとDockerfileの作成を行う。
- /practice
  - ルータ3台のコマンド確認用
  - キャッシュの仕様確認用
- /ndnping
  - ndnping実験用
- /ndnpeek
  - 移動や自作ルーティングスクリプトを実行した際のndnpeekの成功確率を求める用
- /topology
  - ネットワークのトポロジを変更した際のパケット量の増加について調べる用
- /percent
  - 同一のトポロジにおいて、キャッシュしたコンテンツの広告確率を変更した際のパケット量の変化について調べる用

# Build
- シングル環境
  - docker build  -t minoeru/nlsr:\<name> -f ./Dockerfiles/\<name>/Dockerfile .
- マルチ環境(要検証,DockerHubへ出力)
  - docker buildx build --platform linux/amd64,linux/arm64 -t minoeru/nlsr:\<name> -f ./Dockerfiles/\<name>/Dockerfile --push .

# Push Docker Hub
docker push minoeru/nlsr:pra
