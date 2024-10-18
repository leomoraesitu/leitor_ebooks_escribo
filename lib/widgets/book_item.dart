import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:leitor_ebooks_escribo/models/book.dart';
import 'package:leitor_ebooks_escribo/providers/book_provider.dart';

class BookItem extends StatelessWidget {
  final Book book;

  BookItem(this.book);

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context, listen: false);

    return GridTile(
      child: GestureDetector(
        onTap: () {
          // Navegação para a tela de leitura
        },
        child: Image.network(
          book.coverUrl,
          fit: BoxFit.cover,
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          icon: Icon(
            bookProvider.favorites.contains(book) ? Icons.favorite : Icons.favorite_border,
          ),
          color: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            bookProvider.toggleFavorite(book);
          },
        ),
        title: Text(
          book.title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
