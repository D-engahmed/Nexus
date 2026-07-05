import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/order_provider.dart';
import '../../tracking/screens/tracking_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();
    final orders = orderProvider.orders;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('My Orders', style: TextStyle(fontWeight: FontWeight.w800))),
      body: orders.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(color: AppColors.primary.withAlpha(20), shape: BoxShape.circle),
                  child: const Icon(Icons.receipt_long_rounded, size: 40, color: AppColors.primary),
                ),
                const SizedBox(height: 16),
                const Text('No orders yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                const Text('Browse restaurants and place your first order!', style: TextStyle(color: AppColors.textSecondary)),
              ],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            itemCount: orders.length,
            itemBuilder: (_, i) => _OrderCard(order: orders[i]),
          ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final AppOrder order;
  const _OrderCard({required this.order});

  Color _statusColor(String status) {
    switch (status) {
      case 'CONFIRMED': return AppColors.warning;
      case 'DRIVER_ASSIGNED': return AppColors.primary;
      case 'IN_TRANSIT': return AppColors.primary;
      case 'DELIVERED': return AppColors.success;
      default: return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isActive = order.status == 'DRIVER_ASSIGNED' || order.status == 'IN_TRANSIT' || order.status == 'CONFIRMED';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: isActive ? () => Navigator.push(context, MaterialPageRoute(builder: (_) => TrackingScreen(orderId: order.id))) : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(order.merchantImage, width: 44, height: 44, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(order.merchantName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                        Text(order.id, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _statusColor(order.status).withAlpha(20),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(order.status.replaceAll('_', ' '), style: TextStyle(color: _statusColor(order.status), fontSize: 11, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (order.items.isNotEmpty)
                Text('${order.items.first.name}${order.items.length > 1 ? ' + ${order.items.length - 1} more' : ''}',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total: \$${order.total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.textPrimary)),
                  if (isActive)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
                      child: const Text('Track', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
