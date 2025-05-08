const http = require("http");
const port = 9999;

const crypto = require("crypto");
const MAGIC_KEY = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11";
function generateAcceptValue(secWsKey) {
  return crypto
    .createHash("sha1")
    .update(secWsKey + MAGIC_KEY, "utf8")
    .digest("base64");
}

// const { generateAcceptValue } = require("util");
const server = http.createServer((req, res) => {
  res.writeHead(200, { "Content-Type": "text/plain; charset=utf-8"});
  res.end("大家好，我是阿宝哥。感谢你阅读“你不知道的WebSocket”");
});

server.on("upgrade", function(req, socket) {
  if(req.headers["upgrade"] !== "websocket") {
    socket.end("HTTP/1.1 400 Bad Request");
    return;
  }
  // 读取客户端提供的Sec-WebSocket-Key
  const secWsKey = req.headers["sec-websocket-key"];
  // 使用SHA-1算法生成Sec-WebSocket-Accept
  const hash = generateAcceptValue(secWsKey);
  // 设置HTTP响应头
  const responseHeaders = [
    "HTTP/1.1 101 Web Socket Protocol Handshake",
    "Upgrade: WebSocket",
    "Connection: Upgrade",
    `Sec-WebSocket-Accept: ${hash}`,
  ];
  // 返回握手请求的响应信息
  socket.write(responseHeaders.join("\r\n") + "\r\n\r\n");
});

server.listen(port, () =>
  console.log(`Server running at http://localhost:${port}`)
);
