const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const path = require("path");
require("dotenv").config();

const Message = require("./models/Message");

const app = express();
app.use(cors());
app.use(express.json());

// MongoDB
mongoose
  .connect(process.env.MONGO_URI)
  .then(() => console.log("MongoDB connected"))
  .catch(console.error);

// API
app.get("/api/message", async (req, res) => {
  let msg = await Message.findOne();
  if (!msg) msg = await Message.create({ text: "Hello from MongoDB + Express 🚀" });
  res.json(msg);
});

// FRONTEND
const frontendPath = path.join(__dirname, "public");
app.use(express.static(frontendPath));

app.get("/", (req, res) => {
  res.sendFile(path.join(frontendPath, "index.html"));
});

// API 404 ONLY
app.use("/api", (req, res) => {
  res.status(404).json({ message: "API route not found" });
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Backend running on port ${PORT}`));
