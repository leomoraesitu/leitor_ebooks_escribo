// lib/screens/favorites_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:leitor_ebooks_escribo/providers/book_provider.dart';
import 'package:leitor_ebooks_escribo/widgets/book_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favoritos',
          style: GoogleFonts.workSans(
            textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontSize: 21,
              color: Color(0xff00299f),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: bookProvider.favorites.length,
        itemBuilder: (ctx, i) => BookItem(bookProvider.favorites[i]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
