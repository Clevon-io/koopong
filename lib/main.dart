import 'package:flutter/material.dart';
import 'themes/colors.dart';
import 'themes/typography.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koopong',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.surface,
        primaryColor: AppColors.primary,
        fontFamily: 'Pretendard',
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.card,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppColors.textSecondary),
        ),
        iconTheme: const IconThemeData(color: AppColors.textSecondary),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              children: [
                const Text('마장동', style: AppTypography.locationText),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 24,
                  color: AppColors.textSecondary,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.qr_code),
                  color: AppColors.textSecondary,
                ),
              ],
            ),
            foregroundColor: AppColors.surface,
            backgroundColor: AppColors.surface,
            surfaceTintColor: AppColors.surface,
            elevation: 0,
            pinned: false,
            floating: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSearchBarWidget(),
                const SizedBox(height: 8),

                // Recommendation Section
                _buildSectionTitle('쿠덕이의 강력 추천'),
                const SizedBox(height: 16),
                _buildRecommendationCard(),
                const SizedBox(height: 24),

                // Popular Stores Section
                _buildSectionTitle('우리 동네 인기 가게 🏆'),
                const SizedBox(height: 16),
                SizedBox(
                  height: 250,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return _buildPopularStoreCard(index);
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // New Stores Section
                _buildSectionTitle('우리 동네 신규 상점 (new)'),
                const SizedBox(height: 16),
                SizedBox(
                  height: 250,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return _buildNewStoreCard(index);
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Coupon Section
                _buildSectionTitle('대박 쿠폰 time ⚡️ 기간 한정'),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return _buildCouponCard(index);
                    },
                  ),
                ),
                const SizedBox(height: 80), // Space for bottom navigation
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: '스탬프'),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: '내 쿠폰'),
        ],
      ),
    );
  }

  Widget _buildSearchBarWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: '여기서 업체 검색',
                hintStyle: AppTypography.searchHint,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: AppTypography.searchHint.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: AppTypography.sectionTitle);
  }

  Widget _buildRecommendationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.image, color: Colors.grey[400], size: 40),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('모락로제떡볶이', style: AppTypography.h4),
                const SizedBox(height: 6),
                const Text('떡볶이 & 닭강정', style: AppTypography.cardSubtitle),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Text('❤️', style: AppTypography.caption),
                    SizedBox(width: 4),
                    Text('15명 찜 · 걸어서 2분 (150m)', style: AppTypography.caption),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularStoreCard(int index) {
    final stores = [
      {'name': '감성커피 양산점', 'subtitle': '이번 주 찜 30+회', 'tag': '👍 친절해요'},
      {'name': '탕화쿵푸마라탕', 'subtitle': '후기 만족도 95%', 'tag': '🔥 맛집인증'},
      {'name': '페이지10', 'subtitle': '이번 주 리뷰 50+', 'tag': '✨ 분위기 깡패'},
    ];

    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.image_outlined,
                color: Colors.grey[400],
                size: 50,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            stores[index]['tag']!,
            style: AppTypography.tag,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            stores[index]['name']!,
            style: AppTypography.cardTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            stores[index]['subtitle']!,
            style: AppTypography.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildNewStoreCard(int index) {
    final stores = [
      {'name': '모락 떡볶이', 'subtitle': '떡볶이 & 닭강정', 'tag': '모든 메뉴 10% 할인'},
      {'name': '모락모락 김밥', 'subtitle': '김밥 전문점', 'tag': '음료수 서비스'},
      {'name': '모락 카페', 'subtitle': '디저트 카페', 'tag': '아메리카노 1+1'},
    ];

    return SizedBox(
      width: 160, // Added fixed width for horizontal ListView
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.image_outlined,
                color: Colors.grey[400],
                size: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stores[index]['name']!,
                  style: AppTypography.cardTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  stores[index]['subtitle']!,
                  style: AppTypography.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  stores[index]['tag']!,
                  style: AppTypography.tag,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponCard(int index) {
    final coupons = [
      {'name': '모락 닭강정', 'discount': '모든 메뉴 20% 할인'},
      {'name': '모락 피자', 'discount': '포장 5,000원 할인'},
    ];

    return Container(
      width: 180, // Added fixed width for horizontal ListView
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.5,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryWithOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Icon(
                Icons.percent,
                color: AppColors.primaryWithOpacity(0.5),
                size: 50,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coupons[index]['name']!,
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  coupons[index]['discount']!,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
