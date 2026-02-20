import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../providers/app_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  PaymentMethod method = PaymentMethod.cod;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, state, __) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: state.cart.entries
                    .map(
                      (e) => ListTile(
                        title: Text(e.key.name),
                        subtitle: Text('Qty: ${e.value}'),
                        trailing: Text('₹${(e.key.price * e.value).toStringAsFixed(2)}'),
                      ),
                    )
                    .toList(),
              ),
            ),
            DropdownButton<PaymentMethod>(
              isExpanded: true,
              value: method,
              items: const [
                DropdownMenuItem(value: PaymentMethod.cod, child: Text('Cash on Delivery')),
                DropdownMenuItem(value: PaymentMethod.qr, child: Text('QR Code Payment')),
                DropdownMenuItem(value: PaymentMethod.gpay, child: Text('Google Pay')),
              ],
              onChanged: (value) => setState(() => method = value ?? PaymentMethod.cod),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload Prescription'),
              onPressed: () async {
                final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Prescription uploaded: ${image.name}')),
                  );
                }
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: state.cart.isEmpty
                  ? null
                  : () async {
                      final order = await state.checkout(method);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Order ${order.id} placed. ETA ${order.etaMinutes} mins.')),
                        );
                      }
                    },
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
