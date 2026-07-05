import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/dashboard/screens/dashboard_screen.dart';
import 'features/earnings/screens/earnings_screen.dart';

class NexusDriverApp extends StatelessWidget {
  const NexusDriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexus Driver',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return auth.isAuthenticated ? const DriverMainShell() : const LoginScreen();
        },
      ),
    );
  }
}

class DriverMainShell extends StatefulWidget {
  const DriverMainShell({super.key});

  @override
  State<DriverMainShell> createState() => _DriverMainShellState();
}

class _DriverMainShellState extends State<DriverMainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          DashboardScreen(),
          EarningsScreen(),
          _ProfilePlaceholder(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_rounded), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

class _ProfilePlaceholder extends StatelessWidget {
  const _ProfilePlaceholder();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 48, backgroundImage: NetworkImage(auth.user?['photo'] ?? ''), backgroundColor: AppColors.border),
          const SizedBox(height: 16),
          Text(auth.user?['name'] ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(auth.user?['email'] ?? '', style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star_rounded, size: 18, color: AppColors.rating),
              Text(' ${auth.user?['rating'] ?? ''}', style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(width: 16),
              const Icon(Icons.check_circle_rounded, size: 18, color: AppColors.success),
              Text(' ${auth.user?['totalDeliveries'] ?? ''} deliveries', style: const TextStyle(color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => auth.logout(),
            icon: const Icon(Icons.logout),
            label: const Text('Sign Out'),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
          ),
        ],
      ),
    );
  }
}
