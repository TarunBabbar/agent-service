import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';

class MedicineListScreen extends StatelessWidget {
  const MedicineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, appState, __) {
        if (appState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final grouped = <String, List<dynamic>>{};
        for (final med in appState.medicines) {
          grouped.putIfAbsent(med.category, () => []).add(med);
        }
        return ListView(
          padding: const EdgeInsets.all(12),
          children: grouped.entries
              .map(
                (entry) => ExpansionTile(
                  title: Text(entry.key),
                  children: entry.value
                      .map(
                        (m) => ListTile(
                          leading: m.imageUrl.isNotEmpty
                              ? Image.network(m.imageUrl, width: 48, height: 48, fit: BoxFit.cover)
                              : const Icon(Icons.medication),
                          title: Text(m.name),
                          subtitle: Text('₹${m.price.toStringAsFixed(2)}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.add_circle, color: Color(0xFF2E7D32)),
                            onPressed: () => appState.addToCart(m),
                          ),
                        ),
                      )
                      .toList(),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
