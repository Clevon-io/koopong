import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// New Color Palette for Light Theme
const Color lightBgColor = Color(0xFFF9F9F9);
const Color cardColor = Colors.white;
const Color primaryColor = Color.fromARGB(255, 222, 168, 6);
const Color textColor = Color(0xFF121212);
const Color subTextColor = Color(0xFF757575);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koopong',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: primaryColor,
        fontFamily: 'Pretendard',
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: cardColor,
          selectedItemColor: primaryColor,
          unselectedItemColor: subTextColor,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: subTextColor),
        ),
        iconTheme: const IconThemeData(color: subTextColor),
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
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(),
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      // Search Bar
                      _buildSearchBar(),
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
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
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
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
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
                        height: 200, // Adjusted height for the new card layout
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return _buildCouponCard(index);
                          },
                        ),
                      ),
                      const SizedBox(height: 80), // Space for bottom navigation
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: primaryColor, size: 20),
          const SizedBox(width: 4),
          const Text(
            '양산시 물금읍',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              fontFamily: 'Pretendard',
              color: textColor,
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, size: 24),
          const Spacer(),
          TextButton(onPressed: () {}, child: const Text('로그인')),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: subTextColor),
          SizedBox(width: 8),
          Text(
            '여기서 업체 검색',
            style: TextStyle(color: subTextColor, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }

  Widget _buildRecommendationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
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
                const Text(
                  '모락로제떡볶이',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 6),
                const Text(
                  '떡볶이 & 닭강정',
                  style: TextStyle(fontSize: 14, color: subTextColor),
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Text('❤️', style: TextStyle(fontSize: 12)),
                    SizedBox(width: 4),
                    Text(
                      '15명 찜 · 걸어서 2분 (150m)',
                      style: TextStyle(fontSize: 12, color: subTextColor),
                    ),
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

    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 120,
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
          const SizedBox(height: 12),
          Text(
            stores[index]['tag']!,
            style: const TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            stores[index]['name']!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            stores[index]['subtitle']!,
            style: const TextStyle(fontSize: 13, color: subTextColor),
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

    return Container(
      width: 130, // Added fixed width for horizontal ListView
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 110,
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stores[index]['name']!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  stores[index]['subtitle']!,
                  style: const TextStyle(fontSize: 12, color: subTextColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  stores[index]['tag']!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
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
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Icon(
              Icons.percent,
              color: primaryColor.withOpacity(0.5),
              size: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coupons[index]['name']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  coupons[index]['discount']!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
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
