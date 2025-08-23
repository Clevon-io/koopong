import 'package:flutter/material.dart';
import '../themes/colors.dart';

class LocationSettingsPage extends StatefulWidget {
  const LocationSettingsPage({super.key});

  @override
  State<LocationSettingsPage> createState() => _LocationSettingsPageState();
}

class _LocationSettingsPageState extends State<LocationSettingsPage> {
  bool _locationPermission = false;
  bool _backgroundLocation = false;
  String _selectedAccuracy = 'high';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          '위치 서비스 설정',
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
            _buildLocationPermissionSection(),
            const SizedBox(height: 16),
            _buildLocationAccuracySection(),
            const SizedBox(height: 24),
            _buildCurrentLocationSection(),
            const SizedBox(height: 24),
            _buildDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationPermissionSection() {
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
            title: '위치 서비스 허용',
            subtitle: '주변 가게와 쿠폰을 찾기 위해 위치 정보가 필요합니다',
            value: _locationPermission,
            onChanged: (value) {
              setState(() {
                _locationPermission = value;
                if (!value) {
                  _backgroundLocation = false;
                }
              });
              if (value) {
                _requestLocationPermission();
              }
            },
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.border, indent: 16, endIndent: 16),
          _buildSwitchTile(
            title: '백그라운드 위치 허용',
            subtitle: '앱이 실행되지 않을 때도 위치 기반 알림을 받을 수 있습니다',
            value: _backgroundLocation,
            enabled: _locationPermission,
            onChanged: (value) {
              setState(() {
                _backgroundLocation = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLocationAccuracySection() {
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
              '위치 정확도',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          _buildAccuracyOption('high', '높음', '가장 정확한 위치 (GPS + 네트워크)'),
          _buildAccuracyOption('medium', '보통', '균형잡힌 위치 정확도'),
          _buildAccuracyOption('low', '낮음', '배터리 절약 모드'),
        ],
      ),
    );
  }

  Widget _buildCurrentLocationSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '현재 위치',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 20,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    '서울특별시 성동구 마장동',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _locationPermission ? _refreshLocation : null,
                  child: const Text(
                    '새로고침',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    bool enabled = true,
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
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: enabled ? AppColors.textPrimary : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: enabled ? AppColors.textSecondary : AppColors.disabled,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeColor: AppColors.primary,
            inactiveThumbColor: AppColors.disabled,
            inactiveTrackColor: AppColors.disabledLight,
          ),
        ],
      ),
    );
  }

  Widget _buildAccuracyOption(String value, String title, String subtitle) {
    return RadioListTile<String>(
      value: value,
      groupValue: _selectedAccuracy,
      onChanged: _locationPermission ? (String? newValue) {
        setState(() {
          _selectedAccuracy = newValue!;
        });
      } : null,
      activeColor: AppColors.primary,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: _locationPermission ? AppColors.textPrimary : AppColors.textSecondary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: _locationPermission ? AppColors.textSecondary : AppColors.disabled,
        ),
      ),
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
                Icons.privacy_tip_outlined,
                size: 20,
                color: AppColors.primary,
              ),
              SizedBox(width: 8),
              Text(
                '개인정보 보호',
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
            '• 위치 정보는 주변 가게 검색과 개인화된 서비스 제공 목적으로만 사용됩니다.\n'
            '• 개인 위치 데이터는 암호화되어 안전하게 보호됩니다.\n'
            '• 언제든지 위치 서비스를 비활성화할 수 있습니다.',
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

  void _requestLocationPermission() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('위치 권한을 요청합니다. 설정에서 허용해주세요.'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _refreshLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('위치 정보를 새로고침했습니다.'),
        backgroundColor: AppColors.success,
      ),
    );
  }
}