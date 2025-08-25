import 'package:flutter/material.dart';
import '../themes/colors.dart';
import 'store_registration_page.dart';

enum SignupMethod { email, sns }
enum SnsProvider { google, kakao, naver }

class PartnerSignupPage extends StatefulWidget {
  const PartnerSignupPage({super.key});

  @override
  State<PartnerSignupPage> createState() => _PartnerSignupPageState();
}

class _PartnerSignupPageState extends State<PartnerSignupPage> with SingleTickerProviderStateMixin {
  SignupMethod? _selectedMethod;
  SnsProvider? _selectedSnsProvider;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _nameController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isPasswordConfirmVisible = false;
  bool _isEmailVerified = false;
  bool _isNicknameVerified = false;
  bool _showSnsInfo = false;
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _nicknameController.dispose();
    _nameController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          '파트너 회원가입',
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              
              // Welcome Text
              const Text(
                '쿠퐁 파트너가 되어보세요!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                '더 많은 고객과 만나고 매출을 늘려보세요',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              if (_selectedMethod == null) ...[
                // Method Selection
                _buildMethodSelection(),
              ] else if (_selectedMethod == SignupMethod.sns && !_showSnsInfo) ...[
                // SNS Provider Selection
                _buildSnsProviderSelection(),
              ] else if (_selectedMethod == SignupMethod.sns && _showSnsInfo) ...[
                // SNS Info Confirmation + Nickname
                _buildSnsInfoConfirmation(),
              ] else ...[
                // Email Signup Form
                _buildEmailSignupForm(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMethodSelection() {
    return Column(
      children: [
        const Text(
          '가입 방법을 선택해주세요',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 32),

        // Email Signup Button
        _buildMethodButton(
          icon: Icons.email_outlined,
          title: '이메일로 가입하기',
          subtitle: '이메일과 비밀번호로 간편하게 가입',
          onPressed: () {
            setState(() {
              _selectedMethod = SignupMethod.email;
            });
          },
        ),
        
        const SizedBox(height: 16),

        // SNS Signup Button
        _buildMethodButton(
          icon: Icons.smartphone,
          title: 'SNS 간편 가입',
          subtitle: '카카오, 네이버, 구글 계정으로 빠른 가입',
          onPressed: () {
            setState(() {
              _selectedMethod = SignupMethod.sns;
            });
          },
        ),
      ],
    );
  }

  Widget _buildMethodButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.border, width: 1.5),
          padding: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
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
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildSnsProviderSelection() {
    return Column(
      children: [
        const Text(
          'SNS 간편 가입',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 32),

        // SNS Provider Buttons
        Column(
          children: [
            _buildSnsSignupButton(
              color: const Color(0xFFDB4437),
              icon: Icons.account_circle,
              text: '구글로 가입하기',
              onPressed: () => _handleSnsSelection(SnsProvider.google),
            ),
            const SizedBox(height: 16),
            _buildSnsSignupButton(
              color: const Color(0xFFFEE500),
              icon: Icons.chat_bubble,
              text: '카카오로 가입하기',
              textColor: Colors.black,
              onPressed: () => _handleSnsSelection(SnsProvider.kakao),
            ),
            const SizedBox(height: 16),
            _buildSnsSignupButton(
              color: const Color(0xFF03C75A),
              icon: Icons.person,
              text: '네이버로 가입하기',
              onPressed: () => _handleSnsSelection(SnsProvider.naver),
            ),
          ],
        ),

        const SizedBox(height: 32),

        // Back Button
        TextButton(
          onPressed: () {
            setState(() {
              _selectedMethod = null;
            });
          },
          child: const Text(
            '다른 방법으로 가입하기',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSnsInfoConfirmation() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Column(
          children: [
            // Selected SNS Provider Button (moved to top)
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: _buildSelectedSnsButton(),
              ),
            ),
            
            const SizedBox(height: 32),

            // SNS Info Section
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '연동된 계정 정보',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Email Info
                    Row(
                      children: [
                        const Icon(Icons.email, size: 20, color: AppColors.textSecondary),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '이메일',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              _emailController.text.isNotEmpty 
                                ? _emailController.text 
                                : _getSnsEmail(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Name Info
                    Row(
                      children: [
                        const Icon(Icons.person, size: 20, color: AppColors.textSecondary),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '이름',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              _nameController.text.isNotEmpty 
                                ? _nameController.text 
                                : _getSnsName(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Nickname Input
            FadeTransition(
              opacity: _fadeAnimation,
              child: _buildVerificationField(
                controller: _nicknameController,
                label: '닉네임',
                hintText: '사용하실 닉네임을 입력하세요',
                isVerified: _isNicknameVerified,
                onVerify: () {
                  if (_nicknameController.text.isNotEmpty) {
                    setState(() {
                      _isNicknameVerified = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('닉네임 사용 가능')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('닉네임을 입력해주세요')),
                    );
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '닉네임을 입력해주세요';
                  }
                  if (!_isNicknameVerified) {
                    return '닉네임 중복 확인을 해주세요';
                  }
                  return null;
                },
              ),
            ),

            const SizedBox(height: 32),

            // Continue Button
            FadeTransition(
              opacity: _fadeAnimation,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isNicknameVerified ? () {
                    _navigateToStoreRegistration();
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    '가게 등록 단계로 이동',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Back Button
            TextButton(
              onPressed: () {
                setState(() {
                  _showSnsInfo = false;
                  _selectedSnsProvider = null;
                  _isNicknameVerified = false;
                  _nicknameController.clear();
                });
              },
              child: const Text(
                '다른 계정으로 가입하기',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSelectedSnsButton() {
    if (_selectedSnsProvider == null) return const SizedBox.shrink();
    
    Color color;
    IconData icon;
    String text;
    Color textColor = Colors.white;
    
    switch (_selectedSnsProvider!) {
      case SnsProvider.google:
        color = const Color(0xFFDB4437);
        icon = Icons.account_circle;
        text = '구글 계정';
        break;
      case SnsProvider.kakao:
        color = const Color(0xFFFEE500);
        icon = Icons.chat_bubble;
        text = '카카오 계정';
        textColor = Colors.black;
        break;
      case SnsProvider.naver:
        color = const Color(0xFF03C75A);
        icon = Icons.person;
        text = '네이버 계정';
        break;
    }
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: textColor),
          const SizedBox(width: 8),
          Text(
            '$text로 가입',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSnsSignupButton({
    required Color color,
    required IconData icon,
    required String text,
    Color textColor = Colors.white,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailSignupForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            '이메일로 가입하기',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 32),

          // Email Input with Verification
          _buildVerificationField(
            controller: _emailController,
            label: '이메일',
            hintText: 'partner@example.com',
            keyboardType: TextInputType.emailAddress,
            isVerified: _isEmailVerified,
            onVerify: () {
              if (_emailController.text.isNotEmpty &&
                  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text)) {
                setState(() {
                  _isEmailVerified = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('이메일 중복 확인 완료')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('올바른 이메일을 입력해주세요')),
                );
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '이메일을 입력해주세요';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return '올바른 이메일 형식을 입력해주세요';
              }
              if (!_isEmailVerified) {
                return '이메일 중복 확인을 해주세요';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 16),

          // Password Input
          _buildInputField(
            controller: _passwordController,
            label: '비밀번호',
            hintText: '비밀번호를 입력하세요 (6자 이상)',
            obscureText: !_isPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.textSecondary,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '비밀번호를 입력해주세요';
              }
              if (value.length < 6) {
                return '비밀번호는 6자 이상이어야 합니다';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 16),

          // Password Confirmation
          _buildInputField(
            controller: _passwordConfirmController,
            label: '비밀번호 확인',
            hintText: '비밀번호를 다시 입력하세요',
            obscureText: !_isPasswordConfirmVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordConfirmVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.textSecondary,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordConfirmVisible = !_isPasswordConfirmVisible;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '비밀번호 확인을 입력해주세요';
              }
              if (value != _passwordController.text) {
                return '비밀번호가 일치하지 않습니다';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 16),

          // Nickname Input with Verification
          _buildVerificationField(
            controller: _nicknameController,
            label: '닉네임',
            hintText: '사용하실 닉네임을 입력하세요',
            isVerified: _isNicknameVerified,
            onVerify: () {
              if (_nicknameController.text.isNotEmpty) {
                setState(() {
                  _isNicknameVerified = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('닉네임 사용 가능')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('닉네임을 입력해주세요')),
                );
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '닉네임을 입력해주세요';
              }
              if (!_isNicknameVerified) {
                return '닉네임 중복 확인을 해주세요';
              }
              return null;
            },
          ),

          const SizedBox(height: 32),

          // Continue Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (_isEmailVerified && _isNicknameVerified) ? () {
                if (_formKey.currentState!.validate()) {
                  _navigateToStoreRegistration();
                }
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '가게 등록 단계로 이동',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Back Button
          TextButton(
            onPressed: () {
              setState(() {
                _selectedMethod = null;
                _isEmailVerified = false;
                _isNicknameVerified = false;
                _emailController.clear();
                _passwordController.clear();
                _passwordConfirmController.clear();
                _nicknameController.clear();
              });
            },
            child: const Text(
              '다른 방법으로 가입하기',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType? keyboardType,
    required bool isVerified,
    required VoidCallback onVerify,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                validator: validator,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: isVerified ? AppColors.success : AppColors.border,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.error),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  suffixIcon: isVerified 
                    ? const Icon(Icons.check_circle, color: AppColors.success)
                    : null,
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: isVerified ? null : onVerify,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isVerified ? AppColors.success : AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: Text(
                  isVerified ? '확인완료' : '중복확인',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  void _handleSnsSelection(SnsProvider provider) {
    setState(() {
      _selectedSnsProvider = provider;
      _showSnsInfo = true;
      // 가상의 SNS 로그인 데이터 설정
      _emailController.text = _getSnsEmail();
      _nameController.text = _getSnsName();
    });
    _animationController.forward();
  }

  String _getSnsEmail() {
    switch (_selectedSnsProvider) {
      case SnsProvider.google:
        return 'partner@gmail.com';
      case SnsProvider.kakao:
        return 'partner@kakao.com';
      case SnsProvider.naver:
        return 'partner@naver.com';
      case null:
        return '';
    }
  }

  String _getSnsName() {
    switch (_selectedSnsProvider) {
      case SnsProvider.google:
        return '김사장';
      case SnsProvider.kakao:
        return '이대표';
      case SnsProvider.naver:
        return '박원장';
      case null:
        return '';
    }
  }

  void _navigateToStoreRegistration() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StoreRegistrationPage(),
      ),
    );
  }
}