const express = require('express');
const { listMedicines, updateMedicine } = require('../controllers/medicineController');

const router = express.Router();

router.get('/medicines', listMedicines);
router.put('/medicines/:id', updateMedicine);

module.exports = router;
