import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/Model/book.dart';

class ApiService {
  static Future<List<Book>> fetchBooks(int page) async {
    final response = await http.get(
      Uri.parse(
          'https://openlibrary.org/subjects/novel.json?limit=10&offset=${page * 10}'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final works = data['works'] as List;
      return works.map((e) => Book.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
