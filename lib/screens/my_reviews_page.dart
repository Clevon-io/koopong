import 'package:flutter/material.dart';
import '../themes/colors.dart';

class MyReviewsPage extends StatelessWidget {
  const MyReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          '📝 내가 쓴 리뷰',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        surfaceTintColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _myReviews.length,
        itemBuilder: (context, index) {
          return _buildReviewCard(_myReviews[index]);
        },
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(review['storeImage']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review['storeName'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          ...List.generate(5, (starIndex) {
                            return Icon(
                              starIndex < review['rating']
                                  ? Icons.star
                                  : Icons.star_border,
                              size: 16,
                              color: AppColors.warning,
                            );
                          }),
                          const SizedBox(width: 8),
                          Text(
                            review['date'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        _editReview(review);
                        break;
                      case 'delete':
                        _deleteReview(review);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 16),
                          SizedBox(width: 8),
                          Text('수정'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 16, color: AppColors.error),
                          SizedBox(width: 8),
                          Text('삭제', style: TextStyle(color: AppColors.error)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              review['content'],
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
                height: 1.5,
              ),
            ),
            if (review['photos'] != null && review['photos'].isNotEmpty) ...[
              const SizedBox(height: 12),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: review['photos'].length,
                  itemBuilder: (context, photoIndex) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage(review['photos'][photoIndex]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.thumb_up,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '도움됨 ${review['helpful']}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (review['ownerReply'] != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '사장님 답글',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.success,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            if (review['ownerReply'] != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.store,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '사장님',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      review['ownerReply'],
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _editReview(Map<String, dynamic> review) {
    // 리뷰 수정 로직 (임시)
  }

  void _deleteReview(Map<String, dynamic> review) {
    // 리뷰 삭제 로직 (임시)
  }

  static const List<Map<String, dynamic>> _myReviews = [
    {
      'storeName': '감성커피 양산점',
      'storeImage': 'assets/coffeeshop_1.jpg',
      'rating': 5,
      'date': '2024.08.20',
      'content': '분위기도 좋고 커피도 맛있어요! 직원분들도 친절하시고 자주 올 것 같습니다. 아메리카노가 특히 맛있었어요.',
      'photos': ['assets/coffeeshop_1.jpg'],
      'helpful': 12,
      'ownerReply': '좋은 리뷰 감사합니다! 다음에 오시면 더 맛있는 메뉴도 추천해드릴게요 😊',
    },
    {
      'storeName': '모락로제떡볶이',
      'storeImage': 'assets/tokbokki.jpg',
      'rating': 4,
      'date': '2024.08.18',
      'content': '떡볶이가 정말 맛있어요! 매운 것 좋아하시는 분들께 추천합니다. 가격도 합리적이고 양도 많아요.',
      'photos': ['assets/tokbokki.jpg'],
      'helpful': 8,
      'ownerReply': null,
    },
    {
      'storeName': '탕화쿵푸마라탕',
      'storeImage': 'assets/maratang.jpg',
      'rating': 5,
      'date': '2024.08.15',
      'content': '마라탕 진짜 맛있어요! 재료도 신선하고 국물이 끝내줍니다. 매운맛 조절도 잘해주시고 추천!',
      'photos': null,
      'helpful': 15,
      'ownerReply': '맛있게 드셔주셔서 감사합니다! 다음에도 맛있는 마라탕 드리겠습니다.',
    },
    {
      'storeName': '페이지10',
      'storeImage': 'assets/coffeeshop_2.jpg',
      'rating': 4,
      'date': '2024.08.12',
      'content': '브런치 메뉴가 정말 다양하고 맛있어요. 인테리어도 예쁘고 사진 찍기 좋은 곳입니다.',
      'photos': ['assets/coffeeshop_2.jpg'],
      'helpful': 6,
      'ownerReply': null,
    },
  ];
}