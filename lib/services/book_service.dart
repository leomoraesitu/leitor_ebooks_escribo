import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:leitor_ebooks_escribo/models/book.dart';

class BookService {
  static const String apiUrl = 'https://escribo.com/books.json';

  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
