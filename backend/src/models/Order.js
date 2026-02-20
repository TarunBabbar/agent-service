const mongoose = require('mongoose');

const orderSchema = new mongoose.Schema(
  {
    userId: { type: String, required: true },
    medicines: [
      {
        medicineId: { type: mongoose.Schema.Types.ObjectId, ref: 'Medicine' },
        quantity: Number,
      },
    ],
    assignedShop: { type: String, required: true },
    etaMinutes: { type: Number, required: true },
    status: { type: String, enum: ['pending', 'approved', 'rejected', 'confirmed'], default: 'pending' },
    paymentMethod: { type: String, enum: ['cod', 'qr', 'gpay'], required: true },
    prescriptionUrl: String,
  },
  { timestamps: true }
);

module.exports = mongoose.model('Order', orderSchema);
