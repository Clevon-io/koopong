import 'package:flutter/material.dart';
import '../models/stamp.dart';
import '../widgets/stamp_card.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';

class MyStampsPage extends StatefulWidget {
  const MyStampsPage({super.key});

  @override
  State<MyStampsPage> createState() => _MyStampsPageState();
}

class _MyStampsPageState extends State<MyStampsPage> {
  // Test data
  final List<Stamp> _stamps = [
    Stamp(
      storeId: '1',
      storeName: '감성커피 양산점',
      imageUrl: '',
      targetCount: 10,
      rewardText: '10개 달성시 아메리카노 1잔 무료!',
      stamps: [
        true, true, true, true, true,  // 첫 줄: 5개 활성화
        true, true, false, false, false  // 둘째 줄: 2개 활성화, 3개 비활성화
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          '🏆 내 스탬프',
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: AppColors.divider,
          ),
        ),
      ),
      body: _buildStampList(),
    );
  }

  Widget _buildStampList() {
    if (_stamps.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.verified_outlined,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              '진행 중인 스탬프가 없습니다',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '가게에서 스탬프를 모아보세요!',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            '진행 중인 스탬프',
            style: AppTypography.sectionTitle,
          ),
        ),
        
        // Stamps list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: _stamps.length,
            itemBuilder: (context, index) {
              if (index >= _stamps.length) {
                return const SizedBox.shrink();
              }
              return StampCard(
                stamp: _stamps[index],
                onStampChanged: () {
                  // Handle stamp change if needed
                  setState(() {});
                },
              );
            },
          ),
        ),
      ],
    );
  }
}