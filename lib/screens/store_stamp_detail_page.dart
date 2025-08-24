import 'package:flutter/material.dart';
import '../models/stamp.dart';
import '../models/stamp_history.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';
import '../themes/spacing.dart';

class StoreStampDetailPage extends StatefulWidget {
  final String storeId;
  final String storeName;
  final String storeImageUrl;

  const StoreStampDetailPage({
    super.key,
    required this.storeId,
    required this.storeName,
    required this.storeImageUrl,
  });

  @override
  State<StoreStampDetailPage> createState() => _StoreStampDetailPageState();
}

class _StoreStampDetailPageState extends State<StoreStampDetailPage> {
  bool _showAllHistory = false;
  
  // 임시 데이터 (향후 DB/API에서 가져올 데이터)
  late Stamp _stamp;
  late List<StampHistory> _stampHistory;

  @override
  void initState() {
    super.initState();
    _initializeTestData();
  }

  void _initializeTestData() {
    // 임시 스탬프 데이터 (7개 적립된 상태)
    _stamp = Stamp(
      storeId: widget.storeId,
      storeName: widget.storeName,
      imageUrl: widget.storeImageUrl,
      targetCount: 10,
      rewardText: '아메리카노 1잔 무료',
      stamps: [
        true, true, true, true, true,  // 첫 줄: 5개 적립
        true, true, false, false, false  // 둘째 줄: 2개 적립, 3개 남음
      ],
    );

    // 임시 적립 내역 데이터
    _stampHistory = [
      StampHistory(
        stampNumber: 7,
        date: DateTime.now().subtract(const Duration(days: 1)),
        note: '아메리카노 주문',
      ),
      StampHistory(
        stampNumber: 6,
        date: DateTime.now().subtract(const Duration(days: 5)),
        note: '라떼 주문',
      ),
      StampHistory(
        stampNumber: 5,
        date: DateTime.now().subtract(const Duration(days: 8)),
        note: '아이스크림 주문',
      ),
      StampHistory(
        stampNumber: 4,
        date: DateTime.now().subtract(const Duration(days: 12)),
        note: '디카페인 라떼',
      ),
      StampHistory(
        stampNumber: 3,
        date: DateTime.now().subtract(const Duration(days: 18)),
        note: '바닐라라떼',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.lg),
            _buildStampSection(),
            SizedBox(height: AppSpacing.xl),
            _buildRewardSection(),
            SizedBox(height: AppSpacing.xl),
            _buildHistorySection(),
            SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      surfaceTintColor: AppColors.surface,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(widget.storeImageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              widget.storeName,
              style: AppTypography.appBarTitle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStampSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '단골 스탬프',
            style: AppTypography.h3.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            '스탬프 ${_stamp.targetCount}개를 모아 ${_stamp.rewardText}을 받아보세요!',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.lg),
          _buildStampGrid(),
          SizedBox(height: AppSpacing.md),
          _buildProgressText(),
        ],
      ),
    );
  }

  Widget _buildStampGrid() {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          // 첫 번째 줄 (1-5번 스탬프)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              return _buildStampItem(index);
            }),
          ),
          SizedBox(height: AppSpacing.md),
          // 두 번째 줄 (6-10번 스탬프)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              return _buildStampItem(index + 5);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStampItem(int index) {
    final isActive = index < _stamp.stamps.length && _stamp.stamps[index];
    final isLastStamp = index == _stamp.targetCount - 1; // 10번째 스탬프
    final stampNumber = index + 1;

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive 
            ? AppColors.primary 
            : AppColors.surface,
        border: Border.all(
          color: isActive 
              ? AppColors.primary 
              : AppColors.border,
          width: 2,
        ),
        boxShadow: isActive ? [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ] : null,
      ),
      child: Center(
        child: isActive 
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 24,
              )
            : isLastStamp 
                ? Icon(
                    Icons.card_giftcard,
                    color: AppColors.textSecondary,
                    size: 20,
                  )
                : Text(
                    '$stampNumber',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
      ),
    );
  }

  Widget _buildProgressText() {
    final remaining = _stamp.targetCount - _stamp.currentCount;
    
    return Container(
      padding: EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.celebration,
            color: AppColors.success,
            size: 20,
          ),
          SizedBox(width: AppSpacing.sm),
          Text(
            '현재 ${_stamp.currentCount}개 적립! 앞으로 $remaining개만 더 모으면 돼요!',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBE6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFD700), width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.card_giftcard,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_stamp.targetCount}개 적립시',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  _stamp.rewardText,
                  style: AppTypography.h4.copyWith(
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

  Widget _buildHistorySection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '스탬프 적립 내역',
            style: AppTypography.sectionTitle,
          ),
          SizedBox(height: AppSpacing.md),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                _buildHistoryList(),
                if (_stampHistory.length > 3)
                  _buildShowMoreButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    final displayHistory = _showAllHistory 
        ? _stampHistory 
        : _stampHistory.take(3).toList();

    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: displayHistory.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: AppColors.border.withValues(alpha: 0.5),
        ),
        itemBuilder: (context, index) {
          final history = displayHistory[index];
          return Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${history.stampNumber}',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    '${history.stampNumber}번째 스탬프 적립',
                    style: AppTypography.bodyMedium,
                  ),
                ),
                Text(
                  history.formattedDate,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        },
    );
  }

  Widget _buildShowMoreButton() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.border.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: TextButton(
          onPressed: () {
            setState(() {
              _showAllHistory = !_showAllHistory;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _showAllHistory ? '간단히 보기' : '전체 내역 보기',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: AppSpacing.xs),
              Icon(
                _showAllHistory ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: AppColors.primary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}