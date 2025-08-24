class StampHistory {
  final int stampNumber;
  final DateTime date;
  final String? note;

  StampHistory({
    required this.stampNumber,
    required this.date,
    this.note,
  });

  /// JSON 직렬화를 위한 생성자 (향후 API 연동용)
  factory StampHistory.fromJson(Map<String, dynamic> json) {
    return StampHistory(
      stampNumber: json['stampNumber'] as int,
      date: DateTime.parse(json['date'] as String),
      note: json['note'] as String?,
    );
  }

  /// JSON 직렬화를 위한 메서드 (향후 API 연동용)
  Map<String, dynamic> toJson() {
    return {
      'stampNumber': stampNumber,
      'date': date.toIso8601String(),
      'note': note,
    };
  }

  /// 날짜를 사용자 친화적인 형식으로 포맷
  String get formattedDate {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }

  /// 시간까지 포함한 상세 포맷
  String get formattedDateTime {
    return '$formattedDate ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}