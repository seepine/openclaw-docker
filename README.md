# OpenClaw Docker

通过 Docker 安全隔离部署 OpenClaw，确保 AI 代理只能访问你指定的目录，防止权限滥用、文件破坏或隐私泄漏。

## 一、快速开始

### 修改 docker-compose.yml

根据注释修改

```yml
services:
  openclaw:
    image: seepine/openclaw:2026.3.23-2
    volumes:
      # 修改 ./openclaw_root 为你的目录
      - ./openclaw_root:/root

    environment:
      TZ: Asia/Shanghai                      # 中国时区
      OPENCLAW_GATEWAY_TOKEN: r8l6fXMVxtQjtw # 修改此处，访问webUI需要

    # 可选，不需要webUI可去掉
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

配置和数据挂载在 `./openclaw_root` 目录，你可以挂载在任意目录例如 `/Users/seepine/openclaw_dir`，这样 openclaw 操作的文件你都可以在其访问到

## 二、配置

部署后进入容器内部终端，以下列出常见部署完必须要的配置

### 国内源

```
npm config set registry https://registry.npmmirror.com
```

### 执行命令快速配置

执行命令配置模型和channel，其他的都选择 skip 跳过即可，后续可以使用对话的方式让 openclaw 帮我们做

```
openclaw onboard --flow quickstart
```

### 登录 clawhub

前往 clawhub 注册账号并登录，进入设置页面下方的 API tokens，生成一个token

```
https://clawhub.ai/settings
```

执行命令登录

```
npx clawhub login --token clh_xxxxxx
```


## 三、安装后推荐事项

### 1. 初始化工作

告诉 openclaw

```
这是部署后第一次对话，根据 AGENTS.md 描述，当 BOOTSTRAP.md 存在要执行，之后删除它
```

### 2. 安装 skill

以下是 clawhub 高下载量 skill，你可复制以下内容按需删减，然后直接发给 openclaw

```ini
使用 npx clawhub install <skill-name> 安装以下 skill

- skill-vetter              # 技能审查
- self-improving-agent      # 自我改进代理
- proactive-agent           # 主动代理
- openclaw-tavily-search    # tavily 搜索
- markdown-converter        # 将文档文件转为 markdown
- mcporter                  # 让openclaw支持mcp
- agent-browser-clawdbot    # 更省token的代理浏览器
- summarize                 # 总结url或文件
- humanizer                 # 去除ai味文字
- skill-creator             # 创建技能指南
```

## 四、更新

### 1. 数据备份

更新之前强烈建议备份一下数据，例如 `openclaw_root` 这个目录，以免升级后出现问题，备份数据可快速回退

### 2. 版本升级

- 方案一：更新 docker 镜像版本号并重启容器
- 方案二：进入容器执行 `npm i -g openclaw@latest`

### 3. 验证

执行命令验证

```sh
openclaw doctor
openclaw gateway restart
openclaw health
```
