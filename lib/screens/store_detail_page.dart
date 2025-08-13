import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';

class StoreDetailPage extends StatefulWidget {
  const StoreDetailPage({super.key});

  @override
  State<StoreDetailPage> createState() => _StoreDetailPageState();
}

class _StoreDetailPageState extends State<StoreDetailPage> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.surface,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              '쿠덕이네 분식당',
              style: AppTypography.h3.copyWith(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                  _showFavoriteMessage();
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/coffeeshop_4.jpg', // Using a placeholder image
                    fit: BoxFit.cover,
                  ),
                  // Gradient overlay for better text visibility
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.4),
                          Colors.transparent,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // YouTube badge
                  Positioned(
                    bottom: 16,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 14,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.black,
                              size: 10,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            '쿠덕이가 찾아간 가게',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
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

          // Content
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Store name and favorites
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '분식',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text('쿠덕이네 분식당', style: AppTypography.h2),
                          ],
                        ),
                        const Text(
                          '찜 50개',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Rating subtitle
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '이 가게의 칭찬 배지',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Badges
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildBadge('💙', '친절한 사장님'),
                          const SizedBox(width: 8),
                          _buildBadge('🍜', '우리 동네 맛집'),
                          const SizedBox(width: 8),
                          _buildBadge('🔥', '가성비 끝판왕'),
                          const SizedBox(width: 8),
                          _buildBadge('🍽️', '나만의 맛집'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Coupon Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9E6),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFFFE5B4),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            '지금 바로 사용 가능한 쿠폰',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.brown,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            '모든 떡볶이 2,000원 할인!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '~ 2025.06.30 까지',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFD700),
                              foregroundColor: Colors.brown[800],
                              minimumSize: const Size(double.infinity, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              '쿠폰 받기',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              '다른 쿠폰도 보기',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Action Buttons
                    Row(
                      children: [
                        // Menu Button
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.border, width: 1),
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.restaurant_menu,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '메뉴판 보기',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        
                        // Stamp Card Button
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.border, width: 1),
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.card_giftcard,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '스탬프 카드',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Store Introduction
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '가게 소개',
                          style: AppTypography.sectionTitle,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '쿠덕이네 분식당은 30년 전통의 맛집입니다. 신선한 재료로 만든 떡볶이와 김밥이 인기 메뉴이며, 정성스럽게 만든 음식으로 많은 고객분들께 사랑받고 있습니다.',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Basic Store Information
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStoreInfoRow(Icons.place, '서울시 성동구 마장동 123-45'),
                          const SizedBox(height: 12),
                          _buildStoreInfoRow(Icons.access_time, '매일 09:00 - 21:00'),
                          const SizedBox(height: 12),
                          _buildStoreInfoRow(Icons.phone, '02-1234-5678'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Call and Coupon Buttons
                    Row(
                      children: [
                        // Call Button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.grey400,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '전화하기',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        
                        // Coupon Use Button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.confirmation_num,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '쿠폰 사용',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100), // Bottom padding
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String emoji, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.grey700,
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.grey700,
          ),
        ),
      ],
    );
  }

  void _showFavoriteMessage() {
    final message = _isFavorite 
        ? "꽥꽥!! 찜목록에 가게를 추가했어요!"
        : "다음에 만나요!";
    
    final icon = _isFavorite 
        ? Icons.emoji_emotions_rounded
        : Icons.waving_hand;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: _isFavorite ? AppColors.primary : AppColors.grey600,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(
          bottom: 80,
          left: 16,
          right: 16,
          top: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
