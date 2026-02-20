function getLeastTrafficMinutes(distanceKm) {
  return Math.max(5, Math.round(distanceKm * 3));
}

function estimateDeliveryMinutes(distanceKm) {
  return 30 + getLeastTrafficMinutes(distanceKm);
}

module.exports = { estimateDeliveryMinutes };
