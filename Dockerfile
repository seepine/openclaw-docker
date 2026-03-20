FROM node:24-bullseye
RUN npm config set registry https://registry.npmmirror.com
RUN npm install -g openclaw@latest
WORKDIR /root
COPY index.js /index.js
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
