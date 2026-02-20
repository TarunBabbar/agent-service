import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, state, __) => ListView(
        children: state.orders
            .map(
              (order) => Card(
                child: ListTile(
                  title: Text('Order #${order.id}'),
                  subtitle: Text('Shop: ${order.assignedShop}\nStatus: ${order.status}'),
                  trailing: Text('${order.etaMinutes} min'),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
