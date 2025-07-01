const express = require("express");
const app = express();

app.get("/", (req, res) => res.send("App is live"));

//app listens on port 3000 (localhsot) and 0.0.0.0 for all public ingress traffic 
app.listen(3000, '0.0.0.0', () => {
  console.log("Server running on port 3000");
});