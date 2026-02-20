import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../models/medicine.dart';
import '../models/order.dart';
import '../services/api_service.dart';

class AppState extends ChangeNotifier {
  final ApiService _api = ApiService();

  bool isAuthenticated = false;
  bool isAdmin = false;
  bool isLoading = false;

  final List<Medicine> medicines = [];
  final Map<Medicine, int> cart = {};
  final List<Order> orders = [];
  String? prescriptionPath;

  Future<void> initialize() async {
    await loadMedicines();
  }

  Future<void> loginWithOtp(String phone, String otp) async {
    isAuthenticated = otp.length == 6;
    notifyListeners();
  }

  Future<void> loginWithGmail() async {
    isAuthenticated = true;
    notifyListeners();
  }

  Future<void> loadMedicines() async {
    isLoading = true;
    notifyListeners();
    medicines
      ..clear()
      ..addAll(await _api.fetchMedicines());
    isLoading = false;
    notifyListeners();
  }

  void addToCart(Medicine medicine) {
    cart.update(medicine, (qty) => qty + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void removeFromCart(Medicine medicine) {
    final existing = cart[medicine] ?? 0;
    if (existing <= 1) {
      cart.remove(medicine);
    } else {
      cart[medicine] = existing - 1;
    }
    notifyListeners();
  }

  Future<Order> checkout(PaymentMethod method) async {
    final position = await _getCurrentLocation();
    final selection = await _api.findBestShopAndEta(position);
    for (final entry in cart.entries) {
      await _api.confirmPaymentAndUpdateMedicine(entry.key.id, entry.value);
    }
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      status: 'Placed',
      assignedShop: selection['shop']?['shopName'] ?? 'Nearest Shop',
      etaMinutes: selection['etaMinutes'] as int,
    );
    orders.insert(0, order);
    cart.clear();
    notifyListeners();
    return order;
  }

  Future<Position> _getCurrentLocation() async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      throw Exception('Location services are disabled');
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return Geolocator.getCurrentPosition();
  }
}
