import 'package:flutter/material.dart';
import 'dart:async';
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
  final PageController _bannerController = PageController();
  Timer? _bannerTimer;

  @override
  void initState() {
    super.initState();
    _startBannerTimer();
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  void _startBannerTimer() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_bannerController.hasClients) {
        final nextPage = (_bannerController.page?.round() ?? 0) + 1;
        _bannerController.animateToPage(
          nextPage % 3, // Loop back to first banner after the last one
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

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
            floating: false,
          ),
          SliverPersistentHeader(pinned: true, delegate: _SearchBarDelegate()),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 8),
              
              // Banner Section
              _buildBannerSection(),
              const SizedBox(height: 24),
          
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

  Widget _buildSectionTitle(String title) {
    return Text(title, style: AppTypography.sectionTitle);
  }

  Widget _buildBannerSection() {
    final banners = [
      {
        'text': '🎉 신규 가입 시 5,000원 할인',
        'color': AppColors.primary,
      },
      {
        'text': '🍕 오늘의 인기 맛집 TOP 10',
        'color': const Color(0xFFF5576C),
      },
      {
        'text': '⚡ 지금 주문하면 30분 내 도착',
        'color': const Color(0xFF4FACFE),
      },
    ];

    return SizedBox(
      height: 80,
      child: PageView.builder(
        controller: _bannerController,
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: (banner['color'] as Color).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: (banner['color'] as Color).withValues(alpha: 0.2),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  banner['text'] as String,
                  style: TextStyle(
                    color: banner['color'] as Color,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
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
                    fontWeight: FontWeight.w400,
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

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white.withValues(alpha: 0.0),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.search, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '검색...',
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
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 60.0;

  @override
  double get minExtent => 60.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
