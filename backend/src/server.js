require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const medicineRoutes = require('./routes/medicineRoutes');
const orderRoutes = require('./routes/orderRoutes');

const app = express();
app.use(cors());
app.use(express.json());

app.use(medicineRoutes);
app.use(orderRoutes);

app.get('/health', (_, res) => res.json({ ok: true }));

async function start() {
  await mongoose.connect(process.env.MONGODB_URI || 'mongodb://localhost:27017/krishna-pharmacy');
  const port = process.env.PORT || 4000;
  app.listen(port, () => {
    // eslint-disable-next-line no-console
    console.log(`Backend listening on ${port}`);
  });
}

start().catch((err) => {
  // eslint-disable-next-line no-console
  console.error(err);
  process.exit(1);
});
