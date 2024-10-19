import 'package:flutter/material.dart';
import 'package:leitor_ebooks_escribo/screens/favorites_screen.dart';
import 'package:provider/provider.dart';
import 'package:leitor_ebooks_escribo/providers/book_provider.dart';
import 'package:leitor_ebooks_escribo/widgets/book_item.dart';
import 'package:google_fonts/google_fonts.dart';

class BookShelfScreen extends StatelessWidget {
  const BookShelfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Estante Virtual Escribo',
          style: GoogleFonts.workSans(
            textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontSize: 21,
              color: Color(0xff00299f),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Row(
              children: [
                Icon(Icons.bookmark),
                SizedBox(width: 4),
                Text(
                  'Favoritos',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff00299f),
                    fontFamily: GoogleFonts.workSans().fontFamily,
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<BookProvider>(context, listen: false).loadBooks(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(child: Text('Erro ao carregar livros.'));
            } else {
              return Consumer<BookProvider>(
                builder: (ctx, bookProvider, child) => GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: bookProvider.books.length,
                  itemBuilder: (ctx, i) => BookItem(bookProvider.books[i]),
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
        },
      ),
    );
  }
}
