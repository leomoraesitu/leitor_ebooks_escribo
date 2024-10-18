class Book {
  final String id;
  final String title;
  final String coverUrl;
  final String downloadUrl;

  Book({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.downloadUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      coverUrl: json['cover_url'],
      downloadUrl: json['download_url'],
    );
  }
}
