import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/order_provider.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();
    final cart = orderProvider.cart;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40, height: 4,
                  decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Your Cart', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              ),
              const SizedBox(height: 16),
              if (cart.isEmpty)
                const Expanded(child: Center(child: Text('Cart is empty', style: TextStyle(color: AppColors.textSecondary, fontSize: 15))))
              else
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: cart.length,
                    itemBuilder: (_, i) {
                      final item = cart[i];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(item['image'] as String, width: 50, height: 50, fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['name'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                  Text('\$${(item['price'] as double).toStringAsFixed(2)}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 13)),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                _QuantityButton(
                                  icon: Icons.remove_rounded,
                                  onTap: () => orderProvider.updateQuantity(item['id'] as String, (item['quantity'] as int) - 1),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text('${item['quantity']}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                                ),
                                _QuantityButton(
                                  icon: Icons.add_rounded,
                                  onTap: () => orderProvider.updateQuantity(item['id'] as String, (item['quantity'] as int) + 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              if (cart.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 12, offset: Offset(0, -4))],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                          Text('\$${orderProvider.cartTotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primary)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _showCheckoutSheet(context, orderProvider);
                          },
                          child: const Text('Proceed to Checkout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _showCheckoutSheet(BuildContext context, OrderProvider orderProvider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _CheckoutSheet(orderProvider: orderProvider),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32, height: 32,
        decoration: BoxDecoration(
          color: AppColors.primary.withAlpha(20),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: AppColors.primary),
      ),
    );
  }
}

class _CheckoutSheet extends StatefulWidget {
  final OrderProvider orderProvider;
  const _CheckoutSheet({required this.orderProvider});

  @override
  State<_CheckoutSheet> createState() => _CheckoutSheetState();
}

class _CheckoutSheetState extends State<_CheckoutSheet> {
  final _addressController = TextEditingController(text: '42 Nile St, Garden City');
  String _paymentMethod = 'Cash';

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 16),
          const Text('Checkout', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),
          TextField(controller: _addressController, decoration: const InputDecoration(labelText: 'Delivery Address', prefixIcon: Icon(Icons.location_on_outlined))),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _paymentMethod,
            decoration: const InputDecoration(labelText: 'Payment Method', prefixIcon: Icon(Icons.payment_outlined)),
            items: const [
              DropdownMenuItem(value: 'Cash', child: Text('Cash on Delivery')),
              DropdownMenuItem(value: 'Card', child: Text('Credit Card')),
            ],
            onChanged: (v) => setState(() => _paymentMethod = v!),
          ),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            Text('\$${widget.orderProvider.cartTotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primary)),
          ]),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () { Navigator.pop(context); Navigator.pop(context); },
              child: const Text('Place Order'),
            ),
          ),
        ],
      ),
    );
  }
}
