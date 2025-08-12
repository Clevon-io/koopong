import 'package:flutter/material.dart';
import '../models/coupon.dart';
import '../widgets/coupon_card.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';

class MyCouponsPage extends StatefulWidget {
  const MyCouponsPage({super.key});

  @override
  State<MyCouponsPage> createState() => _MyCouponsPageState();
}

class _MyCouponsPageState extends State<MyCouponsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Test data
  final List<Coupon> _allCoupons = [
    // Available coupon - 5 days left
    Coupon(
      id: '1',
      storeName: '모락로제떡볶이',
      description: '모든 떡볶이 2,000원 할인',
      expiryDate: DateTime.now().add(const Duration(days: 5)),
      imageUrl: '',
      status: CouponStatus.available,
    ),
    // Available coupon - expiring today
    Coupon(
      id: '2',
      storeName: '감성커피 양산점',
      description: '아메리카노 1+1 이벤트',
      expiryDate: DateTime.now(),
      imageUrl: '',
      status: CouponStatus.available,
    ),
    // Used coupon
    Coupon(
      id: '3',
      storeName: '탕화쿵푸마라탕',
      description: '마라탕 5,000원 할인',
      expiryDate: DateTime.now().subtract(const Duration(days: 2)),
      imageUrl: '',
      status: CouponStatus.used,
    ),
    // Expired coupon
    Coupon(
      id: '4',
      storeName: '페이지10',
      description: '디저트 세트 20% 할인',
      expiryDate: DateTime.now().subtract(const Duration(days: 10)),
      imageUrl: '',
      status: CouponStatus.expired,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Coupon> get _availableCoupons =>
      _allCoupons.where((c) => c.status == CouponStatus.available).toList();

  List<Coupon> get _usedCoupons =>
      _allCoupons.where((c) => c.status == CouponStatus.used).toList();

  List<Coupon> get _expiredCoupons =>
      _allCoupons.where((c) => c.status == CouponStatus.expired).toList();

  String _getCountText(int count) {
    if (count == 0) return '';
    return ' $count';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          '내 쿠폰함',
          style: AppTypography.h3,
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        surfaceTintColor: AppColors.surface,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            color: AppColors.surface,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              indicatorWeight: 2,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Pretendard',
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Pretendard',
              ),
              tabs: [
                Tab(text: '사용 가능${_getCountText(_availableCoupons.length)}'),
                Tab(text: '사용 완료${_getCountText(_usedCoupons.length)}'),
                Tab(text: '기간 만료${_getCountText(_expiredCoupons.length)}'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCouponList(_availableCoupons),
          _buildCouponList(_usedCoupons),
          _buildCouponList(_expiredCoupons),
        ],
      ),
    );
  }

  Widget _buildCouponList(List<Coupon> coupons) {
    if (coupons.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_offer_outlined,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              '쿠폰이 없습니다',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, bottom: 80),
      itemCount: coupons.length,
      itemBuilder: (context, index) {
        return CouponCard(
          coupon: coupons[index],
          onUseTap: () => _onCouponUseTap(coupons[index]),
        );
      },
    );
  }

  void _onCouponUseTap(Coupon coupon) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('쿠폰 사용'),
        content: Text('${coupon.storeName}의 "${coupon.description}" 쿠폰을 사용하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement coupon usage logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('쿠폰이 사용되었습니다!')),
              );
            },
            child: const Text('사용하기'),
          ),
        ],
      ),
    );
  }
}