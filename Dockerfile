# 使用官方的 Node.js 18 镜像作为基础
FROM node:18-alpine AS builder

# 设置工作目录
WORKDIR /usr/src/app

# 复制所有项目文件
COPY . .

# 安装依赖
# --legacy-peer-deps 解决依赖冲突, --omit=dev 忽略开发依赖以减小体积
RUN npm install --legacy-peer-deps --omit=dev


# --- 第二阶段：创建最终的运行镜像 ---
FROM node:18-alpine

# 设置工作目录
WORKDIR /usr/src/app

# 从构建阶段复制必要的文件
# 只复制生产需要的文件，而不是所有源码和构建工具
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/package.json ./package.json
COPY --from=builder /usr/src/app/server.js ./server.js
COPY --from=builder /usr/src/app/public ./public
COPY --from=builder /usr/src/app/backgrounds ./backgrounds
COPY --from=builder /usr/src/app/characters ./characters
COPY --from=builder /usr/src/app/chats ./chats
COPY --from=builder /usr/src/app/groups ./groups
COPY --from=builder /usr/src/app/group\ chats ./group\ chats
COPY --from=builder /usr/src/app/instruct ./instruct
COPY --from=builder /usr/src/app/worlds ./worlds
COPY --from=builder /usr/src/app/settings.json ./settings.json
COPY --from=builder /usr/src/app/themes.json ./themes.json
COPY --from=builder /usr/src/app/user\ avatars ./user\ avatars


# SillyTavern 默认监听 8000 端口
EXPOSE 8000

# 启动应用的命令
CMD [ "node", "server.js" ]
