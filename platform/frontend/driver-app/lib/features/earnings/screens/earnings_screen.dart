import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/earnings_provider.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final earnings = context.watch<EarningsProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Earnings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Earnings', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 8),
                  Text('\$${earnings.monthEarnings.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatBadge(label: 'Today', value: '\$${earnings.todayEarnings.toStringAsFixed(0)}', icon: Icons.today_rounded),
                      _StatBadge(label: 'Week', value: '\$${earnings.weekEarnings.toStringAsFixed(0)}', icon: Icons.date_range_rounded),
                      _StatBadge(label: 'Month', value: '\$${earnings.monthEarnings.toStringAsFixed(0)}', icon: Icons.calendar_month_rounded),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _SummaryCard(title: 'Deliveries', value: '${earnings.todayDeliveries}', subtitle: 'Today', icon: Icons.delivery_dining_rounded, color: AppColors.primary)),
                const SizedBox(width: 12),
                Expanded(child: _SummaryCard(title: 'Rating', value: '${earnings.rating}', subtitle: '${earnings.totalDeliveries} total', icon: Icons.star_rounded, color: AppColors.rating)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _SummaryCard(title: 'This Week', value: '${earnings.weekDeliveries}', subtitle: 'deliveries', icon: Icons.date_range_rounded, color: AppColors.secondary)),
                const SizedBox(width: 12),
                Expanded(child: _SummaryCard(title: 'This Month', value: '${earnings.monthDeliveries}', subtitle: 'deliveries', icon: Icons.calendar_month_rounded, color: AppColors.warning)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatBadge({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _SummaryCard({required this.title, required this.value, required this.subtitle, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
            Text(subtitle, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
