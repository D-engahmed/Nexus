import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'core/services/simulation_service.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/home/providers/merchant_provider.dart';
import 'features/orders/providers/order_provider.dart';
import 'features/tracking/providers/tracking_provider.dart';
import 'features/profile/providers/profile_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MerchantProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => TrackingProvider()),
        ChangeNotifierProvider(create: (_) => SimulationService()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: const NexusCustomerApp(),
    ),
  );
}
