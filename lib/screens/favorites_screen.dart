// lib/screens/favorites_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:leitor_ebooks_escribo/providers/book_provider.dart';
import 'package:leitor_ebooks_escribo/widgets/book_item.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: bookProvider.favorites.length,
        itemBuilder: (ctx, i) => BookItem(bookProvider.favorites[i]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
