import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/navigation_provider.dart';
import '../widgets/route_map.dart';
import '../../dashboard/providers/delivery_provider.dart';

class NavigationScreen extends StatefulWidget {
  final String deliveryId;
  const NavigationScreen({super.key, required this.deliveryId});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  void initState() {
    super.initState();
    final d = context.read<DeliveryProvider>().deliveries.firstWhere((d) => d.id == widget.deliveryId);
    context.read<NavigationProvider>().startNavigation(d.merchantLat, d.merchantLng, d.customerLat, d.customerLng);
  }

  @override
  void dispose() {
    context.read<NavigationProvider>().stopNavigation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();
    final delivery = context.watch<DeliveryProvider>().deliveries.firstWhere((d) => d.id == widget.deliveryId);
    final isToMerchant = nav.currentPhase == 'to_merchant';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 8, 16, 12),
            color: Colors.white,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.arrow_back_rounded, size: 20),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: AppColors.primary.withAlpha(20), borderRadius: BorderRadius.circular(6)),
                        child: const Text('ACTIVE LEG', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.primary)),
                      ),
                      const SizedBox(height: 2),
                      Text(isToMerchant ? 'Heading to Pickup' : 'Heading to Customer', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: AppColors.background, shape: BoxShape.circle),
                  child: const Icon(Icons.help_outline_rounded, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(14)),
            child: Row(
              children: [
                const Icon(Icons.turn_right_rounded, color: Colors.white, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Turn Right', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700)),
                      Text('onto Main St in ${(nav.progress * 500).round()}ft', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RouteMap(
                merchantLat: delivery.merchantLat, merchantLng: delivery.merchantLng,
                customerLat: delivery.customerLat, customerLng: delivery.customerLng,
                phase: nav.currentPhase,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 12, offset: Offset(0, -4))],
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _InfoCard(title: 'ETA', value: '${(nav.progress * 15).round()} min'),
                        const SizedBox(width: 12),
                        _InfoCard(title: 'DISTANCE', value: '${((1 - nav.progress) * 3).toStringAsFixed(1)} km'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(14)),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(delivery.customerPhoto, width: 44, height: 44, fit: BoxFit.cover),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(delivery.merchantName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(color: AppColors.primary.withAlpha(20), borderRadius: BorderRadius.circular(6)),
                                      child: Text('ORDER ${delivery.id}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.primary)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(delivery.merchantAddress, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('ORDER ITEMS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary, letterSpacing: 0.5)),
                          const SizedBox(height: 8),
                          ...delivery.items.map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text('• ${item['quantity']}x ${item['name']}', style: const TextStyle(fontSize: 14)),
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.navigation_rounded, size: 18),
                            label: const Text('Navigate'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.chat_rounded, size: 18),
                            label: const Text('Contact'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isToMerchant) {
                            context.read<DeliveryProvider>().pickupComplete(widget.deliveryId);
                          } else {
                            context.read<DeliveryProvider>().markDelivered(widget.deliveryId);
                            Navigator.pop(context);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(isToMerchant ? 'Arrived at Merchant' : 'Confirm Delivery'),
                            const SizedBox(width: 8),
                            Icon(isToMerchant ? Icons.chevron_right_rounded : Icons.check_rounded),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  const _InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary, letterSpacing: 0.5)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.primary)),
          ],
        ),
      ),
    );
  }
}
