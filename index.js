const http = require('http');

const server = http.createServer((req, res) => {
  res.end('Hello, Openclaw!');
});
server.listen(58385);
