import 'package:flutter/material.dart';
import 'package:leitor_ebooks_escribo/screens/favorites_screen.dart';
import 'package:provider/provider.dart';
import 'package:leitor_ebooks_escribo/providers/book_provider.dart';
import 'package:leitor_ebooks_escribo/widgets/book_item.dart';

class BookShelfScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estante de Livros'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
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
                  padding: const EdgeInsets.all(10.0),
                  itemCount: bookProvider.books.length,
                  itemBuilder: (ctx, i) => BookItem(bookProvider.books[i]),
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
        },
      ),
    );
  }
}
