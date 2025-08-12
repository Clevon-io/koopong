enum CouponStatus {
  available,
  used,
  expired,
}

class Coupon {
  final String id;
  final String storeName;
  final String description;
  final DateTime expiryDate;
  final String imageUrl;
  final CouponStatus status;

  Coupon({
    required this.id,
    required this.storeName,
    required this.description,
    required this.expiryDate,
    required this.imageUrl,
    required this.status,
  });

  int get daysUntilExpiry {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final expiry = DateTime(expiryDate.year, expiryDate.month, expiryDate.day);
    return expiry.difference(today).inDays;
  }

  bool get isExpiringToday => daysUntilExpiry == 0;

  String get dDayText {
    final days = daysUntilExpiry;
    if (days == 0) {
      return '오늘마감';
    } else if (days > 0) {
      return 'D-$days';
    } else {
      return '만료';
    }
  }

  String get formattedExpiryDate {
    if (isExpiringToday) {
      return '유효기한: 오늘까지!';
    }
    return '유효기한: ~ ${expiryDate.year}.${expiryDate.month.toString().padLeft(2, '0')}.${expiryDate.day.toString().padLeft(2, '0')}까지';
  }
}