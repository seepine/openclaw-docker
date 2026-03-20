#!/bin/bash
if [ ! -f "/root/.openclaw/openclaw.json" ]; then
  openclaw onboard --non-interactive --flow quickstart --accept-risk --skip-health
  openclaw config set gateway.bind "custom"
  openclaw config set gateway.customBindHost "0.0.0.0"
  openclaw config set gateway.controlUi.dangerouslyDisableDeviceAuth true
fi
nohup openclaw gateway &
node /index.js
