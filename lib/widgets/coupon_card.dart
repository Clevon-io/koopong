import 'package:flutter/material.dart';
import '../models/coupon.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';

class CouponCard extends StatelessWidget {
  final Coupon coupon;
  final VoidCallback? onUseTap;

  const CouponCard({
    super.key,
    required this.coupon,
    this.onUseTap,
  });

  @override
  Widget build(BuildContext context) {
    final isUrgent = coupon.isExpiringToday;
    final borderColor = isUrgent ? AppColors.urgent : AppColors.primary;
    final buttonColor = isUrgent ? AppColors.urgent : AppColors.primary;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Main content row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Coupon image
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.grey200,
                  ),
                  child: const Icon(
                    Icons.local_offer,
                    color: AppColors.textSecondary,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 12),
                
                // Store info and coupon details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coupon.storeName,
                        style: AppTypography.cardTitle,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        coupon.description,
                        style: AppTypography.cardSubtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        coupon.formattedExpiryDate,
                        style: AppTypography.caption,
                      ),
                    ],
                  ),
                ),
                
                // D-Day indicator
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isUrgent ? AppColors.urgentLight : AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    coupon.dDayText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: borderColor,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Divider
            Container(
              height: 1,
              color: AppColors.divider,
            ),
            
            const SizedBox(height: 12),
            
            // Use button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _getButtonCallback(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    elevation: 0,
                  ),
                  child: Text(
                    _getButtonText(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  VoidCallback? _getButtonCallback() {
    switch (coupon.status) {
      case CouponStatus.available:
        return onUseTap;
      case CouponStatus.used:
      case CouponStatus.expired:
        return null;
    }
  }

  String _getButtonText() {
    switch (coupon.status) {
      case CouponStatus.available:
        return '사용하기';
      case CouponStatus.used:
        return '사용완료';
      case CouponStatus.expired:
        return '만료됨';
    }
  }
}