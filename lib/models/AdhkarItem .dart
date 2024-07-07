class AdhkarItem {
  final int id;
  final String category;
  final String audio;
  final String filename;
  final List<Map<String, dynamic>> array;
  int count;
  bool isFavorite;

  AdhkarItem({
    required this.id,
    required this.category,
    required this.audio,
    required this.filename,
    required this.array,
    this.count = 0,
    this.isFavorite = false,
  });

  factory AdhkarItem.fromJson(Map<String, dynamic> json) {
    return AdhkarItem(
      id: json['id'],
      category: json['category'],
      audio: json['audio'],
      filename: json['filename'],
      array: List<Map<String, dynamic>>.from(json['array']),
      count: json['count'] ?? 0,
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
