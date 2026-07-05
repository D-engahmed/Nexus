import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/profile_provider.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  IconData _iconFor(String type) {
    switch (type) {
      case 'card':
        return Icons.credit_card_rounded;
      case 'wallet':
        return Icons.account_balance_wallet_rounded;
      default:
        return Icons.payments_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final methods = context.watch<ProfileProvider>().paymentMethods;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Payment Methods')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => _showAddCardSheet(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.warning.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Mock data only — no real card number is captured or stored. Live payments require a PCI-compliant gateway integration.',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ),
          Expanded(
            child: methods.isEmpty
                ? const Center(
                    child: Text(
                      'No payment methods saved',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: methods.length,
                    itemBuilder: (_, i) {
                      final m = methods[i];
                      return Card(
                        child: ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withAlpha(20),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              _iconFor(m.type),
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            m.displayLabel,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          subtitle: m.type == 'card'
                              ? Text(
                                  'Expires ${m.expiryMonth.toString().padLeft(2, '0')}/${m.expiryYear}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                )
                              : null,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (m.isDefault)
                                Container(
                                  margin: const EdgeInsets.only(right: 4),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.success.withAlpha(20),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'DEFAULT',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.success,
                                    ),
                                  ),
                                ),
                              PopupMenuButton<String>(
                                onSelected: (v) {
                                  final provider = context
                                      .read<ProfileProvider>();
                                  if (v == 'default')
                                    provider.setDefaultPaymentMethod(m.id);
                                  if (v == 'delete')
                                    provider.deletePaymentMethod(m.id);
                                },
                                itemBuilder: (_) => [
                                  if (!m.isDefault)
                                    const PopupMenuItem(
                                      value: 'default',
                                      child: Text('Set as default'),
                                    ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Remove'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showAddCardSheet(BuildContext context) {
    final brandCtrl = TextEditingController();
    final last4Ctrl = TextEditingController();
    final monthCtrl = TextEditingController();
    final yearCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Mock Card',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),
              const Text(
                'For UI testing only — not a real card entry form.',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: brandCtrl,
                decoration: const InputDecoration(
                  labelText: 'Brand (Visa, Mastercard...)',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: last4Ctrl,
                maxLength: 4,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Last 4 digits'),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: monthCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'MM'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: yearCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'YYYY'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (brandCtrl.text.trim().isEmpty ||
                        last4Ctrl.text.trim().length != 4)
                      return;
                    sheetContext.read<ProfileProvider>().addPaymentMethod(
                      PaymentMethod(
                        id: 'pm_${DateTime.now().millisecondsSinceEpoch}',
                        type: 'card',
                        brand: brandCtrl.text.trim(),
                        last4: last4Ctrl.text.trim(),
                        expiryMonth: int.tryParse(monthCtrl.text.trim()) ?? 12,
                        expiryYear:
                            int.tryParse(yearCtrl.text.trim()) ??
                            DateTime.now().year + 2,
                      ),
                    );
                    Navigator.pop(sheetContext);
                  },
                  child: const Text('Add Card'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
