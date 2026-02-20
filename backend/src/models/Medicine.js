const mongoose = require('mongoose');

const medicineSchema = new mongoose.Schema(
  {
    name: { type: String, required: true },
    category: { type: String, required: true },
    price: { type: Number, required: true },
    image: { type: String, default: '' },
    stock: { type: Number, default: 0 },
    prescriptionRequired: { type: Boolean, default: false },
  },
  { timestamps: true }
);

module.exports = mongoose.model('Medicine', medicineSchema);
