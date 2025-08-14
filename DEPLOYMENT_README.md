# HRMS 中文化部署指南

## 🎯 项目概述

这是一个完全配置好的 Frappe HRMS 系统，支持中文界面和容器化部署。

### ✨ 主要特性

- ✅ **完整中文界面支持**
- ✅ **Docker 容器化部署**
- ✅ **内网访问支持**
- ✅ **完整 HRMS 功能**（包括 Attendance 模块）
- ✅ **自动化配置脚本**

## 🚀 快速部署

### 前置要求

- Docker Desktop
- Git
- 至少 4GB 可用内存

### 部署步骤

1. **克隆仓库**
```bash
git clone https://github.com/gibsonyang-ui/hrms.git
cd hrms
```

2. **启动服务**
```bash
cd docker
docker-compose up -d
```

3. **访问系统**
- 内网访问：http://192.168.72.20:8000
- 本地访问：http://localhost:8000

### 默认账号

- **用户名**: Administrator
- **密码**: Gibson1234!

## 📋 系统配置

### 语言设置

系统已自动配置为中文：
- 系统语言：中文 (zh)
- 国家：中国
- 时区：Asia/Shanghai

### 网络配置

- 自定义网络：hrms-network
- 端口映射：0.0.0.0:8000->8000
- 支持内网访问

## 🔧 维护操作

### 创建系统快照

```bash
# 使用提供的脚本
./docker/create_snapshot.sh
```

### 手动语言修复

如果界面显示英文，运行：
```bash
docker exec docker-frappe-1 bash -c "cd frappe-bench && python3 /workspace/docker/fix_language.py"
```

### 重建系统

```bash
docker-compose down -v
docker-compose up -d
```

## 📁 项目结构

```
hrms/
├── docker/
│   ├── docker-compose.yml    # Docker编排配置
│   ├── init.sh              # 初始化脚本
│   ├── fix_language.py      # 语言修复工具
│   └── create_snapshot.sh   # 快照创建工具
├── DEPLOYMENT_README.md     # 部署说明
└── ...                      # HRMS源码
```

## 🏷️ 版本信息

- **当前版本**: v1.0.0-chinese-stable
- **基于**: Frappe HRMS develop分支
- **Docker镜像**: frappe/bench:latest

## 🔍 故障排除

### 常见问题

1. **容器启动失败**
   - 检查端口占用：`netstat -an | findstr :8000`
   - 重启Docker Desktop

2. **界面显示英文**
   - 运行语言修复脚本
   - 检查用户个人语言设置

3. **无法访问内网地址**
   - 确认网络配置
   - 检查防火墙设置

### 日志查看

```bash
# 查看所有服务日志
docker-compose logs

# 查看特定服务日志
docker-compose logs frappe
```

## 📞 技术支持

如有问题，请检查：
1. Docker Desktop 是否正常运行
2. 端口 8000 是否被占用
3. 系统内存是否充足（建议 4GB+）

## 🎉 部署完成

系统部署完成后，您可以：
- 创建员工档案
- 配置考勤规则
- 设置薪资结构
- 管理请假流程
- 生成各类报表

祝您使用愉快！ 🚀
