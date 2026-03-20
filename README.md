# OpenClaw Docker

通过 Docker 安全隔离部署 OpenClaw，确保 AI 代理只能访问你指定的目录，防止权限滥用、文件破坏或隐私泄漏。

## 一、快速开始

### 修改 docker-compose.yml

根据注释修改

```yml
services:
  openclaw:
    image: seepine/openclaw:latest
    volumes:
      # 修改 ./data 为你的目录
      - ./data:/root


    # 可选，不需要webUI可去掉
    environment:
      OPENCLAW_GATEWAY_TOKEN: r8l6fXMVxtQjtw # 修改此处，访问webUI需要
    ports:
      - 18789:18789

    # 可选，限制资源
    deploy:
      resources:
        limits: # 最大可用资源
          cpus: 4
          memory: 4096m
```

### 启动

```bash
docker-compose up
```

### 访问WebUI

浏览器访问 http://localhost:18789 并输入你配置的Token，即可进入后台

### 数据持久化

配置和数据挂载在 `./data` 目录，你可以挂载在任意目录例如 `/Users/seepine/openclaw_dir`，这样 openclaw 操作的文件你都可以在其访问到

## 配置

所有配置可在 WebUI 或者进入容器内部，使用 `openclaw` 命令进行配置，以下列出常见部署完必须要的配置

### 执行命令快速配置

```
openclaw onboard --flow quickstart
```