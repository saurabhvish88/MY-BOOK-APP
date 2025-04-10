import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Model/book.dart';

class BookViewModel extends ChangeNotifier {
  List<Book> _books = [];
  List<Book> get books => _books;

  List<Book> _filteredBooks = [];
  List<Book> get filteredBooks => _filteredBooks;

  List<Book> _favourites = [];
  List<Book> get favourites => _favourites;

  int _offset = 0;
  final int _limit = 20;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final String _baseUrl = 'https://openlibrary.org/subjects/novel.json';

  BookViewModel() {
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse("$_baseUrl?limit=$_limit&offset=$_offset"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Book> fetchedBooks =
            (data['works'] as List).map((json) => Book.fromJson(json)).toList();

        _books.addAll(fetchedBooks);
        _filteredBooks = List.from(_books); // initially set filtered to all
        _offset += _limit;
      } else {
        throw Exception("Failed to load books");
      }
    } catch (e) {
      print("Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  void toggleFavourite(Book book) {
    if (_favourites.contains(book)) {
      _favourites.remove(book);
    } else {
      _favourites.add(book);
    }
    notifyListeners();
  }

  bool isFavourite(Book book) {
    return _favourites.contains(book);
  }

  void removeFromFavourites(Book book) {
    _favourites.remove(book);
    notifyListeners();
  }

  void filterBooks(String query) {
    if (query.isEmpty) {
      _filteredBooks = List.from(_books);
    } else {
      _filteredBooks = _books
          .where(
              (book) => book.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
