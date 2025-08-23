import 'package:flutter/material.dart';
import '../themes/colors.dart';

class FavoriteStoresPage extends StatelessWidget {
  const FavoriteStoresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          '❤️ 단골 가게',
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
        itemCount: _favoriteStores.length,
        itemBuilder: (context, index) {
          return _buildStoreCard(_favoriteStores[index]);
        },
      ),
    );
  }

  Widget _buildStoreCard(Map<String, dynamic> store) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(store['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          store['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: AppColors.error,
                          size: 20,
                        ),
                        onPressed: () {
                          // 찜 해제 로직
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    store['category'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        store['distance'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          store['status'],
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.success,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const List<Map<String, dynamic>> _favoriteStores = [
    {
      'name': '감성커피 양산점',
      'category': '카페 · 디저트',
      'distance': '도보 3분 (180m)',
      'status': '영업중',
      'image': 'assets/coffeeshop_1.jpg',
    },
    {
      'name': '모락로제떡볶이',
      'category': '한식 · 분식',
      'distance': '도보 5분 (320m)',
      'status': '영업중',
      'image': 'assets/tokbokki.jpg',
    },
    {
      'name': '탕화쿵푸마라탕',
      'category': '중식 · 마라탕',
      'distance': '도보 7분 (450m)',
      'status': '준비중',
      'image': 'assets/maratang.jpg',
    },
    {
      'name': '페이지10',
      'category': '카페 · 브런치',
      'distance': '도보 8분 (520m)',
      'status': '영업중',
      'image': 'assets/coffeeshop_2.jpg',
    },
    {
      'name': '모락 김밥',
      'category': '한식 · 분식',
      'distance': '도보 10분 (650m)',
      'status': '영업중',
      'image': 'assets/kimbob.jpg',
    },
  ];
}