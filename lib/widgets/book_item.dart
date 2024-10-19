import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:leitor_ebooks_escribo/models/book.dart';
import 'package:leitor_ebooks_escribo/providers/book_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:leitor_ebooks_escribo/screens/book_reader_screen.dart';

class BookItem extends StatelessWidget {
  final Book book;

  const BookItem(this.book, {super.key});

  Future<void> _downloadAndOpenBook(BuildContext context) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/${book.id}.epub');

      if (!file.existsSync()) {
        final response = await http.get(Uri.parse(book.downloadUrl));
        await file.writeAsBytes(response.bodyBytes);
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BookReaderScreen(file.path, book.coverUrl),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao baixar o livro: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Stack(
            children: [
              GestureDetector(
                onTap: () => _downloadAndOpenBook(context),
                child: Image.network(
                  book.coverUrl,
                  fit: BoxFit.cover,                  
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    bookProvider.favorites.contains(book)
                        ? Icons.bookmark_sharp
                        : Icons.bookmark_border_sharp,
                    color: bookProvider.favorites.contains(book)
                        ? Colors.red
                        : Color(0xff00299f),
                    size: 48,
                  ),
                  onPressed: () {
                    bookProvider.toggleFavorite(book);
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _downloadAndOpenBook(context),
                child: Text(
                  book.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    //color: Color(0xff00299f),
                  ),
                ),
              ),
              Text(
                book.author,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
