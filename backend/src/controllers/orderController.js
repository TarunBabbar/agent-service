const Order = require('../models/Order');
const { estimateDeliveryMinutes } = require('../services/etaService');

const shops = [
  { shopName: 'Krishna Pharmacy Main', lat: 17.385, lng: 78.4867 },
  { shopName: 'Krishna Pharmacy East', lat: 17.411, lng: 78.445 },
];

function roughDistanceKm(userLat, userLng, shopLat, shopLng) {
  const dx = userLat - shopLat;
  const dy = userLng - shopLng;
  return Math.sqrt(dx * dx + dy * dy) * 111;
}

function pickNearestShop(location) {
  let best = shops[0];
  let bestDistance = Number.POSITIVE_INFINITY;
  shops.forEach((shop) => {
    const d = roughDistanceKm(location.lat, location.lng, shop.lat, shop.lng);
    if (d < bestDistance) {
      bestDistance = d;
      best = shop;
    }
  });
  return { shop: best, distanceKm: bestDistance };
}

async function createOrder(req, res) {
  const { userId, medicines, paymentMethod, location, prescriptionUrl } = req.body;
  const { shop, distanceKm } = pickNearestShop(location);

  const order = await Order.create({
    userId,
    medicines,
    paymentMethod,
    prescriptionUrl,
    assignedShop: shop.shopName,
    etaMinutes: estimateDeliveryMinutes(distanceKm),
    status: 'pending',
  });

  return res.status(201).json(order);
}

async function updateOrderStatus(req, res) {
  const { id } = req.params;
  const { status } = req.body;
  const order = await Order.findByIdAndUpdate(id, { status }, { new: true });
  return res.json(order);
}

module.exports = { createOrder, updateOrderStatus };
