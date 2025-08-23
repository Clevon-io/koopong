import 'package:flutter/material.dart';
import '../themes/colors.dart';
import 'qr_scanner_page.dart';

class QRSettingsPage extends StatefulWidget {
  const QRSettingsPage({super.key});

  @override
  State<QRSettingsPage> createState() => _QRSettingsPageState();
}

class _QRSettingsPageState extends State<QRSettingsPage> {
  bool _autoScanEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _flashAutoMode = false;
  bool _saveScannedHistory = true;
  String _selectedScanArea = 'medium';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'QR 스캔 설정',
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
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: AppColors.primary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QRScannerPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildScanSettingsSection(),
            const SizedBox(height: 16),
            _buildFeedbackSettingsSection(),
            const SizedBox(height: 16),
            _buildHistorySettingsSection(),
            const SizedBox(height: 16),
            _buildQuickActionsSection(),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildScanSettingsSection() {
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
              '스캔 설정',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          _buildSwitchTile(
            title: '자동 스캔',
            subtitle: 'QR코드를 인식하면 자동으로 처리합니다',
            value: _autoScanEnabled,
            onChanged: (value) {
              setState(() {
                _autoScanEnabled = value;
              });
            },
          ),
          _buildDivider(),
          _buildSwitchTile(
            title: '플래시 자동 모드',
            subtitle: '어두운 환경에서 자동으로 플래시가 켜집니다',
            value: _flashAutoMode,
            onChanged: (value) {
              setState(() {
                _flashAutoMode = value;
              });
            },
          ),
          _buildDivider(),
          _buildScanAreaSettings(),
        ],
      ),
    );
  }

  Widget _buildFeedbackSettingsSection() {
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
              '피드백 설정',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          _buildSwitchTile(
            title: '스캔 완료 소리',
            subtitle: 'QR코드 스캔 시 알림음이 재생됩니다',
            value: _soundEnabled,
            onChanged: (value) {
              setState(() {
                _soundEnabled = value;
              });
            },
          ),
          _buildDivider(),
          _buildSwitchTile(
            title: '진동 피드백',
            subtitle: 'QR코드 스캔 시 진동으로 알려줍니다',
            value: _vibrationEnabled,
            onChanged: (value) {
              setState(() {
                _vibrationEnabled = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySettingsSection() {
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
              '히스토리 설정',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          _buildSwitchTile(
            title: '스캔 기록 저장',
            subtitle: '스캔한 QR코드의 기록을 저장합니다',
            value: _saveScannedHistory,
            onChanged: (value) {
              setState(() {
                _saveScannedHistory = value;
              });
            },
          ),
          if (_saveScannedHistory) ...[
            _buildDivider(),
            ListTile(
              leading: const Icon(Icons.history, color: AppColors.textSecondary),
              title: const Text(
                '스캔 기록 보기',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
              subtitle: const Text(
                '최근 스캔한 QR코드 목록을 확인합니다',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              onTap: () {
                _showScanHistory();
              },
            ),
            _buildDivider(),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: AppColors.error),
              title: const Text(
                '기록 전체 삭제',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.error,
                ),
              ),
              subtitle: const Text(
                '모든 스캔 기록을 삭제합니다',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              onTap: () {
                _showDeleteHistoryDialog();
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
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
              '빠른 실행',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.qr_code_scanner, color: AppColors.primary),
            ),
            title: const Text(
              'QR 스캐너 열기',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            subtitle: const Text(
              '바로 QR코드 스캔을 시작합니다',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QRScannerPage()),
              );
            },
          ),
          _buildDivider(),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.help_outline, color: AppColors.info),
            ),
            title: const Text(
              'QR코드 사용법',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            subtitle: const Text(
              'QR코드 스캔 방법과 팁을 알아보세요',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            onTap: () {
              _showQRGuide();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScanAreaSettings() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '스캔 영역 크기',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'QR코드를 스캔할 영역의 크기를 선택하세요',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildScanAreaOption('small', '작게'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildScanAreaOption('medium', '보통'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildScanAreaOption('large', '크게'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScanAreaOption(String value, String label) {
    final isSelected = _selectedScanArea == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedScanArea = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.grey100,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
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

  void _showScanHistory() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.border),
                  ),
                ),
                child: Row(
                  children: [
                    const Text(
                      '스캔 기록',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return _buildHistoryItem(
                      'https://example.com/coupon_${index + 1}',
                      '쿠폰 QR코드',
                      '${DateTime.now().subtract(Duration(days: index)).month}월 ${DateTime.now().subtract(Duration(days: index)).day}일',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(String url, String type, String date) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.qr_code, color: AppColors.primary),
        title: Text(
          type,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              url,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              date,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('클릭: $url'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteHistoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('기록 삭제'),
          content: const Text('모든 스캔 기록을 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('스캔 기록이 모두 삭제되었습니다.'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              style: TextButton.styleFrom(foregroundColor: AppColors.error),
              child: const Text('삭제'),
            ),
          ],
        );
      },
    );
  }

  void _showQRGuide() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.lightbulb_outline, color: AppColors.primary),
              SizedBox(width: 8),
              Text('QR코드 사용법'),
            ],
          ),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '📱 스캔 방법',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '• QR코드를 화면 중앙의 사각형 안에 맞춰주세요\n• 거리는 10~30cm가 적당합니다\n• 손이 흔들리지 않도록 고정해주세요\n',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  '💡 스캔 팁',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '• 밝은 곳에서 스캔하면 더 빠릅니다\n• 어두운 곳에서는 플래시를 켜보세요\n• QR코드가 구겨지거나 손상되지 않았는지 확인하세요\n• 반사되는 표면은 각도를 조정해보세요',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}