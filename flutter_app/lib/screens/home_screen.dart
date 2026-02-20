import 'package:flutter/material.dart';

import 'admin_screen.dart';
import 'cart_screen.dart';
import 'medicine_list_screen.dart';
import 'orders_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const MedicineListScreen(),
      const CartScreen(),
      const OrdersScreen(),
      const AdminScreen(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Krishna Pharmacy')),
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xFF2E7D32),
        unselectedItemColor: const Color(0xFF333333),
        onTap: (value) => setState(() => currentIndex = value),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.medical_information), label: 'Medicines'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: 'Admin'),
        ],
      ),
    );
  }
}
