import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import '../themes/colors.dart';

class StoreRegistrationPage extends StatefulWidget {
  const StoreRegistrationPage({super.key});

  @override
  State<StoreRegistrationPage> createState() => _StoreRegistrationPageState();
}

class _StoreRegistrationPageState extends State<StoreRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _businessNumberController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _representativeNameController = TextEditingController();
  
  bool _isBusinessNumberVerified = false;
  File? _selectedFile;
  String? _selectedFileName;
  int _currentStep = 1;
  final int _totalSteps = 5;

  @override
  void dispose() {
    _businessNumberController.dispose();
    _businessNameController.dispose();
    _representativeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          '입점 신청',
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
          // Progress Section
          _buildProgressSection(),
          
          // Form Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStepContent(),
                  ],
                ),
              ),
            ),
          ),
          
          // Navigation Buttons
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Column(
        children: [
          // Progress Bar
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: _currentStep / _totalSteps,
                  backgroundColor: AppColors.grey200,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  minHeight: 6,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Step Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$_currentStep/$_totalSteps 단계',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              Text(
                '${((_currentStep / _totalSteps) * 100).toInt()}% 완료',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 1:
        return _buildBusinessVerificationStep();
      case 2:
        return _buildPlaceholder('2단계: 가게 기본정보');
      case 3:
        return _buildPlaceholder('3단계: 가게 위치정보');
      case 4:
        return _buildPlaceholder('4단계: 운영정보');
      case 5:
        return _buildPlaceholder('5단계: 최종 확인');
      default:
        return _buildBusinessVerificationStep();
    }
  }

  Widget _buildBusinessVerificationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step Title
        const Text(
          '사업자 정보 확인',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        
        // Step Description
        const Text(
          '사업자등록증에 기재된 정보를 확인합니다.\n이 정보는 입점 심사 목적으로만 사용되며, 고객에게 노출되지 않습니다.',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),

        // Business Number Input
        _buildBusinessNumberField(),
        const SizedBox(height: 24),

        // Business Name Input (Disabled)
        _buildDisabledField(
          controller: _businessNameController,
          label: '상호명 (사업자등록증 기준)',
          hintText: '인증 후 자동으로 입력됩니다',
        ),
        const SizedBox(height: 16),

        // Representative Name Input (Disabled)
        _buildDisabledField(
          controller: _representativeNameController,
          label: '대표자명 (사업자등록증 기준)',
          hintText: '인증 후 자동으로 입력됩니다',
        ),
        const SizedBox(height: 24),

        // File Upload Section
        _buildFileUploadSection(),
      ],
    );
  }

  Widget _buildBusinessNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '사업자등록번호',
          style: TextStyle(
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
                controller: _businessNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '사업자등록번호를 입력해주세요';
                  }
                  if (value.length != 10) {
                    return '사업자등록번호는 10자리여야 합니다';
                  }
                  if (!_isBusinessNumberVerified) {
                    return '사업자등록번호 인증을 완료해주세요';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: '-없이 숫자만 입력',
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
                      color: _isBusinessNumberVerified ? AppColors.success : AppColors.border,
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
                  suffixIcon: _isBusinessNumberVerified 
                    ? const Icon(Icons.check_circle, color: AppColors.success)
                    : null,
                ),
                onChanged: (value) {
                  if (_isBusinessNumberVerified) {
                    setState(() {
                      _isBusinessNumberVerified = false;
                      _businessNameController.clear();
                      _representativeNameController.clear();
                    });
                  }
                },
              ),
            ),
            const SizedBox(width: 12),
            
            Container(
              height: 56,
              child: ElevatedButton(
                onPressed: _isBusinessNumberVerified ? null : _verifyBusinessNumber,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isBusinessNumberVerified ? AppColors.success : AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  minimumSize: const Size(0, 56),
                ),
                child: Text(
                  _isBusinessNumberVerified ? '인증완료' : '인증하기',
                  style: const TextStyle(
                    fontSize: 14,
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

  Widget _buildDisabledField({
    required TextEditingController controller,
    required String label,
    required String hintText,
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
          enabled: false,
          decoration: InputDecoration(
            hintText: hintText.replaceAll('API 응답 후 자동으로', '인증 후 자동으로'),
            hintStyle: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
            filled: true,
            fillColor: AppColors.grey100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildFileUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              '사업자등록증 사본 첨부',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '선택사항',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.info,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        
        const Text(
          '최대 5MB의 PDF, JPG, PNG 파일을 첨부할 수 있습니다.',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        
        GestureDetector(
          onTap: _selectFile,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: _selectedFile != null ? AppColors.primary : AppColors.border,
                width: 2,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(12),
              color: _selectedFile != null 
                ? AppColors.primary.withValues(alpha: 0.05) 
                : AppColors.surface,
            ),
            child: Column(
              children: [
                Icon(
                  _selectedFile != null ? Icons.check_circle : Icons.cloud_upload,
                  size: 48,
                  color: _selectedFile != null ? AppColors.primary : AppColors.textSecondary,
                ),
                const SizedBox(height: 12),
                
                Text(
                  _selectedFile != null 
                    ? '파일이 선택되었습니다' 
                    : '파일 업로드하기',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _selectedFile != null ? AppColors.primary : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                
                if (_selectedFile != null) ...[
                  Text(
                    _selectedFileName ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedFile = null;
                        _selectedFileName = null;
                      });
                    },
                    child: const Text(
                      '파일 제거',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ] else ...[
                  const Text(
                    'PDF, JPG, PNG (최대 5MB)',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder(String title) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(
            Icons.construction,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '다음 단계는 준비 중입니다',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Previous Button
          if (_currentStep > 1) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _currentStep--;
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.border),
                  backgroundColor: AppColors.grey100,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_back, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      '이전${_getPreviousStepInfo()}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
          
          // Next Button
          Expanded(
            child: ElevatedButton(
              onPressed: _canProceedToNext() ? _handleNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '다음${_getNextStepInfo()}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_forward, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getPreviousStepInfo() {
    switch (_currentStep) {
      case 2:
        return '(사업자 정보)';
      case 3:
        return '(기본 정보)';
      case 4:
        return '(위치 정보)';
      case 5:
        return '(운영 정보)';
      default:
        return '';
    }
  }

  String _getNextStepInfo() {
    switch (_currentStep) {
      case 1:
        return '(기본 정보)';
      case 2:
        return '(위치 정보)';
      case 3:
        return '(운영 정보)';
      case 4:
        return '(최종 확인)';
      case 5:
        return '(신청 완료)';
      default:
        return '';
    }
  }

  bool _canProceedToNext() {
    switch (_currentStep) {
      case 1:
        return _isBusinessNumberVerified && 
               _businessNumberController.text.isNotEmpty &&
               _businessNumberController.text.length == 10;
      case 2:
      case 3:
      case 4:
      case 5:
        return true; // 나머지 단계는 임시로 항상 true
      default:
        return false;
    }
  }

  void _handleNext() {
    if (_currentStep == 1) {
      if (_formKey.currentState!.validate()) {
        if (_currentStep < _totalSteps) {
          setState(() {
            _currentStep++;
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('사업자등록번호를 입력하고 인증을 완료해주세요')),
        );
      }
    } else {
      if (_currentStep < _totalSteps) {
        setState(() {
          _currentStep++;
        });
      } else {
        // 마지막 단계에서 완료 처리
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('입점 신청이 완료되었습니다!')),
        );
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }
  }

  void _verifyBusinessNumber() {
    String businessNumber = _businessNumberController.text;
    
    // 숫자만 있는지 검사
    if (businessNumber.isEmpty || !RegExp(r'^\d+$').hasMatch(businessNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('숫자만 입력해주세요')),
      );
      return;
    }
    
    if (businessNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('사업자등록번호는 10자리여야 합니다')),
      );
      return;
    }

    // API 호출 시뮬레이션
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pop(); // 로딩 다이얼로그 닫기
      
      setState(() {
        _isBusinessNumberVerified = true;
        _businessNameController.text = '쿠덕이네 분식당'; // API 응답 시뮬레이션
        _representativeNameController.text = '김사장'; // API 응답 시뮬레이션
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('사업자등록번호 인증이 완료되었습니다'),
          backgroundColor: AppColors.success,
        ),
      );
    });
  }

  void _selectFile() {
    // 파일 선택 시뮬레이션
    setState(() {
      _selectedFile = File('dummy_path'); // 실제로는 file_picker 패키지 사용
      _selectedFileName = 'business_registration.pdf';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('파일이 선택되었습니다')),
    );
  }
}