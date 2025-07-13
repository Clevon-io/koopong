import 'package:flutter/material.dart';

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
        primarySwatch: Colors.orange,
        fontFamily: 'Pretendard',
        
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
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.orange, size: 20),
                  const SizedBox(width: 4),
                  const Text(
                    '양산시 물금읍',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const Icon(Icons.keyboard_arrow_down, size: 20),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      '로그인',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu, color: Colors.grey),
                  ),
                ],
              ),
            ),
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey),
                            SizedBox(width: 8),
                            Text(
                              '여기서 업체 검색',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Recommendation Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '쿠덕이의 강력 추천',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildRecommendationCard(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Popular Stores Section
                    Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Text(
                                  '우리 동네 인기 가게',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text('⏳', style: TextStyle(fontSize: 18)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return _buildPopularStoreCard(index);
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // New Stores Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '우리 동네 신규 상점 (new)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(child: _buildNewStoreCard(0)),
                              const SizedBox(width: 12),
                              Expanded(child: _buildNewStoreCard(1)),
                              const SizedBox(width: 12),
                              Expanded(child: _buildNewStoreCard(2)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Coupon Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '대박 쿠폰 time 긴급 한정',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(child: _buildCouponCard(0)),
                              const SizedBox(width: 12),
                              Expanded(child: _buildCouponCard(1)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80), // Space for bottom navigation
                  ],
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: '스탬프'),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: '내 쿠폰'),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '모락로제뜨뷰이',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  '떡볶이 & 타강정',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('❤️', style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    const Text(
                      '15명 정',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(width: 8),
                    const Text('•', style: TextStyle(color: Colors.grey)),
                    const SizedBox(width: 8),
                    const Text(
                      '걸어서 2분 (150m)',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
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
      {
        'name': '감성커피 양산점',
        'subtitle': '이번 주 첫 30+회',
        'tag': '진짜해요',
        'tagColor': Colors.yellow,
      },
      {
        'name': '탕화쿵푸마라탕',
        'subtitle': '후기 만족도 95%',
        'tag': '맛집 인정',
        'tagColor': Colors.orange,
      },
      {
        'name': '페이지10',
        'subtitle': '이번 주 리뷰 *',
        'tag': '분위기 갓',
        'tagColor': Colors.blue,
      },
    ];

    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: const Icon(Icons.image, color: Colors.grey),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: stores[index]['tagColor'] as Color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    stores[index]['tag'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stores[index]['name'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  stores[index]['subtitle'] as String,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
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

  Widget _buildNewStoreCard(int index) {
    final stores = [
      {
        'name': '모락 떡볶이',
        'subtitle': '떡볶이 & 타강정',
        'tag': '모든 메뉴 10% 할인',
        'tagColor': Colors.orange,
      },
      {
        'name': '모락모락 김밥',
        'subtitle': '김밥 전문점',
        'tag': '출장 서비스',
        'tagColor': Colors.green,
      },
      {
        'name': '모락 카페',
        'subtitle': '디저트 카페',
        'tag': '아메리카노 1+1',
        'tagColor': Colors.blue,
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: const Icon(Icons.image, color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stores[index]['name'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  stores[index]['subtitle'] as String,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: stores[index]['tagColor'] as Color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    stores[index]['tag'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            coupons[index]['name'] as String,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            coupons[index]['discount'] as String,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
