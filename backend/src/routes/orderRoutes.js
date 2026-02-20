const express = require('express');
const { createOrder, updateOrderStatus } = require('../controllers/orderController');

const router = express.Router();

router.post('/orders', createOrder);
router.patch('/orders/:id/status', updateOrderStatus);

module.exports = router;
