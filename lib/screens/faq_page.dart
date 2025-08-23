import 'package:flutter/material.dart';
import '../themes/colors.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  int? _expandedIndex;

  final List<FAQItem> _faqItems = [
    FAQItem(
      category: '쿠폰',
      question: '쿠폰은 어떻게 사용하나요?',
      answer: '쿠폰 사용 방법은 다음과 같습니다:\n\n1. 쿠폰함에서 사용할 쿠폰 선택\n2. 가게에서 주문 시 쿠폰 제시\n3. QR코드 스캔 또는 쿠폰 코드 입력\n4. 할인 적용 확인 후 결제\n\n※ 쿠폰마다 사용 조건과 유효기간이 다르니 확인 후 사용해주세요.',
      tags: ['쿠폰', '사용', '할인'],
    ),
    FAQItem(
      category: '쿠폰',
      question: '쿠폰 유효기간이 지나면 어떻게 되나요?',
      answer: '쿠폰 유효기간이 만료되면 자동으로 사용할 수 없게 됩니다.\n\n• 만료된 쿠폰은 쿠폰함에서 회색으로 표시됩니다\n• 만료 3일 전부터 알림을 보내드립니다\n• 만료된 쿠폰은 복구가 불가능합니다\n• 쿠폰 만료일은 각 쿠폰 상세 페이지에서 확인할 수 있습니다',
      tags: ['쿠폰', '만료', '유효기간'],
    ),
    FAQItem(
      category: '스탬프',
      question: '스탬프는 어떻게 적립하나요?',
      answer: '스탬프 적립 방법:\n\n1. 참여 가게에서 결제 완료\n2. 가게에서 제공하는 QR코드 스캔\n3. 또는 직원에게 적립 요청\n4. 휴대폰 번호 또는 쿠퐁 앱으로 확인\n\n※ 최소 주문 금액 이상일 때만 적립 가능합니다.',
      tags: ['스탬프', '적립', 'QR코드'],
    ),
    FAQItem(
      category: '스탬프',
      question: '스탬프가 모이면 어떤 혜택이 있나요?',
      answer: '스탬프 완성 시 다음과 같은 혜택을 받을 수 있습니다:\n\n• 무료 음료 또는 디저트\n• 할인 쿠폰 제공\n• 특별 메뉴 무료 제공\n• 추가 스탬프 보너스\n\n혜택 내용은 각 가게마다 다르며, 스탬프 카드에서 확인하실 수 있습니다.',
      tags: ['스탬프', '혜택', '완성'],
    ),
    FAQItem(
      category: '계정',
      question: '회원가입 없이도 사용할 수 있나요?',
      answer: '네, 일부 기능은 회원가입 없이도 이용 가능합니다:\n\n비회원 이용 가능:\n• 가게 정보 확인\n• 메뉴 및 가격 확인\n• 위치 검색\n\n회원 전용 기능:\n• 쿠폰 받기 및 사용\n• 스탬프 적립\n• 찜 목록 저장\n• 개인화된 추천\n\n더 많은 혜택을 위해 회원가입을 추천드립니다!',
      tags: ['계정', '회원가입', '비회원'],
    ),
    FAQItem(
      category: '계정',
      question: '비밀번호를 잊어버렸어요',
      answer: '비밀번호 찾기 방법:\n\n1. 로그인 페이지에서 "비밀번호 찾기" 클릭\n2. 가입 시 사용한 이메일 주소 입력\n3. 이메일로 전송된 링크 클릭\n4. 새 비밀번호 설정\n\n※ 이메일이 오지 않는다면 스팸함을 확인해주세요.\n※ 소셜 로그인으로 가입하신 경우 해당 소셜 계정으로 로그인해주세요.',
      tags: ['비밀번호', '찾기', '재설정'],
    ),
    FAQItem(
      category: '앱',
      question: '알림이 오지 않아요',
      answer: '알림이 오지 않는 경우 다음을 확인해주세요:\n\n앱 설정 확인:\n• MY 쿠퐁 > 앱설정 > 알림 설정에서 푸시 알림 활성화\n• 받고 싶은 알림 유형 선택\n\n디바이스 설정 확인:\n• 설정 > 앱 > 쿠퐁 > 알림 허용\n• 방해금지 모드 해제\n• 절전 모드에서 쿠퐁 앱 제외\n\n그래도 해결되지 않으면 고객센터로 문의해주세요.',
      tags: ['알림', '푸시', '설정'],
    ),
    FAQItem(
      category: '앱',
      question: '위치 서비스를 허용해야 하나요?',
      answer: '위치 서비스 허용 시 다음과 같은 편의 기능을 이용할 수 있습니다:\n\n주요 기능:\n• 내 주변 가게 자동 검색\n• 거리 기반 정렬\n• 위치 기반 쿠폰 추천\n• 방문 확인 자동화\n\n개인정보 보호:\n• 위치 정보는 서비스 제공 목적으로만 사용\n• 개인 위치 데이터는 암호화 저장\n• 언제든지 설정에서 비활성화 가능\n\n위치 서비스 없이도 기본 기능은 모두 이용 가능합니다.',
      tags: ['위치', '서비스', '개인정보'],
    ),
    FAQItem(
      category: '오류',
      question: '앱이 자주 꺼져요',
      answer: '앱이 자주 종료되는 문제 해결 방법:\n\n즉시 해결:\n• 앱을 완전히 종료 후 재시작\n• 디바이스 재부팅\n• 앱 업데이트 확인\n\n근본 해결:\n• 저장공간 확보 (최소 1GB 이상)\n• 백그라운드 앱 정리\n• OS 업데이트 확인\n• 앱 캐시 데이터 삭제\n\n계속 문제가 발생하면 디바이스 모델과 OS 버전을 알려주시고 고객센터로 문의해주세요.',
      tags: ['오류', '앱종료', '크래시'],
    ),
  ];

  List<FAQItem> get filteredFAQs {
    if (_searchQuery.isEmpty) return _faqItems;
    
    return _faqItems.where((faq) {
      final query = _searchQuery.toLowerCase();
      return faq.question.toLowerCase().contains(query) ||
             faq.answer.toLowerCase().contains(query) ||
             faq.tags.any((tag) => tag.toLowerCase().contains(query)) ||
             faq.category.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          '자주 묻는 질문 (FAQ)',
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
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategoryChips(),
          Expanded(child: _buildFAQList()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
            _expandedIndex = null;
          });
        },
        decoration: const InputDecoration(
          hintText: '궁금한 내용을 검색해보세요',
          hintStyle: TextStyle(color: AppColors.textSecondary),
          prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    final categories = ['전체', '쿠폰', '스탬프', '계정', '앱', '오류'];
    
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _searchQuery.isEmpty && category == '전체' ||
                            _searchQuery.isNotEmpty && category.toLowerCase().contains(_searchQuery.toLowerCase());
          
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (category == '전체') {
                    _searchController.clear();
                    _searchQuery = '';
                  } else {
                    _searchController.text = category;
                    _searchQuery = category;
                  }
                  _expandedIndex = null;
                });
              },
              selectedColor: AppColors.primary.withValues(alpha: 0.2),
              checkmarkColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFAQList() {
    final faqs = filteredFAQs;
    
    if (faqs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: AppColors.textSecondary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              '검색 결과가 없습니다',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '다른 키워드로 검색해보세요',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        return _buildFAQItem(faqs[index], index);
      },
    );
  }

  Widget _buildFAQItem(FAQItem faq, int index) {
    final isExpanded = _expandedIndex == index;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _expandedIndex = isExpanded ? null : index;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      faq.category,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      faq.question,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.border),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    faq.answer,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                      height: 1.6,
                    ),
                  ),
                  if (faq.tags.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 6,
                      children: faq.tags.map((tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.grey200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '#$tag',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class FAQItem {
  final String category;
  final String question;
  final String answer;
  final List<String> tags;

  FAQItem({
    required this.category,
    required this.question,
    required this.answer,
    required this.tags,
  });
}