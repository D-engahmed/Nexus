import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class MerchantCard extends StatelessWidget {
  final Map<String, dynamic> merchant;
  final VoidCallback onTap;

  const MerchantCard({super.key, required this.merchant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
              child: Image.network(
                merchant['image'] as String,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 110, height: 110,
                  color: AppColors.primary.withAlpha(30),
                  child: const Icon(Icons.restaurant, color: AppColors.primary),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(merchant['name'] as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                        ),
                        if ((merchant['badge'] as String).isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(4)),
                            child: Text(merchant['badge'] as String, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700)),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, size: 14, color: AppColors.rating),
                        Text(' ${merchant['rating']}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                        const SizedBox(width: 4),
                        Text('${merchant['cuisine']} · ', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                        Text('${merchant['deliveryTime']} min', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.delivery_dining_rounded, size: 14, color: (merchant['deliveryFee'] as double) == 0 ? AppColors.accent : AppColors.textHint),
                        const SizedBox(width: 4),
                        Text(
                          (merchant['deliveryFee'] as double) == 0 ? 'Free Delivery' : '\$${merchant['deliveryFee']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: (merchant['deliveryFee'] as double) == 0 ? AppColors.accent : AppColors.textSecondary,
                            fontWeight: (merchant['deliveryFee'] as double) == 0 ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
