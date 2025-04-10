class Book {
  final String title;
  final String author;
  final String? coverUrl;

  Book({
    required this.title,
    required this.author,
    this.coverUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'No Title',
      author: (json['authors'] != null &&
              json['authors'] is List &&
              json['authors'].isNotEmpty)
          ? json['authors'][0]['name'] ?? 'Unknown'
          : 'Unknown',
      coverUrl: json['cover_id'] != null
          ? 'https://covers.openlibrary.org/b/id/${json['cover_id']}-M.jpg'
          : null,
    );
  }
}
