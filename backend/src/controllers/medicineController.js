const Medicine = require('../models/Medicine');

async function listMedicines(req, res) {
  const medicines = await Medicine.find().sort({ category: 1, name: 1 });
  return res.json(medicines);
}

async function updateMedicine(req, res) {
  const { id } = req.params;
  const { quantityDelta = 0, ...updates } = req.body;

  const medicine = await Medicine.findById(id);
  if (!medicine) {
    return res.status(404).json({ message: 'Medicine not found' });
  }

  medicine.stock += quantityDelta;
  Object.assign(medicine, updates);
  await medicine.save();
  return res.json(medicine);
}

module.exports = { listMedicines, updateMedicine };
