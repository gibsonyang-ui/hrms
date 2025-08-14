#!/bin/bash

# HRMS Docker镜像快照创建脚本
# 用于保存当前运行容器的状态为新的Docker镜像

echo "=== HRMS Docker镜像快照创建工具 ==="
echo ""

# 检查Docker是否运行
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker未运行，请启动Docker Desktop后重试"
    exit 1
fi

# 获取当前时间戳
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
IMAGE_NAME="hrms-chinese-stable"
TAG="v1.0.0-${TIMESTAMP}"

echo "📋 准备创建镜像快照："
echo "   镜像名称: ${IMAGE_NAME}"
echo "   标签: ${TAG}"
echo ""

# 查找运行中的HRMS容器
CONTAINER_ID=$(docker ps --filter "name=frappe" --format "{{.ID}}" | head -1)

if [ -z "$CONTAINER_ID" ]; then
    echo "❌ 未找到运行中的Frappe容器"
    echo "   请确保HRMS系统正在运行: docker-compose up -d"
    exit 1
fi

echo "✅ 找到Frappe容器: $CONTAINER_ID"
echo ""

# 停止容器以确保数据一致性
echo "⏸️  暂停容器以确保数据一致性..."
docker pause $CONTAINER_ID

# 创建镜像
echo "📦 创建Docker镜像快照..."
docker commit $CONTAINER_ID ${IMAGE_NAME}:${TAG}

if [ $? -eq 0 ]; then
    echo "✅ 镜像创建成功: ${IMAGE_NAME}:${TAG}"
    
    # 创建latest标签
    docker tag ${IMAGE_NAME}:${TAG} ${IMAGE_NAME}:latest
    echo "✅ 已创建latest标签: ${IMAGE_NAME}:latest"
    
    # 显示镜像信息
    echo ""
    echo "📊 镜像信息："
    docker images ${IMAGE_NAME} --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}\t{{.CreatedAt}}"
    
    echo ""
    echo "💾 保存镜像到文件（可选）："
    echo "   docker save ${IMAGE_NAME}:${TAG} | gzip > hrms-backup-${TAG}.tar.gz"
    echo ""
    echo "🚀 使用镜像部署新实例："
    echo "   docker run -d --name hrms-new -p 8001:8000 ${IMAGE_NAME}:${TAG}"
    
else
    echo "❌ 镜像创建失败"
fi

# 恢复容器运行
echo ""
echo "▶️  恢复容器运行..."
docker unpause $CONTAINER_ID

echo ""
echo "🎉 快照创建完成！"
