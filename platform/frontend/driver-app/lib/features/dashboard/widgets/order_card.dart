import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/delivery_provider.dart';
import 'package:provider/provider.dart';

class OrderCard extends StatelessWidget {
  final AssignedDelivery delivery;
  final VoidCallback onNavigate;

  const OrderCard({super.key, required this.delivery, required this.onNavigate});

  Color _statusColor(String status) {
    switch (status) {
      case 'ASSIGNED': return AppColors.warning;
      case 'PENDING_PICKUP': return AppColors.primary;
      case 'IN_TRANSIT': return AppColors.secondary;
      default: return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(delivery.customerPhoto, width: 40, height: 40, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(delivery.customerName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    Text(delivery.customerAddress, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: _statusColor(delivery.status).withAlpha(20), borderRadius: BorderRadius.circular(8)),
                child: Text(delivery.status.replaceAll('_', ' '), style: TextStyle(color: _statusColor(delivery.status), fontSize: 11, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.store_rounded, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text(delivery.merchantName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              const Spacer(),
              Text(delivery.distance, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          ...delivery.items.take(2).map((item) => Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Row(
              children: [
                Text('${item['quantity']}x', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                const SizedBox(width: 6),
                Text(item['name'] as String, style: const TextStyle(fontSize: 12)),
                const Spacer(),
                Text('\$${(item['price'] as num).toStringAsFixed(2)}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          )),
          if (delivery.items.length > 2)
            Text('+ ${delivery.items.length - 2} more items', style: const TextStyle(fontSize: 11, color: AppColors.textHint)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: \$${delivery.total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              if (delivery.status == 'ASSIGNED')
                ElevatedButton(
                  onPressed: () => context.read<DeliveryProvider>().acceptDelivery(delivery.id),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                  child: const Text('Accept', style: TextStyle(fontSize: 13)),
                )
              else
                ElevatedButton(
                  onPressed: onNavigate,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                  child: const Text('Navigate', style: TextStyle(fontSize: 13)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
