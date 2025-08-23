import 'package:flutter/material.dart';
import '../themes/colors.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _pushNotification = true;
  bool _couponNotification = true;
  bool _stampNotification = true;
  bool _eventNotification = false;
  bool _marketingNotification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          '알림 설정',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildSettingsSection(),
            const SizedBox(height: 24),
            _buildDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            title: '푸시 알림 허용',
            subtitle: '앱 알림을 받으시려면 활성화해주세요',
            value: _pushNotification,
            onChanged: (value) {
              setState(() {
                _pushNotification = value;
              });
            },
          ),
          _buildDivider(),
          _buildSwitchTile(
            title: '쿠폰 알림',
            subtitle: '새로운 쿠폰과 할인 정보를 받아보세요',
            value: _couponNotification,
            onChanged: (value) {
              setState(() {
                _couponNotification = value;
              });
            },
          ),
          _buildDivider(),
          _buildSwitchTile(
            title: '스탬프 알림',
            subtitle: '스탬프 적립 및 완성 소식을 받아보세요',
            value: _stampNotification,
            onChanged: (value) {
              setState(() {
                _stampNotification = value;
              });
            },
          ),
          _buildDivider(),
          _buildSwitchTile(
            title: '이벤트 알림',
            subtitle: '특별 이벤트와 이벤트 당첨 소식을 받아보세요',
            value: _eventNotification,
            onChanged: (value) {
              setState(() {
                _eventNotification = value;
              });
            },
          ),
          _buildDivider(),
          _buildSwitchTile(
            title: '마케팅 정보 수신 동의',
            subtitle: '광고성 정보 수신에 동의합니다',
            value: _marketingNotification,
            onChanged: (value) {
              setState(() {
                _marketingNotification = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            inactiveThumbColor: AppColors.disabled,
            inactiveTrackColor: AppColors.disabledLight,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppColors.border,
      indent: 16,
      endIndent: 16,
    );
  }

  Widget _buildDescription() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 20,
                color: AppColors.primary,
              ),
              SizedBox(width: 8),
              Text(
                '알림 설정 안내',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '• 푸시 알림이 비활성화되어 있으면 다른 알림을 받을 수 없습니다.\n'
            '• 디바이스 설정에서도 알림 권한을 확인해주세요.\n'
            '• 마케팅 정보 수신은 언제든지 변경할 수 있습니다.',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.primary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}