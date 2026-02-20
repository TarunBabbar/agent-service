import 'dart:math';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

import '../models/medicine.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(baseUrl: 'https://krishnapharmacy.onrender.com'),
  );

  Future<List<Medicine>> fetchMedicines() async {
    final response = await dio.get('/medicines');
    final data = response.data as List<dynamic>;
    return data.map((e) => Medicine.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<Map<String, dynamic>>> fetchShops() async {
    final response = await dio.get('/contact');
    return (response.data as List<dynamic>).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> findBestShopAndEta(Position userPosition) async {
    final shops = await fetchShops();
    Map<String, dynamic>? bestShop;
    double shortestDistance = double.infinity;

    for (final shop in shops) {
      final distance = Geolocator.distanceBetween(
        userPosition.latitude,
        userPosition.longitude,
        (shop['lat'] as num).toDouble(),
        (shop['lng'] as num).toDouble(),
      );
      if (distance < shortestDistance) {
        shortestDistance = distance;
        bestShop = shop;
      }
    }

    final trafficMinutes = shortestDistance == double.infinity
        ? 30
        : max(5, (shortestDistance / 1000 * 3).round());

    return {
      'shop': bestShop,
      'etaMinutes': 30 + trafficMinutes,
      'trafficMinutes': trafficMinutes,
    };
  }

  Future<void> confirmPaymentAndUpdateMedicine(String medicineId, int quantity) async {
    await dio.put('/medicines/$medicineId', data: {'quantityDelta': -quantity});
  }
}
