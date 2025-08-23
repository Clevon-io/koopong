import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../themes/colors.dart';

class User {
  final String id;
  final String nickname;
  final String email;
  final String? profileImageUrl;

  User({
    required this.id,
    required this.nickname,
    required this.email,
    this.profileImageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickname': nickname,
      'email': email,
      'profileImageUrl': profileImageUrl,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nickname: json['nickname'],
      email: json['email'],
      profileImageUrl: json['profileImageUrl'],
    );
  }
}

class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  User? _currentUser;
  bool _isLoggedIn = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;

  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserId = 'user_id';
  static const String _keyUserNickname = 'user_nickname';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserProfileImage = 'user_profile_image';

  /// 앱 시작 시 저장된 로그인 상태 복원
  Future<void> initializeAuth() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(_keyIsLoggedIn) ?? false;
    
    if (_isLoggedIn) {
      final userId = prefs.getString(_keyUserId);
      final userNickname = prefs.getString(_keyUserNickname);
      final userEmail = prefs.getString(_keyUserEmail);
      final userProfileImage = prefs.getString(_keyUserProfileImage);
      
      if (userId != null && userNickname != null && userEmail != null) {
        _currentUser = User(
          id: userId,
          nickname: userNickname,
          email: userEmail,
          profileImageUrl: userProfileImage,
        );
      } else {
        // 데이터가 불완전하면 로그아웃 처리
        _isLoggedIn = false;
        await _clearStoredData();
      }
    }
    
    notifyListeners();
  }

  /// 임시 로그인 (테스트용)
  Future<void> tempLogin([BuildContext? context]) async {
    _currentUser = User(
      id: 'temp_user_123',
      nickname: '쿠퐁러버',
      email: 'user@koopong.com',
      profileImageUrl: null, // 기본 프로필 이미지 사용
    );
    _isLoggedIn = true;
    
    await _saveUserData();
    notifyListeners();

    // 환영 메시지 표시
    if (context != null && context.mounted) {
      _showCustomToast(
        context,
        '${_currentUser!.nickname}님 환영해요!',
        Icons.emoji_emotions_rounded,
        AppColors.success,
      );
    }
  }

  /// 실제 로그인 (향후 API 연동용)
  Future<bool> login(String email, String password) async {
    try {
      // TODO: 실제 API 호출
      // final response = await apiService.login(email, password);
      
      // 임시로 성공 처리
      _currentUser = User(
        id: 'user_456',
        nickname: email.split('@')[0],
        email: email,
        profileImageUrl: null,
      );
      _isLoggedIn = true;
      
      await _saveUserData();
      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
      return false;
    }
  }

  /// 로그아웃
  Future<void> logout([BuildContext? context]) async {
    _currentUser = null;
    _isLoggedIn = false;
    
    await _clearStoredData();
    notifyListeners();

    // 로그아웃 안내 메시지 표시
    if (context != null && context.mounted) {
      _showCustomToast(
        context,
        '로그아웃되었어요',
        Icons.waving_hand,
        AppColors.textSecondary,
      );
    }
  }

  /// 커스텀 토스트 메시지 표시 (찜 메시지와 동일한 스타일)
  void _showCustomToast(BuildContext context, String message, IconData icon, Color backgroundColor) {
    final overlay = Overlay.of(context);
    
    late AnimationController fadeController;
    late Animation<double> fadeAnimation;
    
    fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      vsync: Navigator.of(context),
    );
    
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: fadeController, curve: Curves.easeInOut),
    );

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: kBottomNavigationBarHeight + 20,
        left: 0,
        right: 0,
        child: Center(
          child: AnimatedBuilder(
            animation: fadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: fadeAnimation.value,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          icon,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          message,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    fadeController.forward().then((_) {
      Future.delayed(const Duration(seconds: 2), () {
        fadeController.reverse().then((_) {
          overlayEntry.remove();
          fadeController.dispose();
        });
      });
    });
  }

  /// 사용자 정보 업데이트
  Future<void> updateUserProfile({
    String? nickname,
    String? profileImageUrl,
  }) async {
    if (_currentUser == null) return;
    
    _currentUser = User(
      id: _currentUser!.id,
      nickname: nickname ?? _currentUser!.nickname,
      email: _currentUser!.email,
      profileImageUrl: profileImageUrl ?? _currentUser!.profileImageUrl,
    );
    
    await _saveUserData();
    notifyListeners();
  }

  /// 토큰 갱신 (향후 구현)
  Future<bool> refreshToken() async {
    try {
      // TODO: 실제 토큰 갱신 API 호출
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Token refresh error: $e');
      }
      // 토큰 갱신 실패 시 로그아웃
      await logout();
      return false;
    }
  }

  /// 사용자 데이터를 SharedPreferences에 저장
  Future<void> _saveUserData() async {
    if (_currentUser == null) return;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyUserId, _currentUser!.id);
    await prefs.setString(_keyUserNickname, _currentUser!.nickname);
    await prefs.setString(_keyUserEmail, _currentUser!.email);
    
    if (_currentUser!.profileImageUrl != null) {
      await prefs.setString(_keyUserProfileImage, _currentUser!.profileImageUrl!);
    }
  }

  /// 저장된 데이터 삭제
  Future<void> _clearStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsLoggedIn);
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserNickname);
    await prefs.remove(_keyUserEmail);
    await prefs.remove(_keyUserProfileImage);
  }

  /// 로그인 필요 여부 확인
  bool requiresLogin() {
    return !_isLoggedIn;
  }

  /// 사용자 통계 데이터 (임시)
  Map<String, int> getUserStats() {
    // 실제로는 API에서 가져올 데이터
    return {
      'favoriteStores': 5,
      'reviews': 12,
      'coupons': 3,
      'stamps': 7,
    };
  }
}