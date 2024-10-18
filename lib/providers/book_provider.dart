import 'package:flutter/material.dart';
import 'package:leitor_ebooks_escribo/models/book.dart';
import 'package:leitor_ebooks_escribo/services/book_service.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];
  List<Book> get books => _books;

  List<Book> _favorites = [];
  List<Book> get favorites => _favorites;

  Future<void> loadBooks() async {
    _books = await BookService().fetchBooks();
    notifyListeners();
  }

  void toggleFavorite(Book book) {
    if (_favorites.contains(book)) {
      _favorites.remove(book);
    } else {
      _favorites.add(book);
    }
    notifyListeners();
  }
}
