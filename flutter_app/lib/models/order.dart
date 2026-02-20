enum PaymentMethod { cod, qr, gpay }

class Order {
  final String id;
  final String status;
  final String assignedShop;
  final int etaMinutes;

  Order({
    required this.id,
    required this.status,
    required this.assignedShop,
    required this.etaMinutes,
  });
}
