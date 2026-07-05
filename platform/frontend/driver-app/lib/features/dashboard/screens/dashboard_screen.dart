import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/delivery_provider.dart';
import '../widgets/order_card.dart';
import '../../auth/providers/auth_provider.dart';
import '../../navigation/screens/navigation_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deliveryProvider = context.watch<DeliveryProvider>();
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.menu_rounded, size: 24),
                  const Spacer(),
                  const Text('Nexus', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.primary)),
                  const Spacer(),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(auth.user?['photo'] ?? ''),
                    backgroundColor: AppColors.border,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _StatCard(title: "TODAY'S EARNINGS", value: '\$142.50', icon: Icons.attach_money_rounded),
                  const SizedBox(width: 12),
                  _StatCard(title: 'ACTIVE HOURS', value: '6h 12m', icon: Icons.access_time_rounded),
                  const SizedBox(width: 12),
                  _StatCard(title: 'RATING', value: '4.98 ⭐', icon: Icons.star_rounded),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: GestureDetector(
                  onTap: () => auth.toggleOnline(),
                  child: Container(
                    width: 160, height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: auth.online ? AppColors.success : AppColors.border, width: 4),
                      boxShadow: [BoxShadow(color: AppColors.primary.withAlpha(auth.online ? 40 : 10), blurRadius: 20, spreadRadius: 4)],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.power_settings_new_rounded, size: 48, color: auth.online ? AppColors.success : AppColors.textHint),
                        const SizedBox(height: 4),
                        Text(auth.online ? 'Go Offline' : 'Go Online', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: auth.online ? AppColors.success : AppColors.textPrimary)),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  auth.online ? 'You are currently online' : 'You are currently offline',
                  style: TextStyle(color: auth.online ? AppColors.success : AppColors.textSecondary, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(color: AppColors.primary.withAlpha(20), borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.directions_car_rounded, color: AppColors.primary),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Vehicle Status', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                              Text('${auth.user?['vehicle'] ?? 'N/A'}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: AppColors.success.withAlpha(20), borderRadius: BorderRadius.circular(8)),
                          child: const Text('Ready', style: TextStyle(color: AppColors.success, fontSize: 12, fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _VehicleInfo(icon: Icons.local_gas_station_rounded, label: 'Fuel/Range', value: '82% (340 mi)')),
                        const SizedBox(width: 12),
                        Expanded(child: _VehicleInfo(icon: Icons.build_rounded, label: 'Next Service', value: 'In 1,200 mi')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary.withAlpha(60), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(color: AppColors.primary.withAlpha(20), borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.local_fire_department_rounded, color: AppColors.primary),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Demand Alerts', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                              Text('Nearby High-Value Zones', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: AppColors.primary.withAlpha(20), borderRadius: BorderRadius.circular(8)),
                          child: const Text('Active +\$4.50', style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _DemandRow(zone: 'Downtown Core', demand: 'Very High Demand', color: AppColors.primary),
                    const SizedBox(height: 8),
                    _DemandRow(zone: 'Westside Terminal', demand: 'Moderate Demand', color: AppColors.secondary),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Recent Activity', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                        Text('View History', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _ActivityItem(icon: Icons.local_shipping_rounded, title: 'Grocery Delivery #8821', subtitle: 'Completed • 12:45 PM', amount: '+\$18.20', amountColor: AppColors.success),
                    const Divider(height: 20),
                    _ActivityItem(icon: Icons.local_shipping_rounded, title: 'Express Courier #8819', subtitle: 'Completed • 11:30 AM', amount: '+\$24.50', amountColor: AppColors.success),
                  ],
                ),
              ),
              if (deliveryProvider.deliveries.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text('Active Deliveries', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                ...deliveryProvider.deliveries.map((d) => OrderCard(
                  delivery: d,
                  onNavigate: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NavigationScreen(deliveryId: d.id))),
                )),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const _StatCard({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textSecondary, letterSpacing: 0.5)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primary)),
          ],
        ),
      ),
    );
  }
}

class _VehicleInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _VehicleInfo({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
              Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }
}

class _DemandRow extends StatelessWidget {
  final String zone;
  final String demand;
  final Color color;
  const _DemandRow({required this.zone, required this.demand, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 10),
        Text(zone, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        const Spacer(),
        Text(demand, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final Color amountColor;
  const _ActivityItem({required this.icon, required this.title, required this.subtitle, required this.amount, required this.amountColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(color: AppColors.primary.withAlpha(20), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, size: 20, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ],
          ),
        ),
        Text(amount, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: amountColor)),
      ],
    );
  }
}
