import 'package:flutter/material.dart';
import '../themes/colors.dart';
import 'login_page.dart';
import 'notification_settings_page.dart';
import 'location_settings_page.dart';
import 'qr_settings_page.dart';
import 'notice_page.dart';
import 'faq_page.dart';
import 'terms_page.dart';
import 'customer_service_page.dart';
import 'partner_center_page.dart';

class MyKuponPage extends StatelessWidget {
  const MyKuponPage({super.key});

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
            _buildUserInfoSection(context),
            const SizedBox(height: 24),
            _buildAppSettingsSection(context),
            const SizedBox(height: 24),
            _buildCustomerSupportSection(context),
            const SizedBox(height: 32),
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