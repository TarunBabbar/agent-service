import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_state.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KrishnaPharmacyApp());
}

class KrishnaPharmacyApp extends StatelessWidget {
  const KrishnaPharmacyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState()..initialize(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Krishna Pharmacy',
        theme: buildKrishnaTheme(),
        home: Consumer<AppState>(
          builder: (_, state, __) =>
              state.isAuthenticated ? const HomeScreen() : const LoginScreen(),
        ),
      ),
    );
  }
}
