import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Admin Console', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        const ListTile(
          leading: Icon(Icons.edit_note),
          title: Text('Add / Update medicines'),
          subtitle: Text('Inventory and pricing management'),
        ),
        const ListTile(
          leading: Icon(Icons.description),
          title: Text('Review prescriptions'),
          subtitle: Text('Approve or reject prescription-bound orders'),
        ),
        const ListTile(
          leading: Icon(Icons.check_circle),
          title: Text('Approve / Reject / Confirm orders'),
          subtitle: Text('Admin can place or confirm order on behalf of users'),
        ),
        ListTile(
          leading: const Icon(Icons.call),
          title: const Text('Call user'),
          onTap: () => launchUrl(Uri.parse('tel:+919999999999')),
        ),
      ],
    );
  }
}
