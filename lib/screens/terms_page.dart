import 'package:flutter/material.dart';
import '../themes/colors.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          '이용약관 및 개인정보처리방침',
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
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: '이용약관'),
            Tab(text: '개인정보처리방침'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTermsOfService(),
          _buildPrivacyPolicy(),
        ],
      ),
    );
  }

  Widget _buildTermsOfService() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('쿠퐁 서비스 이용약관'),
            const SizedBox(height: 16),
            _buildLastUpdated('최종 업데이트: 2024년 8월 15일'),
            const SizedBox(height: 24),
            
            _buildSection(
              title: '제1조 (목적)',
              content: '본 약관은 쿠퐁(이하 "회사")이 제공하는 쿠폰 및 스탬프 적립 서비스(이하 "서비스")의 이용과 관련하여 회사와 이용자 간의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.',
            ),
            
            _buildSection(
              title: '제2조 (정의)',
              content: '''1. "서비스"란 회사가 제공하는 쿠폰, 스탬프, 할인 혜택 등의 모바일 플랫폼 서비스를 말합니다.
2. "이용자"란 본 약관에 따라 회사가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.
3. "회원"이란 회사와 서비스 이용계약을 체결하고 이용자 아이디를 부여받은 자를 말합니다.
4. "쿠폰"이란 가맹점에서 할인 등의 혜택을 받을 수 있는 전자적 증표를 말합니다.''',
            ),
            
            _buildSection(
              title: '제3조 (약관의 게시와 개정)',
              content: '''1. 회사는 본 약관의 내용을 이용자가 쉽게 알 수 있도록 서비스 초기 화면에 게시합니다.
2. 회사는 필요하다고 인정되는 경우 본 약관을 개정할 수 있습니다.
3. 약관을 개정할 경우 적용일자 및 개정사유를 명시하여 현행약관과 함께 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다.''',
            ),
            
            _buildSection(
              title: '제4조 (서비스의 제공)',
              content: '''회사는 다음과 같은 서비스를 제공합니다:
1. 가맹점 정보 제공 서비스
2. 쿠폰 발급 및 사용 서비스
3. 스탬프 적립 및 관리 서비스
4. 위치 기반 가맹점 검색 서비스
5. 기타 회사가 정하는 서비스''',
            ),
            
            _buildSection(
              title: '제5조 (서비스 이용료)',
              content: '회사가 제공하는 기본 서비스는 무료입니다. 단, 일부 부가 서비스의 경우 별도의 이용료가 발생할 수 있으며, 이 경우 사전에 고지합니다.',
            ),
            
            _buildSection(
              title: '제6조 (회원가입)',
              content: '''1. 이용자는 회사가 정한 가입 양식에 따라 회원정보를 기입한 후 본 약관에 동의한다는 의사표시를 함으로써 회원가입을 신청합니다.
2. 회사는 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각 호에 해당하지 않는 한 회원으로 등록합니다:
   - 가입신청자가 본 약관에 의하여 이전에 회원자격을 상실한 적이 있는 경우
   - 실명이 아니거나 타인의 명의를 이용한 경우
   - 허위의 정보를 기재하거나, 회사가 제시하는 내용을 기재하지 않은 경우''',
            ),
            
            _buildSection(
              title: '제7조 (개인정보보호)',
              content: '회사는 관련 법령이 정하는 바에 따라 이용자의 개인정보를 보호하기 위해 노력합니다. 개인정보의 보호 및 사용에 대해서는 관련법령 및 회사의 개인정보처리방침이 적용됩니다.',
            ),
            
            _buildSection(
              title: '제8조 (회사의 의무)',
              content: '''1. 회사는 법령과 본 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 본 약관이 정하는 바에 따라 지속적이고, 안정적으로 서비스를 제공하기 위해서 노력합니다.
2. 회사는 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함) 보호를 위한 보안 시스템을 구축합니다.
3. 회사는 이용자로부터 제기되는 의견이나 불만이 정당하다고 객관적으로 인정될 경우에는 적절한 절차를 거쳐 즉시 처리하여야 합니다.''',
            ),
            
            _buildSection(
              title: '제9조 (이용자의 의무)',
              content: '''이용자는 다음 행위를 하여서는 안 됩니다:
1. 신청 또는 변경 시 허위 내용의 등록
2. 타인의 정보 도용
3. 회사가 게시한 정보의 변경
4. 회사가 정한 정보 이외의 정보(컴퓨터 프로그램 등)의 송신 또는 게시
5. 회사 기타 제3자의 저작권 등 지적재산권에 대한 침해
6. 회사 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위
7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 회사에 공개 또는 게시하는 행위''',
            ),
            
            _buildSection(
              title: '제10조 (저작권의 귀속)',
              content: '''1. 회사가 작성한 저작물에 대한 저작권 기타 지적재산권은 회사에 귀속합니다.
2. 이용자는 회사를 이용함으로써 얻은 정보 중 회사에게 지적재산권이 귀속된 정보를 회사의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.''',
            ),
            
            _buildSection(
              title: '제11조 (계약해지 및 이용제한)',
              content: '''1. 이용자는 언제든지 서비스 이용을 중단하고 회원 탈퇴를 요청할 수 있으며, 회사는 이를 즉시 처리합니다.
2. 회사는 이용자가 본 약관의 의무를 위반하거나 서비스의 정상적인 운영을 방해한 경우, 경고, 일시정지, 영구이용정지 등으로 서비스 이용을 단계적으로 제한할 수 있습니다.''',
            ),
            
            _buildSection(
              title: '제12조 (손해배상)',
              content: '회사는 무료로 제공되는 서비스와 관련하여 회원에게 어떠한 손해가 발생하더라도 동 손해가 회사의 고의 또는 중과실에 의한 경우를 제외하고는 이에 대하여 책임을 부담하지 아니합니다.',
            ),
            
            _buildSection(
              title: '제13조 (면책조항)',
              content: '''1. 회사는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면제됩니다.
2. 회사는 이용자의 귀책사유로 인한 서비스 이용의 장애에 대하여는 책임을 지지 않습니다.
3. 회사는 이용자가 서비스를 이용하여 기대하는 수익을 상실한 것에 대하여 책임을 지지 않으며 그 밖의 서비스를 통하여 얻은 자료로 인한 손해에 관하여 책임을 지지 않습니다.''',
            ),
            
            _buildSection(
              title: '부칙',
              content: '본 약관은 2024년 8월 15일부터 적용됩니다.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyPolicy() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('개인정보처리방침'),
            const SizedBox(height: 16),
            _buildLastUpdated('최종 업데이트: 2024년 8월 15일'),
            const SizedBox(height: 24),
            
            _buildSection(
              title: '1. 개인정보의 처리목적',
              content: '''쿠퐁(이하 "회사")은 다음의 목적을 위하여 개인정보를 처리합니다:

가. 회원 가입 및 관리
- 회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 서비스 부정이용 방지 목적

나. 재화 또는 서비스 제공
- 쿠폰 서비스 제공, 스탬프 적립 서비스 제공, 개인맞춤 서비스 제공, 본인인증, 연령인증

다. 마케팅 및 광고에의 활용
- 이벤트 및 광고성 정보 제공 및 참여기회 제공, 접속빈도 파악 또는 회원의 서비스 이용에 대한 통계

라. 고충처리
- 민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락·통지, 처리결과 통보''',
            ),
            
            _buildSection(
              title: '2. 개인정보의 처리 및 보유기간',
              content: '''① 회사는 정보주체로부터 개인정보를 수집할 때 동의받은 개인정보 보유·이용기간 또는 법령에 따른 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.

② 구체적인 개인정보 처리 및 보유 기간은 다음과 같습니다:
- 회원 가입 및 관리: 회원 탈퇴 시까지
- 쿠폰 및 스탬프 서비스 제공: 서비스 종료 시까지
- 마케팅 정보 제공: 동의철회 시까지
- 법령에 따른 보존: 관련 법령에서 정한 기간''',
            ),
            
            _buildSection(
              title: '3. 처리하는 개인정보의 항목',
              content: '''① 회사는 다음의 개인정보 항목을 처리하고 있습니다:

가. 필수항목
- 이메일 주소, 비밀번호, 휴대전화번호, 생년월일, 성별

나. 선택항목
- 이름, 주소, 관심분야

다. 자동 수집 항목
- IP주소, 쿠키, MAC주소, 서비스 이용기록, 방문기록, 불량 이용기록, 기기정보, 위치정보''',
            ),
            
            _buildSection(
              title: '4. 개인정보의 제3자 제공',
              content: '''① 회사는 정보주체의 개인정보를 "1. 개인정보의 처리목적"에서 명시한 범위 내에서만 처리하며, 정보주체의 동의, 법률의 특별한 규정 등 개인정보보호법 제17조에 해당하는 경우에만 개인정보를 제3자에게 제공합니다.

② 회사는 다음과 같이 개인정보를 제3자에게 제공하고 있습니다:

가. 제공받는 자: 제휴 가맹점
나. 제공받는 자의 개인정보 이용목적: 쿠폰 사용 확인, 스탬프 적립 확인
다. 제공하는 개인정보 항목: 휴대전화번호 뒷 4자리, 회원 ID
라. 제공받는 자의 보유·이용기간: 서비스 종료 시까지''',
            ),
            
            _buildSection(
              title: '5. 개인정보처리 위탁',
              content: '''① 회사는 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다:

가. 위탁받는 자: Amazon Web Services(AWS)
나. 위탁하는 업무의 내용: 클라우드 서비스 제공, 데이터 저장 및 관리

② 회사는 위탁계약 체결시 개인정보 보호법 제26조에 따라 위탁업무 수행목적 외 개인정보 처리금지, 기술적·관리적 보호조치, 재위탁 제한, 수탁자에 대한 관리·감독, 손해배상 등 책임에 관한 사항을 계약서 등 문서에 명시하고 수탁자가 개인정보를 안전하게 처리하는지를 감독하고 있습니다.''',
            ),
            
            _buildSection(
              title: '6. 정보주체의 권리·의무 및 행사방법',
              content: '''① 정보주체는 회사에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다:
1. 개인정보 처리현황 통지요구
2. 개인정보 열람요구
3. 개인정보 정정·삭제요구
4. 개인정보 처리정지요구

② 제1항에 따른 권리 행사는 회사에 대해 서면, 전화, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 회사는 이에 대해 지체없이 조치하겠습니다.

③ 정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 회사는 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.''',
            ),
            
            _buildSection(
              title: '7. 개인정보의 파기',
              content: '''① 회사는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다.

② 개인정보 파기의 절차 및 방법은 다음과 같습니다:
가. 파기절차
- 회사는 파기 사유가 발생한 개인정보를 선정하고, 회사의 개인정보 보호책임자의 승인을 받아 개인정보를 파기합니다.

나. 파기방법
- 전자적 파일 형태의 정보: 기록을 재생할 수 없는 기술적 방법을 사용
- 종이에 출력된 개인정보: 분쇄기로 분쇄하거나 소각''',
            ),
            
            _buildSection(
              title: '8. 개인정보 보호책임자',
              content: '''① 회사는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다:

▶ 개인정보 보호책임자
성명: 김쿠퐁
직책: 개인정보보호팀장
연락처: privacy@koopong.com, 02-1234-5678

② 정보주체께서는 회사의 서비스를 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자에게 문의하실 수 있습니다.''',
            ),
            
            _buildSection(
              title: '9. 개인정보의 안전성 확보조치',
              content: '''회사는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다:

1. 관리적 조치: 내부관리계획 수립·시행, 정기적 직원 교육 등
2. 기술적 조치: 개인정보처리시스템 등의 접근권한 관리, 접근통제시스템 설치, 고유식별정보 등의 암호화, 보안프로그램 설치
3. 물리적 조치: 전산실, 자료보관실 등의 접근통제''',
            ),
            
            _buildSection(
              title: '10. 개인정보처리방침의 변경',
              content: '''① 이 개인정보처리방침은 2024년 8월 15일부터 적용됩니다.

② 이전의 개인정보처리방침은 아래에서 확인하실 수 있습니다:
- 2024.01.01 ~ 2024.08.14 적용 (이전 버전)''',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildLastUpdated(String date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        date,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textPrimary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}