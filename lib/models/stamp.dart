class Stamp {
  final String storeId;
  final String storeName;
  final String imageUrl;
  final int targetCount;
  final String rewardText;
  List<bool> stamps;

  Stamp({
    required this.storeId,
    required this.storeName,
    required this.imageUrl,
    required this.targetCount,
    required this.rewardText,
    required this.stamps,
  });

  int get currentCount => stamps.where((stamp) => stamp).length;

  bool get isCompleted => currentCount >= targetCount;

  double get progress => currentCount / targetCount;

  void toggleStamp(int index) {
    if (index >= 0 && index < stamps.length) {
      stamps[index] = !stamps[index];
    }
  }

  void addStamp() {
    final firstEmptyIndex = stamps.indexOf(false);
    if (firstEmptyIndex != -1) {
      stamps[firstEmptyIndex] = true;
    }
  }

  void resetStamps() {
    stamps = List.filled(targetCount, false);
  }
}