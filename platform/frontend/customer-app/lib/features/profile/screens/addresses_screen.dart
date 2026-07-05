import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/profile_provider.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addresses = context.watch<ProfileProvider>().addresses;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Saved Addresses')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => _showAddressForm(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: addresses.isEmpty
          ? const Center(
              child: Text(
                'No saved addresses yet',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: addresses.length,
              itemBuilder: (_, i) {
                final a = addresses[i];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              a.label.toLowerCase() == 'home'
                                  ? Icons.home_rounded
                                  : Icons.business_rounded,
                              size: 18,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              a.label,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            if (a.isDefault) ...[
                              const SizedBox(width: 8),
                              Container(
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
                            ],
                            const Spacer(),
                            PopupMenuButton<String>(
                              onSelected: (v) {
                                final provider = context
                                    .read<ProfileProvider>();
                                if (v == 'edit')
                                  _showAddressForm(context, existing: a);
                                if (v == 'default')
                                  provider.setDefaultAddress(a.id);
                                if (v == 'delete') provider.deleteAddress(a.id);
                              },
                              itemBuilder: (_) => [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Text('Edit'),
                                ),
                                if (!a.isDefault)
                                  const PopupMenuItem(
                                    value: 'default',
                                    child: Text('Set as default'),
                                  ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${a.addressLine1}${a.addressLine2.isNotEmpty ? ', ${a.addressLine2}' : ''}, ${a.city}',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        if (a.instructions.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Note: ${a.instructions}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textHint,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showAddressForm(BuildContext context, {Address? existing}) {
    final labelCtrl = TextEditingController(text: existing?.label ?? '');
    final line1Ctrl = TextEditingController(text: existing?.addressLine1 ?? '');
    final line2Ctrl = TextEditingController(text: existing?.addressLine2 ?? '');
    final cityCtrl = TextEditingController(text: existing?.city ?? '');
    final instructionsCtrl = TextEditingController(
      text: existing?.instructions ?? '',
    );
    bool setDefault = existing?.isDefault ?? false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 20,
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      existing == null ? 'Add Address' : 'Edit Address',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: labelCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Label (Home, Work...)',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: line1Ctrl,
                      decoration: const InputDecoration(
                        labelText: 'Address line 1',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: line2Ctrl,
                      decoration: const InputDecoration(
                        labelText: 'Address line 2 (optional)',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: cityCtrl,
                      decoration: const InputDecoration(labelText: 'City'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: instructionsCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Delivery instructions (optional)',
                      ),
                    ),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      value: setDefault,
                      onChanged: (v) =>
                          setSheetState(() => setDefault = v ?? false),
                      title: const Text('Set as default address'),
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (line1Ctrl.text.trim().isEmpty ||
                              cityCtrl.text.trim().isEmpty)
                            return;
                          final provider = sheetContext.read<ProfileProvider>();
                          final address = Address(
                            id:
                                existing?.id ??
                                'addr_${DateTime.now().millisecondsSinceEpoch}',
                            label: labelCtrl.text.trim().isEmpty
                                ? 'Address'
                                : labelCtrl.text.trim(),
                            addressLine1: line1Ctrl.text.trim(),
                            addressLine2: line2Ctrl.text.trim(),
                            city: cityCtrl.text.trim(),
                            isDefault: setDefault,
                            instructions: instructionsCtrl.text.trim(),
                          );
                          if (existing == null) {
                            provider.addAddress(address);
                          } else {
                            provider.updateAddress(address);
                          }
                          Navigator.pop(sheetContext);
                        },
                        child: Text(
                          existing == null ? 'Add Address' : 'Save Changes',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
