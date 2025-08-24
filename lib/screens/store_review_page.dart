import 'package:flutter/material.dart';
import '../models/review.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';
import '../themes/spacing.dart';
import '../screens/my_reviews_page.dart';

class StoreReviewPage extends StatefulWidget {
  final String storeId;
  final String storeName;
  final String storeImageUrl;

  const StoreReviewPage({
    super.key,
    required this.storeId,
    required this.storeName,
    required this.storeImageUrl,
  });

  @override
  State<StoreReviewPage> createState() => _StoreReviewPageState();
}

class _StoreReviewPageState extends State<StoreReviewPage> {
  int _selectedRating = 0; // 0: 미선택, 1: 아쉬워요, 2: 괜찮아요, 3: 최고에요!
  final Set<String> _selectedAspects = {};
  final TextEditingController _detailedReviewController = TextEditingController();

  @override
  void dispose() {
    _detailedReviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          '사장님 응원하기',
          style: AppTypography.appBarTitle,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.lg),
            _buildStoreInfoSection(),
            SizedBox(height: AppSpacing.xl),
            _buildOverallRatingSection(),
            SizedBox(height: AppSpacing.xl),
            _buildPositiveAspectsSection(),
            SizedBox(height: AppSpacing.xl),
            _buildDetailedReviewSection(),
            SizedBox(height: AppSpacing.xl),
            _buildSubmitButton(),
            SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreInfoSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
              image: DecorationImage(
                image: AssetImage(widget.storeImageUrl),
                fit: BoxFit.cover,
                onError: (error, stackTrace) {
                  // 이미지 로드 실패 시 처리
                },
              ),
            ),
            child: widget.storeImageUrl.isEmpty
                ? const Icon(
                    Icons.store,
                    color: AppColors.textSecondary,
                    size: 30,
                  )
                : null,
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '이용하신 가게',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  widget.storeName,
                  style: AppTypography.h4.copyWith(
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

  Widget _buildOverallRatingSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Text(
            '가게에서의 경험은 어땠나요?',
            style: AppTypography.h4.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(child: _buildRatingButton(1, '😐', '아쉬워요')),
              SizedBox(width: AppSpacing.md),
              Expanded(child: _buildRatingButton(2, '😊', '괜찮아요')),
              SizedBox(width: AppSpacing.md),
              Expanded(child: _buildRatingButton(3, '🤩', '최고에요!')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingButton(int rating, String emoji, String text) {
    final isSelected = _selectedRating == rating;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRating = rating;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected 
            ? AppColors.primary.withValues(alpha: 0.1)
            : AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected 
              ? AppColors.primary
              : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 36),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              text,
              style: AppTypography.bodyMedium.copyWith(
                color: isSelected 
                  ? AppColors.primary
                  : AppColors.textSecondary,
                fontWeight: isSelected 
                  ? FontWeight.bold
                  : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPositiveAspectsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Text(
            '어떤 점이 좋았나요?',
            style: AppTypography.h4.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.lg),
          // 카테고리별 섹션 구분
          ...ReviewCategory.allCategories.asMap().entries.map((entry) {
            final index = entry.key;
            final category = entry.value;
            
            return Container(
              margin: EdgeInsets.only(
                bottom: index < ReviewCategory.allCategories.length - 1 
                  ? AppSpacing.lg 
                  : 0
              ),
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: category.backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: category.color.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 카테고리 헤더 (이모티콘 + 이름이 들어간 캡슐)
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: category.color,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: category.color.withValues(alpha: 0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              category.emoji,
                              style: const TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: AppSpacing.xs),
                            Text(
                              category.name,
                              style: AppTypography.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: category.aspects.map((aspect) {
                      final isSelected = _selectedAspects.contains(aspect);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedAspects.remove(aspect);
                            } else {
                              _selectedAspects.add(aspect);
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                              ? category.color
                              : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                ? category.color
                                : AppColors.border,
                              width: isSelected ? 2 : 1,
                            ),
                            boxShadow: isSelected ? [
                              BoxShadow(
                                color: category.color.withValues(alpha: 0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ] : null,
                          ),
                          child: Text(
                            aspect,
                            style: AppTypography.caption.copyWith(
                              color: isSelected
                                ? Colors.white
                                : AppColors.textPrimary,
                              fontWeight: isSelected 
                                ? FontWeight.bold 
                                : FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDetailedReviewSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '상세 후기 (선택)',
            style: AppTypography.h4.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppSpacing.md),
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: TextField(
              controller: _detailedReviewController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: '사장님에게 큰 힘이 되는 한마디를 남겨주세요!\n따뜻한 응원과 구체적인 후기는 가게에 큰 도움이 됩니다.',
                hintStyle: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(AppSpacing.md),
              ),
              style: AppTypography.bodyMedium,
              textInputAction: TextInputAction.newline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    final bool canSubmit = _selectedRating > 0; // 최소한 전체 평가는 필요
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: canSubmit ? _handleSubmitReview : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFD700),
          foregroundColor: AppColors.textPrimary,
          padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          disabledBackgroundColor: AppColors.grey300,
          disabledForegroundColor: AppColors.textSecondary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite,
              size: 20,
            ),
            SizedBox(width: AppSpacing.sm),
            Text(
              '응원 보내기',
              style: AppTypography.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitReview() async {
    // 1. 먼저 찜 상태 확인
    final bool isFavoriteStore = await _checkIfFavoriteStore();
    
    if (!isFavoriteStore) {
      // 찜하지 않은 가게인 경우 찜 확인 다이얼로그 표시
      final bool? shouldAddToFavorites = await _showFavoriteConfirmDialog();
      if (shouldAddToFavorites == true) {
        // 찜 목록에 추가
        await _addToFavorites();
      }
    }

    // 2. 리뷰 등록 확인 다이얼로그 표시
    final bool? shouldRegisterReview = await _showReviewConfirmDialog();
    
    if (shouldRegisterReview == true) {
      // 리뷰 등록 후 내가 쓴 리뷰 페이지로 이동
      await _registerReview();
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MyReviewsPage(),
          ),
        );
      }
    }
    // shouldRegisterReview가 false면 현재 페이지 유지
  }

  Future<bool> _checkIfFavoriteStore() async {
    // TODO: 실제 찜 목록 확인 로직 구현
    // 현재는 임시로 false 반환 (찜하지 않은 것으로 가정)
    return false;
  }

  Future<bool?> _showFavoriteConfirmDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            '단골 가게로 찜할까요?',
            style: AppTypography.h4,
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(widget.storeImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.md),
              Text(
                widget.storeName,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                '단골 가게로 등록하시면\n가게의 쿠폰 소식을 가장 먼저 받을 수 있어요!',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                '다음에 할게요',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('네 찜할게요!'),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showReviewConfirmDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            '리뷰를 등록하시겠어요?',
            style: AppTypography.h4,
            textAlign: TextAlign.center,
          ),
          content: Text(
            '작성하신 따뜻한 응원이\n${widget.storeName}에 전달됩니다.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                '등록하지 않기',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('등록하기'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addToFavorites() async {
    // TODO: 실제 찜 목록 추가 로직 구현
    // 임시로 딜레이만 추가
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _registerReview() async {
    // 리뷰 데이터 생성
    final review = Review(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      storeId: widget.storeId,
      storeName: widget.storeName,
      storeImageUrl: widget.storeImageUrl,
      overallRating: _selectedRating,
      positiveAspects: _selectedAspects.toList(),
      detailedReview: _detailedReviewController.text.trim().isNotEmpty
          ? _detailedReviewController.text.trim()
          : null,
      createdAt: DateTime.now(),
      isPublished: true,
    );

    // 리뷰 저장 (향후 API 연동 시 실제 저장 로직으로 교체)
    print('Review saved: ${review.toJson()}');
    
    // 임시로 딜레이만 추가
    await Future.delayed(const Duration(seconds: 1));
  }
}