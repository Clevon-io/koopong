import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'themes/colors.dart';
import 'themes/typography.dart';
import 'screens/store_detail_page.dart';
import 'screens/my_coupons_page.dart';
import 'screens/my_kupon_page.dart';
import 'screens/my_stamps_page.dart';
import 'screens/login_page.dart';
import 'screens/login_required_page.dart';
import 'screens/store_stamp_detail_page.dart';
import 'screens/store_review_page.dart';
import 'widgets/floating_review_widget.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // AuthService 초기화
  await AuthService().initializeAuth();
  
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
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        primaryColor: AppColors.primary,
        fontFamily: 'Pretendard',
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.card,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: AppTypography.bodySmall,
          unselectedLabelStyle: AppTypography.bodySmall,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppColors.textSecondary),
        ),
        iconTheme: const IconThemeData(color: AppColors.textSecondary),
      ),
      home: HomePage(key: _homePageKey),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  // 외부에서 탭 이동을 위한 static 메서드
  static void navigateToTab(int index) {
    if (kDebugMode) {
      print('HomePage.navigateToTab called with index: $index');
      print('_homePageKey.currentState: ${_homePageKey.currentState}');
    }
    _homePageKey.currentState?._switchToTab(index);
  }
}

// GlobalKey를 클래스 외부에서 선언
final GlobalKey<_HomePageState> _homePageKey = GlobalKey<_HomePageState>();

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _bannerController = PageController();
  Timer? _bannerTimer;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _startBannerTimer();
    
    // AuthService 변경사항 리스닝
    _authService.addListener(_onAuthStateChanged);
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    _authService.removeListener(_onAuthStateChanged);
    super.dispose();
  }

  void _onAuthStateChanged() {
    setState(() {
      // 로그인 상태 변경 시 UI 업데이트
    });
  }

  void _startBannerTimer() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_bannerController.hasClients) {
        final nextPage = (_bannerController.page?.round() ?? 0) + 1;
        _bannerController.animateToPage(
          nextPage % 3, // Loop back to first banner after the last one
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // 탭 이동 메서드
  void _switchToTab(int index) {
    if (kDebugMode) {
      print('Switching to tab: $index');
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _getSelectedPage(),
          // 스탬프 탭에서만 플로팅 리뷰 위젯 표시
          if (_selectedIndex == 1 && _authService.isLoggedIn) _buildFloatingReviewWidget(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          // 스탬프와 내 쿠폰 탭은 로그인이 필요
          if ((index == 1 || index == 2) && !_authService.isLoggedIn) {
            setState(() {
              _selectedIndex = index;
            });
            return;
          }
          
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.verified), label: '스탬프'),
          BottomNavigationBarItem(icon: Icon(Icons.local_play_rounded), label: '내 쿠폰'),
          BottomNavigationBarItem(icon: Icon(Icons.mood), label: 'MY 쿠퐁'),
        ],
      ),
    );
  }

  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        if (!_authService.isLoggedIn) {
          return const LoginRequiredPage(
            featureName: '🏆 내 스탬프',
            icon: Icons.verified,
            description: '스탬프를 적립하고 무료 음료와 할인 혜택을 받아보세요!\n로그인하면 나만의 스탬프 현황을 확인할 수 있어요.',
          );
        }
        return const MyStampsPage();
      case 2:
        if (!_authService.isLoggedIn) {
          return const LoginRequiredPage(
            featureName: '내 쿠폰',
            icon: Icons.local_play_rounded,
            description: '받은 쿠폰을 관리하고 할인 혜택을 놓치지 마세요!\n로그인하면 쿠폰 사용 기한과 혜택을 한눈에 볼 수 있어요.',
          );
        }
        return const MyCouponsPage();
      case 3:
        return const MyKuponPage();
      default:
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Row(
            children: [
              const Icon(
                Icons.place,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: 6),
              const Text('마장동', style: AppTypography.locationText),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 24,
                color: AppColors.textSecondary,
              ),
              const Spacer(),
              if (!_authService.isLoggedIn) ...[
                TextButton(
                  onPressed: () async {
                    await _authService.tempLogin(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  ),
                  child: const Text(
                    '임시 로그인',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(_createSlideRoute());
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  ),
                  child: const Text(
                    '로그인',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ] else ...[
                Text(
                  '${_authService.currentUser?.nickname ?? '사용자'}님',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
              const SizedBox(width: 8),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 3,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return _buildPopularStoreCard(index);
                },
              ),
            ),
            const SizedBox(height: 16),

            // Banner Section
            _buildBannerSection(),
            const SizedBox(height: 16),

            // New Stores Section
            _buildSectionTitle('우리 동네 신규 상점'),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTypography.sectionTitle),
          GestureDetector(
            onTap: () {
              // Navigate to view all page
            },
            child: Row(
              children: [
                Text(
                  '전체 보기',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 2),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSection() {
    final banners = [
      {'text': '🎉 신규 가입 시 5,000원 할인', 'color': AppColors.primary},
      {'text': '🍕 오늘의 인기 맛집 TOP 10', 'color': const Color(0xFFF5576C)},
      {'text': '⚡ 지금 주문하면 30분 내 도착', 'color': const Color(0xFF4FACFE)},
    ];

    return SizedBox(
      height: 80,
      child: PageView.builder(
        controller: _bannerController,
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      banner['text'] as String,
                      style: TextStyle(
                        color: banner['color'] as Color,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '배너 이미지 프리뷰 입니다.',
                      style: TextStyle(
                        color: (banner['color'] as Color).withValues(
                          alpha: 0.7,
                        ),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecommendationCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StoreDetailPage()),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
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
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage('assets/tokbokki.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
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
                        Text(
                          '15명 찜 · 걸어서 2분 (150m)',
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
      ),
    );
  }

  Widget _buildPopularStoreCard(int index) {
    final stores = [
      {
        'name': '감성커피 양산점',
        'subtitle': '이번 주 찜 30+회',
        'tag': '👍 친절해요',
        'image': 'assets/coffeeshop_1.jpg',
      },
      {
        'name': '탕화쿵푸마라탕',
        'subtitle': '후기 만족도 95%',
        'tag': '🔥 맛집인증',
        'image': 'assets/maratang.jpg',
      },
      {
        'name': '페이지10',
        'subtitle': '이번 주 리뷰 50+',
        'tag': '✨ 분위기 깡패',
        'image': 'assets/coffeeshop_2.jpg',
      },
    ];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StoreDetailPage()),
        );
      },
      child: SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(stores[index]['image'] as String),
                    fit: BoxFit.cover,
                  ),
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
      ),
    );
  }

  Widget _buildNewStoreCard(int index) {
    final stores = [
      {
        'name': '모락 떡볶이',
        'subtitle': '떡볶이 & 닭강정',
        'tag': '모든 메뉴 10% 할인',
        'image': 'assets/tokbokki.jpg',
      },
      {
        'name': '모락모락 김밥',
        'subtitle': '김밥 전문점',
        'tag': '음료수 서비스',
        'image': 'assets/kimbob.jpg',
      },
      {
        'name': '모락 카페',
        'subtitle': '디저트 카페',
        'tag': '아메리카노 1+1',
        'image': 'assets/coffeeshop_3.jpg',
      },
    ];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StoreDetailPage()),
        );
      },
      child: SizedBox(
        width: 160, // Added fixed width for horizontal ListView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(stores[index]['image'] as String),
                    fit: BoxFit.cover,
                  ),
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
      ),
    );
  }

  Widget _buildCouponCard(int index) {
    final coupons = [
      {
        'name': '모락 닭강정',
        'discount': '모든 메뉴 20% 할인',
        'image': 'assets/gangaung.jpg',
      },
      {
        'name': '모락 피자',
        'discount': '포장 5,000원 할인',
        'image': 'assets/pizza.jpg',
      },
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
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: AssetImage(coupons[index]['image'] as String),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(),
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

  Route _createSlideRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeOutCubic;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  Widget _buildFloatingReviewWidget() {
    // 임시 스탬프 데이터 - 실제로는 MyStampsPage에서 가져와야 함
    return AnimatedFloatingReviewWidget(
      storeId: 'store_001',
      storeName: '감성커피 양산점',
      storeImageUrl: 'assets/coffeeshop_1.jpg',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StoreReviewPage(
              storeId: 'store_001',
              storeName: '감성커피 양산점',
              storeImageUrl: 'assets/coffeeshop_1.jpg',
            ),
          ),
        );
      },
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
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.white.withValues(alpha: 0.0)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
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
  double get maxExtent => 55.0;

  @override
  double get minExtent => 55.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
