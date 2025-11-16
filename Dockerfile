# 使用官方的 Node.js 18 镜像作为基础
FROM node:18-alpine

# 设置工作目录
WORKDIR /usr/src/app

# ！！！修改点！！！
# 先复制所有项目文件
COPY . .

# 然后再安装项目依赖
# 使用 --legacy-peer-deps 来解决可能的依赖冲突
RUN npm install --legacy-peer-deps

# SillyTavern 默认监听 8000 端口
EXPOSE 8000

# 启动应用的命令
CMD [ "node", "server.js" ]
