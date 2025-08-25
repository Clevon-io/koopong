import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';
import 'store_detail_page.dart';

enum ViewMode {
  recommendation,
  popular,
  newStore,
  coupon,
}

class StoreListPage extends StatefulWidget {
  final ViewMode viewMode;
  final String title;

  const StoreListPage({
    super.key,
    required this.viewMode,
    required this.title,
  });

  @override
  State<StoreListPage> createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  late List<Map<String, dynamic>> _stores;

  @override
  void initState() {
    super.initState();
    _loadStoreData();
  }

  void _loadStoreData() {
    switch (widget.viewMode) {
      case ViewMode.recommendation:
        _stores = _getRecommendationStores();
        break;
      case ViewMode.popular:
        _stores = _getPopularStores();
        break;
      case ViewMode.newStore:
        _stores = _getNewStores();
        break;
      case ViewMode.coupon:
        _stores = _getCouponStores();
        break;
    }
  }

  List<Map<String, dynamic>> _getRecommendationStores() {
    return [
      {
        'name': '모락로제떡볶이',
        'category': '떡볶이 & 닭강정',
        'image': 'assets/tokbokki.jpg',
        'favorites': 15,
        'distance': '150m',
        'walkingTime': '2분',
      },
      {
        'name': '쿠덕이네 분식당',
        'category': '떡볶이 & 튀김',
        'image': 'assets/tokbokki.jpg',
        'favorites': 28,
        'distance': '200m',
        'walkingTime': '3분',
      },
      {
        'name': '모락 카페',
        'category': '디저트 카페',
        'image': 'assets/coffeeshop_3.jpg',
        'favorites': 42,
        'distance': '300m',
        'walkingTime': '4분',
      },
      {
        'name': '감성커피 양산점',
        'category': '카페 & 디저트',
        'image': 'assets/coffeeshop_1.jpg',
        'favorites': 35,
        'distance': '180m',
        'walkingTime': '2분',
      },
    ];
  }

  List<Map<String, dynamic>> _getPopularStores() {
    return [
      {
        'name': '감성커피 양산점',
        'category': '카페 & 디저트',
        'image': 'assets/coffeeshop_1.jpg',
        'tag': '👍 친절해요',
        'popularityReason': '이번 주 찜 30+회',
      },
      {
        'name': '탕화쿵푸마라탕',
        'category': '중식 & 마라탕',
        'image': 'assets/maratang.jpg',
        'tag': '🔥 맛집인증',
        'popularityReason': '후기 만족도 95%',
      },
      {
        'name': '페이지10',
        'category': '카페 & 브런치',
        'image': 'assets/coffeeshop_2.jpg',
        'tag': '✨ 분위기 깡패',
        'popularityReason': '이번 주 리뷰 50+',
      },
    ];
  }

  List<Map<String, dynamic>> _getNewStores() {
    return [
      {
        'name': '모락모락 김밥',
        'category': '김밥 전문점',
        'image': 'assets/kimbob.jpg',
        'event': '음료수 서비스',
        'openingDate': '신규 오픈',
      },
      {
        'name': '새로운 떡볶이집',
        'category': '떡볶이 & 분식',
        'image': 'assets/tokbokki.jpg',
        'event': '개업 50% 할인',
        'openingDate': '3일전 오픈',
      },
      {
        'name': '프레시 샐러드',
        'category': '샐러드 & 건강식',
        'image': 'assets/coffeeshop_3.jpg',
        'event': '그랜드 오픈 이벤트',
        'openingDate': '일주일전 오픈',
      },
    ];
  }

  List<Map<String, dynamic>> _getCouponStores() {
    return [
      {
        'name': '모락 닭강정',
        'category': '치킨 & 닭강정',
        'image': 'assets/gangaung.jpg',
        'couponContent': '모든 메뉴 20% 할인',
        'couponType': 'discount',
      },
      {
        'name': '모락 피자',
        'category': '피자 & 이탈리안',
        'image': 'assets/pizza.jpg',
        'couponContent': '포장 5,000원 할인',
        'couponType': 'amount',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
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
        itemCount: _stores.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildStoreCard(_stores[index]),
          );
        },
      ),
    );
  }

  Widget _buildStoreCard(Map<String, dynamic> store) {
    switch (widget.viewMode) {
      case ViewMode.recommendation:
        return _buildRecommendationCard(store);
      case ViewMode.popular:
        return _buildPopularCard(store);
      case ViewMode.newStore:
        return _buildNewStoreCard(store);
      case ViewMode.coupon:
        return _buildCouponCard(store);
    }
  }

  Widget _buildRecommendationCard(Map<String, dynamic> store) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StoreDetailPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              constraints: const BoxConstraints(
                minWidth: 60,
                maxWidth: 100,
                minHeight: 60,
                maxHeight: 100,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
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
                  Text(
                    store['name'],
                    style: AppTypography.h4,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    store['category'],
                    style: AppTypography.cardSubtitle,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        size: 16,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${store['favorites']}명 찜',
                        style: AppTypography.caption,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '·',
                        style: AppTypography.caption,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '걸어서 ${store['walkingTime']} (${store['distance']})',
                        style: AppTypography.caption,
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

  Widget _buildPopularCard(Map<String, dynamic> store) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StoreDetailPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              constraints: const BoxConstraints(
                minWidth: 60,
                maxWidth: 100,
                minHeight: 60,
                maxHeight: 100,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
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
                  Text(
                    store['name'],
                    style: AppTypography.h4,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      store['tag'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    store['popularityReason'],
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewStoreCard(Map<String, dynamic> store) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StoreDetailPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(store['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'NEW',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store['name'],
                    style: AppTypography.h4,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    store['category'],
                    style: AppTypography.cardSubtitle,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      store['event'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFFF57C00),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponCard(Map<String, dynamic> store) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StoreDetailPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              constraints: const BoxConstraints(
                minWidth: 60,
                maxWidth: 100,
                minHeight: 60,
                maxHeight: 100,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
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
                  Text(
                    store['name'],
                    style: AppTypography.h4,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.local_offer,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            store['couponContent'],
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}