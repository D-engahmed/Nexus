import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/dashboard/providers/delivery_provider.dart';
import 'features/navigation/providers/navigation_provider.dart';
import 'features/earnings/providers/earnings_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DeliveryProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => EarningsProvider()),
      ],
      child: const NexusDriverApp(),
    ),
  );
}
