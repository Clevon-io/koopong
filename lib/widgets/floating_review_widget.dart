import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';
import '../themes/spacing.dart';

class FloatingReviewWidget extends StatelessWidget {
  final String storeId;
  final String storeName;
  final String storeImageUrl;
  final VoidCallback onTap;

  const FloatingReviewWidget({
    super.key,
    required this.storeId,
    required this.storeName,
    required this.storeImageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFFFBE6),
              const Color(0xFFFFF4CC),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFFFD700).withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            // 가게 이미지 (원형)
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFFFD700).withValues(alpha: 0.5),
                  width: 2,
                ),
                image: DecorationImage(
                  image: AssetImage(storeImageUrl),
                  fit: BoxFit.cover,
                  onError: (error, stackTrace) {
                    // 이미지 로드 실패 시 기본 아이콘 표시
                  },
                ),
              ),
              child: storeImageUrl.isEmpty 
                ? const Icon(
                    Icons.store,
                    color: AppColors.primary,
                    size: 24,
                  )
                : null,
            ),
            
            SizedBox(width: AppSpacing.md),
            
            // 메시지 텍스트
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.edit,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: AppSpacing.xs),
                      Text(
                        '리뷰 작성하기',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    '$storeName에서의 경험을\n따뜻한 응원의 한마디로 남겨보세요!',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            SizedBox(width: AppSpacing.sm),
            
            // 화살표 아이콘
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 애니메이션이 있는 플로팅 리뷰 위젯
class AnimatedFloatingReviewWidget extends StatefulWidget {
  final String storeId;
  final String storeName;
  final String storeImageUrl;
  final VoidCallback onTap;
  final bool isVisible;

  const AnimatedFloatingReviewWidget({
    super.key,
    required this.storeId,
    required this.storeName,
    required this.storeImageUrl,
    required this.onTap,
    this.isVisible = true,
  });

  @override
  State<AnimatedFloatingReviewWidget> createState() => _AnimatedFloatingReviewWidgetState();
}

class _AnimatedFloatingReviewWidgetState extends State<AnimatedFloatingReviewWidget>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    // 슬라이드 애니메이션 컨트롤러
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    // 펄스 애니메이션 컨트롤러
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    // 아래에서 위로 슬라이드
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));
    
    // 부드러운 펄스 효과
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    // 위젯이 보일 때 애니메이션 시작
    if (widget.isVisible) {
      _slideController.forward();
      
      // 3초 후 펄스 애니메이션 시작 (반복)
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          _pulseController.repeat(reverse: true);
        }
      });
    }
  }

  @override
  void didUpdateWidget(AnimatedFloatingReviewWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        _slideController.forward();
      } else {
        _slideController.reverse();
        _pulseController.stop();
      }
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: kBottomNavigationBarHeight + 16, // 네비게이션바 + 여백
      left: AppSpacing.md,
      right: AppSpacing.md,
      child: SlideTransition(
        position: _slideAnimation,
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: FloatingReviewWidget(
                storeId: widget.storeId,
                storeName: widget.storeName,
                storeImageUrl: widget.storeImageUrl,
                onTap: widget.onTap,
              ),
            );
          },
        ),
      ),
    );
  }
}