import 'package:flutter/material.dart';
import '../models/stamp.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';

class StampCard extends StatefulWidget {
  final Stamp stamp;
  final VoidCallback? onStampChanged;

  const StampCard({
    super.key,
    required this.stamp,
    this.onStampChanged,
  });

  @override
  State<StampCard> createState() => _StampCardState();
}

class _StampCardState extends State<StampCard> {
  @override
  Widget build(BuildContext context) {
    // Safety check
    if (widget.stamp.stamps.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
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
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left section: Large image
              Container(
                width: 120,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.grey200,
                ),
                child: const Icon(
                  Icons.store,
                  color: AppColors.textSecondary,
                  size: 50,
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Right section: Store info, stamps, and reward
              Expanded(
                child: SizedBox(
                  height: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top section: Store name
                      Text(
                        widget.stamp.storeName,
                        style: AppTypography.cardTitle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      // Middle section: Stamp grid
                      _buildStampGrid(),
                      
                      // Bottom section: Reward text
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.local_offer,
                              size: 14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                widget.stamp.rewardText,
                                style: AppTypography.caption.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStampGrid() {
    const int stampsPerRow = 5;
    const int totalRows = 2;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalRows, (rowIndex) {
        return Padding(
          padding: EdgeInsets.only(bottom: rowIndex < totalRows - 1 ? 8 : 0),
          child: Row(
            children: List.generate(stampsPerRow, (colIndex) {
              final stampIndex = rowIndex * stampsPerRow + colIndex;
              if (stampIndex >= widget.stamp.stamps.length) {
                return Expanded(child: Container(height: 32));
              }
              
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: colIndex < stampsPerRow - 1 ? 8 : 0,
                  ),
                  child: _buildStampCircle(stampIndex),
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  Widget _buildStampCircle(int index) {
    if (index >= widget.stamp.stamps.length) {
      return const SizedBox.shrink();
    }
    
    final isActive = widget.stamp.stamps[index];
    
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.stamp.toggleStamp(index);
        });
        widget.onStampChanged?.call();
      },
      child: SizedBox(
        width: 32,
        height: 32,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.primary : Colors.transparent,
            border: Border.all(
              color: isActive ? AppColors.primary : AppColors.grey400,
              width: 2,
            ),
          ),
          child: isActive
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                )
              : null,
        ),
      ),
    );
  }
}