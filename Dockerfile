ARG OPENCLAW_VERSION=latest

FROM node:24-bookworm
RUN npm install -g openclaw@${OPENCLAW_VERSION}
WORKDIR /root
COPY index.js /index.js
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 CMD curl -sf http://localhost:58385/ || exit 1
ENTRYPOINT ["/entrypoint.sh"]
