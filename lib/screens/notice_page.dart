import 'package:flutter/material.dart';
import '../themes/colors.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  final List<NoticeItem> _notices = [
    NoticeItem(
      id: 1,
      title: '쿠퐁 앱 서비스 점검 안내',
      content: '안녕하세요, 쿠퐁입니다.\n\n더 나은 서비스 제공을 위해 시스템 점검을 실시합니다.\n\n점검 일시: 2024년 8월 25일(일) 02:00~06:00\n점검 내용: 서버 성능 개선 및 보안 업데이트\n\n점검 시간 동안 일시적으로 서비스 이용이 제한될 수 있습니다.\n이용에 불편을 드려 죄송합니다.\n\n감사합니다.',
      date: '2024.08.23',
      isImportant: true,
      isNew: true,
    ),
    NoticeItem(
      id: 2,
      title: '신규 파트너 가게 추가 안내',
      content: '쿠퐁에 새로운 파트너 가게들이 추가되었습니다!\n\n🍕 모락피자 - 피자 전문점\n☕ 감성카페 양산점 - 커피&디저트\n🍜 탕화쿵푸마라탕 - 마라탕 전문점\n\n각 가게에서 특별 할인 혜택과 스탬프 적립 서비스를 제공합니다.\n지금 바로 확인해보세요!',
      date: '2024.08.20',
      isImportant: false,
      isNew: true,
    ),
    NoticeItem(
      id: 3,
      title: '개인정보 처리방침 변경 안내',
      content: '개인정보 처리방침이 개정되어 안내드립니다.\n\n주요 변경사항:\n• 위치정보 수집 및 이용 목적 명시\n• 개인정보 보유기간 조정\n• 제3자 제공 관련 내용 업데이트\n\n변경된 처리방침은 2024년 8월 15일부터 적용됩니다.\n자세한 내용은 앱 내 이용약관에서 확인하실 수 있습니다.',
      date: '2024.08.15',
      isImportant: true,
      isNew: false,
    ),
    NoticeItem(
      id: 4,
      title: '여름 시즌 이벤트 종료 안내',
      content: '7월부터 진행된 여름 시즌 특별 이벤트가 종료되었습니다.\n\n이벤트 기간: 2024.07.01 ~ 2024.08.10\n참여해주신 모든 분들께 감사드립니다.\n\n다음 이벤트는 추석 시즌에 더욱 풍성한 혜택으로 찾아뵐 예정입니다.\n많은 기대 부탁드립니다!',
      date: '2024.08.10',
      isImportant: false,
      isNew: false,
    ),
    NoticeItem(
      id: 5,
      title: '쿠퐁 앱 업데이트 안내 (v1.0.0)',
      content: '쿠퐁 앱이 업데이트되었습니다.\n\n주요 업데이트 내용:\n• UI/UX 개선\n• QR코드 스캔 기능 추가\n• 알림 설정 기능 강화\n• 버그 수정 및 성능 개선\n\nApp Store 또는 Google Play에서 업데이트해주세요.\n더욱 편리해진 쿠퐁을 경험해보세요!',
      date: '2024.08.05',
      isImportant: false,
      isNew: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          '공지사항',
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _notices.length,
        itemBuilder: (context, index) {
          return _buildNoticeItem(_notices[index]);
        },
      ),
    );
  }

  Widget _buildNoticeItem(NoticeItem notice) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: () => _showNoticeDetail(notice),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (notice.isImportant)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '중요',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (notice.isImportant) const SizedBox(width: 6),
                  if (notice.isNew)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'NEW',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (notice.isNew) const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      notice.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                notice.content,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Text(
                notice.date,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNoticeDetail(NoticeItem notice) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        minChildSize: 0.5,
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (notice.isImportant) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.error,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    '중요',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                              ],
                              if (notice.isNew) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'NEW',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                              ],
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            notice.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            notice.date,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    notice.content,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoticeItem {
  final int id;
  final String title;
  final String content;
  final String date;
  final bool isImportant;
  final bool isNew;

  NoticeItem({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.isImportant,
    required this.isNew,
  });
}