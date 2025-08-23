import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../themes/colors.dart';
import 'login_page.dart';
import '../services/auth_service.dart';
import 'notification_settings_page.dart';
import 'location_settings_page.dart';
import 'qr_settings_page.dart';
import 'notice_page.dart';
import 'faq_page.dart';
import 'terms_page.dart';
import 'customer_service_page.dart';
import 'partner_center_page.dart';
import 'favorite_stores_page.dart';
import 'my_reviews_page.dart';
import '../main.dart';

class MyKuponPage extends StatefulWidget {
  const MyKuponPage({super.key});

  @override
  State<MyKuponPage> createState() => _MyKuponPageState();
}

class _MyKuponPageState extends State<MyKuponPage> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.addListener(_onAuthStateChanged);
  }

  @override
  void dispose() {
    _authService.removeListener(_onAuthStateChanged);
    super.dispose();
  }

  void _onAuthStateChanged() {
    setState(() {
      // 로그인 상태 변경 시 UI 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          '😊 MY 쿠퐁',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pretendard',
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        surfaceTintColor: AppColors.surface,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _authService.isLoggedIn ? _buildLoggedInUserSection(context) : _buildUserInfoSection(context),
            if (_authService.isLoggedIn) ...[
              const SizedBox(height: 24),
              _buildMyActivitySection(context),
            ],
            const SizedBox(height: 24),
            _buildAppSettingsSection(context),
            const SizedBox(height: 24),
            _buildCustomerSupportSection(context),
            const SizedBox(height: 32),
            if (_authService.isLoggedIn) ...[
              _buildLogoutButton(context),
              const SizedBox(height: 16),
            ],
            _buildDivider(),
            const SizedBox(height: 24),
            _buildPartnerCenterLink(context),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFF8DC),
            Color(0xFFFFF0B3),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.account_circle_outlined,
            size: 48,
            color: AppColors.primary,
          ),
          const SizedBox(height: 12),
          const Text(
            '로그인이 필요합니다',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '로그인하고 더 많은 혜택을 받아보세요!',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(_createSlideRoute());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                '로그인하기',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoggedInUserSection(BuildContext context) {
    final user = _authService.currentUser;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFF8DC),
            Color(0xFFFFF0B3),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            ),
            child: user?.profileImageUrl != null
                ? ClipOval(
                    child: Image.network(
                      user!.profileImageUrl!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.account_circle,
                          size: 50,
                          color: AppColors.primary,
                        );
                      },
                    ),
                  )
                : const Icon(
                    Icons.account_circle,
                    size: 50,
                    color: AppColors.primary,
                  ),
          ),
          const SizedBox(height: 12),
          Text(
            '${user?.nickname ?? '사용자'}님',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user?.email ?? '',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
              _showProfileEditDialog(context);
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              '프로필 수정',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyActivitySection(BuildContext context) {
    final stats = _authService.getUserStats();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '나의 활동',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildActivityItem(
                    context,
                    Icons.favorite_outline,
                    '단골 가게',
                    stats['favoriteStores']!,
                    () => _navigateToFavoriteStores(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActivityItem(
                    context,
                    Icons.rate_review_outlined,
                    '내가 쓴 리뷰',
                    stats['reviews']!,
                    () => _navigateToMyReviews(context),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildActivityItem(
                    context,
                    Icons.local_play_rounded,
                    '내 쿠폰',
                    stats['coupons']!,
                    () => _navigateToMyCoupons(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActivityItem(
                    context,
                    Icons.verified,
                    '내 스탬프',
                    stats['stamps']!,
                    () => _navigateToMyStamps(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    IconData icon,
    String title,
    int count,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28,
              color: AppColors.primary,
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              count.toString(),
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.primary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () async {
            final confirmed = await _showLogoutConfirmDialog(context);
            if (confirmed == true && context.mounted) {
              await _authService.logout(context);
            }
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.error),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            '로그아웃',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.error,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppSettingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '앱설정',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildSettingsContainer([
          _SettingsItem(
            icon: Icons.notifications_outlined,
            title: '알림 설정',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationSettingsPage()),
            ),
          ),
          _SettingsItem(
            icon: Icons.location_on_outlined,
            title: '위치 서비스 설정',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LocationSettingsPage()),
            ),
          ),
          _SettingsItem(
            icon: Icons.qr_code_scanner,
            title: 'QR 스캔 설정',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QRSettingsPage()),
            ),
          ),
        ]),
      ],
    );
  }

  Widget _buildCustomerSupportSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '고객 지원 및 정보',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildSettingsContainer([
          _SettingsItem(
            icon: Icons.campaign_outlined,
            title: '공지사항',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NoticePage()),
            ),
          ),
          _SettingsItem(
            icon: Icons.help_outline,
            title: '자주 묻는 질문 (FAQ)',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FAQPage()),
            ),
          ),
          _SettingsItem(
            icon: Icons.article_outlined,
            title: '이용약관 및 개인정보처리방침',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TermsPage()),
            ),
          ),
          _SettingsItem(
            icon: Icons.support_agent_outlined,
            title: '고객센터 문의하기',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CustomerServicePage()),
            ),
          ),
          _SettingsItem(
            icon: Icons.info_outline,
            title: '앱 버전 정보',
            trailing: const Text(
              'v1.0.0',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            showArrow: false,
          ),
        ]),
      ],
    );
  }

  Widget _buildSettingsContainer(List<_SettingsItem> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [...items.map((item) => _buildSettingsItem(item))],
      ),
    );
  }

  Widget _buildSettingsItem(_SettingsItem item) {
    return InkWell(
      onTap: item.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.border, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              size: 24,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.title,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            if (item.trailing != null) item.trailing!,
            if (item.showArrow)
              const Icon(
                Icons.chevron_right,
                size: 20,
                color: AppColors.textSecondary,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.divider,
    );
  }

  Widget _buildPartnerCenterLink(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PartnerCenterPage()),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.store_outlined,
              size: 20,
              color: AppColors.primary,
            ),
            const SizedBox(width: 8),
            const Text(
              '사장님이신가요? 쿠퐁 파트너 센터 바로가기',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
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

  // 프로필 수정 다이얼로그
  void _showProfileEditDialog(BuildContext context) {
    final nicknameController = TextEditingController(text: _authService.currentUser?.nickname ?? '');
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('프로필 수정'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nicknameController,
                decoration: const InputDecoration(
                  labelText: '닉네임',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '프로필 사진 변경 기능은 추후 추가될 예정입니다.',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () async {
                await _authService.updateUserProfile(
                  nickname: nicknameController.text.trim(),
                );
                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('프로필이 업데이트되었습니다.'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                }
              },
              child: const Text('저장'),
            ),
          ],
        );
      },
    ).then((_) {
      nicknameController.dispose();
    });
  }

  // 로그아웃 확인 다이얼로그
  Future<bool?> _showLogoutConfirmDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('로그아웃'),
          content: const Text('정말 로그아웃하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: AppColors.error),
              child: const Text('로그아웃'),
            ),
          ],
        );
      },
    );
  }

  // 나의 활동 네비게이션 메서드들
  void _navigateToFavoriteStores(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FavoriteStoresPage()),
    );
  }

  void _navigateToMyReviews(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyReviewsPage()),
    );
  }

  void _navigateToMyCoupons(BuildContext context) {
    // 내 쿠폰 탭으로 실제 이동 (index 2)
    if (kDebugMode) {
      print('Attempting to navigate to My Coupons tab (index 2)');
    }
    HomePage.navigateToTab(2);
  }

  void _navigateToMyStamps(BuildContext context) {
    // 내 스탬프 탭으로 실제 이동 (index 1)
    if (kDebugMode) {
      print('Attempting to navigate to My Stamps tab (index 1)');
    }
    HomePage.navigateToTab(1);
  }
}

class _SettingsItem {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showArrow;

  _SettingsItem({
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
    this.showArrow = true,
  });
}