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
    final isAvailable = coupon.status == CouponStatus.available;
    
    if (isAvailable) {
      return _buildAvailableCouponCard();
    } else {
      return _buildInactiveCouponCard();
    }
  }

  Widget _buildAvailableCouponCard() {
    final isUrgent = coupon.isExpiringToday;
    final borderColor = isUrgent ? AppColors.urgent : AppColors.primary;
    final buttonColor = isUrgent ? AppColors.urgent : AppColors.primary;
    final descriptionColor = isUrgent ? AppColors.urgent : AppColors.primary;

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
                        style: AppTypography.cardTitle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        coupon.description,
                        style: AppTypography.cardSubtitle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: descriptionColor,
                        ),
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
                  onPressed: onUseTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.qr_code_sharp,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        '사용하기',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInactiveCouponCard() {
    final borderColor = AppColors.disabled;
    final statusText = coupon.status == CouponStatus.used ? '사용완료' : '만료됨';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.disabledLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.3),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Coupon image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.grey300,
              ),
              child: Icon(
                Icons.local_offer,
                color: AppColors.disabled,
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
                    style: AppTypography.cardTitle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.disabled,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    coupon.description,
                    style: AppTypography.cardSubtitle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.disabled,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    coupon.formattedExpiryDate,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.disabled,
                    ),
                  ),
                ],
              ),
            ),
            
            // Status indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.grey200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                statusText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.disabled,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}