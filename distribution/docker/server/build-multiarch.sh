#!/bin/bash
# 构建多平台（linux/amd64, linux/arm64）Nacos 镜像

# ---------- 设置代理 ----------
export HTTP_PROXY="http://127.0.0.1:7890"
export HTTPS_PROXY="http://127.0.0.1:7890"
export NO_PROXY="localhost,127.0.0.1,.local"

# 某些工具也识别小写形式
export http_proxy="$HTTP_PROXY"
export https_proxy="$HTTPS_PROXY"
export no_proxy="$NO_PROXY"

# 请替换为你的镜像仓库和标签
IMAGE_REPO="registry.cn-hangzhou.aliyuncs.com/chinajeckxu/seata-server"
TAG="2.3.0_TW"

# 确保 buildx 可用并创建 builder（如果不存在）
docker buildx create --name multiarch-builder --use || true
docker buildx inspect --bootstrap

# 构建并推送多平台镜像
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t ${IMAGE_REPO}:${TAG} \
  --push .

# docker buildx imagetools inspect registry.cn-hangzhou.aliyuncs.com/chinajeckxu/seata-server:2.3.0_TW