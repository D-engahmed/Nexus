import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/simulation_map.dart';
import '../../../core/services/simulation_service.dart';
import '../providers/tracking_provider.dart';

class TrackingScreen extends StatefulWidget {
  final String orderId;
  const TrackingScreen({super.key, required this.orderId});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  void initState() {
    super.initState();
    final simService = context.read<SimulationService>();
    final sim = simService.getSimulation(widget.orderId);
    if (sim != null) context.read<TrackingProvider>().startTracking(widget.orderId, sim);
    simService.addListener(_onUpdate);
  }

  @override
  void dispose() {
    context.read<SimulationService>().removeListener(_onUpdate);
    super.dispose();
  }

  void _onUpdate() {
    if (!mounted) return;
    final sim = context.read<SimulationService>().getSimulation(widget.orderId);
    if (sim != null) context.read<TrackingProvider>().updateFromSimulation(sim);
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TrackingProvider>().trackingData;
    if (data == null) {
      return Scaffold(appBar: AppBar(title: const Text('Live Tracking')), body: const Center(child: Text('Tracking data not available')));
    }

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
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(color: AppColors.primary.withAlpha(20), borderRadius: BorderRadius.circular(6)),
                            child: const Text('ACTIVE LEG', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.primary)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(_statusLabel(data.status), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
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
          if (data.status == 'Picked Up' || data.status == 'In Transit')
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.turn_right_rounded, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Turn Right', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                        Text('onto Main St in ${(data.progress * 500).round()}ft', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SimulationMap(
                merchantLat: data.merchantLat, merchantLng: data.merchantLng,
                customerLat: data.customerLat, customerLng: data.customerLng,
                driverLat: data.driverLat, driverLng: data.driverLng,
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
                        _InfoCard(title: 'ETA', value: '${(data.progress * 15).round()} min', flex: 1),
                        const SizedBox(width: 12),
                        _InfoCard(title: 'DISTANCE', value: '${((1 - data.progress) * 3).toStringAsFixed(1)} km', flex: 1),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(data.driverPhoto, width: 44, height: 44, fit: BoxFit.cover),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(data.driverName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(color: AppColors.primary.withAlpha(20), borderRadius: BorderRadius.circular(6)),
                                      child: Text('ORDER ${data.orderId}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.primary)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(data.vehicleInfo, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('ORDER ITEMS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary, letterSpacing: 0.5)),
                          const SizedBox(height: 8),
                          ...data.timeline.map((t) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text('• ${t['status']}', style: const TextStyle(fontSize: 14)),
                          )),
                          const Divider(),
                          Row(
                            children: [
                              const Icon(Icons.receipt_rounded, size: 16, color: AppColors.textSecondary),
                              const SizedBox(width: 8),
                              Text('Special Note: "Extra napkins requested"', style: TextStyle(fontSize: 13, color: AppColors.primary)),
                            ],
                          ),
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
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(data.status == 'In Transit' ? 'Arrived at Customer' : 'Arrived at Merchant'),
                            const SizedBox(width: 8),
                            const Icon(Icons.chevron_right_rounded),
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

  String _statusLabel(String status) {
    switch (status) {
      case 'Driver Assigned': return 'Heading to Pickup';
      case 'Picked Up': return 'Heading to Pickup';
      case 'In Transit': return 'Heading to Customer';
      case 'Arriving Soon': return 'Arrived at Merchant';
      default: return status;
    }
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final int flex;
  const _InfoCard({required this.title, required this.value, this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
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
