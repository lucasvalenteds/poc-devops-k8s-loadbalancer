import * as HTTP from "http";

const port = process.env.PORT;

const server = HTTP.createServer((_, response) => {
  response.statusCode = 200;
  response.write(JSON.stringify({ message: "Hello World" }));
  response.end(() => console.debug("%s: Request received", new Date()));
});

server
  .listen(port)
  .once("listening", () => console.debug("Server running on port %d", port));
