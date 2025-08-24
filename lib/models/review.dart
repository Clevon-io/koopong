import 'package:flutter/material.dart';

class Review {
  final String id;
  final String storeId;
  final String storeName;
  final String storeImageUrl;
  final int overallRating; // 1: 아쉬워요, 2: 괜찮아요, 3: 최고에요
  final List<String> positiveAspects; // 좋은 점들 (서비스, 맛&퀄리티, 분위기&시설 등)
  final String? detailedReview; // 상세 후기 (선택사항)
  final DateTime createdAt;
  final bool isPublished; // 리뷰 공개 여부

  Review({
    required this.id,
    required this.storeId,
    required this.storeName,
    required this.storeImageUrl,
    required this.overallRating,
    required this.positiveAspects,
    this.detailedReview,
    required this.createdAt,
    this.isPublished = false,
  });

  /// JSON 직렬화를 위한 생성자 (향후 API 연동용)
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
      storeImageUrl: json['storeImageUrl'] as String,
      overallRating: json['overallRating'] as int,
      positiveAspects: List<String>.from(json['positiveAspects'] as List),
      detailedReview: json['detailedReview'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isPublished: json['isPublished'] as bool? ?? false,
    );
  }

  /// JSON 직렬화를 위한 메서드 (향후 API 연동용)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storeId': storeId,
      'storeName': storeName,
      'storeImageUrl': storeImageUrl,
      'overallRating': overallRating,
      'positiveAspects': positiveAspects,
      'detailedReview': detailedReview,
      'createdAt': createdAt.toIso8601String(),
      'isPublished': isPublished,
    };
  }

  /// 전체 평점 텍스트 반환
  String get overallRatingText {
    switch (overallRating) {
      case 1:
        return '아쉬워요';
      case 2:
        return '괜찮아요';
      case 3:
        return '최고에요!';
      default:
        return '평가 없음';
    }
  }

  /// 전체 평점 이모지 반환
  String get overallRatingEmoji {
    switch (overallRating) {
      case 1:
        return '😐';
      case 2:
        return '😊';
      case 3:
        return '🤩';
      default:
        return '❓';
    }
  }

  /// 날짜를 사용자 친화적인 형식으로 포맷
  String get formattedDate {
    return '${createdAt.year}.${createdAt.month.toString().padLeft(2, '0')}.${createdAt.day.toString().padLeft(2, '0')}';
  }

  /// 시간까지 포함한 상세 포맷
  String get formattedDateTime {
    return '$formattedDate ${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}';
  }

  /// 좋은 점들을 문자열로 연결
  String get positiveAspectsText {
    return positiveAspects.join(', ');
  }

  /// 리뷰 복사본 생성 (수정용)
  Review copyWith({
    String? id,
    String? storeId,
    String? storeName,
    String? storeImageUrl,
    int? overallRating,
    List<String>? positiveAspects,
    String? detailedReview,
    DateTime? createdAt,
    bool? isPublished,
  }) {
    return Review(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      storeImageUrl: storeImageUrl ?? this.storeImageUrl,
      overallRating: overallRating ?? this.overallRating,
      positiveAspects: positiveAspects ?? this.positiveAspects,
      detailedReview: detailedReview ?? this.detailedReview,
      createdAt: createdAt ?? this.createdAt,
      isPublished: isPublished ?? this.isPublished,
    );
  }
}

/// 리뷰 작성 시 선택 가능한 좋은 점들
class ReviewAspects {
  static const List<String> serviceAspects = [
    '친절한 서비스',
    '빠른 서비스',
    '정확한 주문',
    '깨끗한 매장',
    '편리한 위치',
    '세심한 배려',
    '전문적인 상담',
    '친근한 분위기',
  ];

  static const List<String> tasteQualityAspects = [
    '맛있는 음식',
    '신선한 재료',
    '적당한 양',
    '합리적인 가격',
    '다양한 메뉴',
    '정성스런 조리',
    '특별한 맛',
    '건강한 재료',
  ];

  static const List<String> atmosphereFacilityAspects = [
    '좋은 분위기',
    '깔끔한 인테리어',
    '편안한 좌석',
    '조용한 환경',
    '사진 찍기 좋음',
    '넓은 공간',
    '음악이 좋음',
    '조명이 아늑함',
  ];

  static List<String> get allAspects {
    return [
      ...serviceAspects,
      ...tasteQualityAspects,
      ...atmosphereFacilityAspects,
    ];
  }

  static Map<String, List<String>> get categorizedAspects {
    return {
      '서비스': serviceAspects,
      '맛&퀄리티': tasteQualityAspects,
      '분위기&시설': atmosphereFacilityAspects,
    };
  }

  /// 카테고리별 이모티콘과 색상 정보
  static Map<String, Map<String, dynamic>> get categoryInfo {
    return {
      '서비스': {
        'emoji': '🔔',
        'color': const Color(0xFF2196F3), // 파란색
        'backgroundColor': const Color(0xFF2196F3).withValues(alpha: 0.1),
      },
      '맛&퀄리티': {
        'emoji': '🍽️',
        'color': const Color(0xFFFF9800), // 주황색  
        'backgroundColor': const Color(0xFFFF9800).withValues(alpha: 0.1),
      },
      '분위기&시설': {
        'emoji': '✨',
        'color': const Color(0xFF9C27B0), // 보라색
        'backgroundColor': const Color(0xFF9C27B0).withValues(alpha: 0.1),
      },
    };
  }
}

/// 카테고리 정보를 위한 헬퍼 클래스
class ReviewCategory {
  final String name;
  final String emoji;
  final Color color;
  final Color backgroundColor;
  final List<String> aspects;

  const ReviewCategory({
    required this.name,
    required this.emoji,
    required this.color,
    required this.backgroundColor,
    required this.aspects,
  });

  static List<ReviewCategory> get allCategories {
    return ReviewAspects.categorizedAspects.entries.map((entry) {
      final info = ReviewAspects.categoryInfo[entry.key]!;
      return ReviewCategory(
        name: entry.key,
        emoji: info['emoji'],
        color: info['color'],
        backgroundColor: info['backgroundColor'],
        aspects: entry.value,
      );
    }).toList();
  }
}