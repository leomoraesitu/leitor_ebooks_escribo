import 'package:flutter/material.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class BookReaderScreen extends StatelessWidget {
  final String bookUrl;

  BookReaderScreen(this.bookUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leitor de eBooks'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Abrir Livro'),
          onPressed: () {
            VocsyEpub.open(
              bookUrl,
              // Configurações adicionais
            );
          },
        ),
      ),
    );
  }
}
