import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class BookReaderScreen extends StatelessWidget {
  final String bookUrl;
  final String coverUrl;

  const BookReaderScreen(this.bookUrl, this.coverUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Página de Leitura',
          style: GoogleFonts.workSans(
            textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontSize: 21,
                  color: Color(0xff00299f),
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              coverUrl,
              fit: BoxFit.cover,
              height: 300,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text(
                'Abrir',
                style: GoogleFonts.workSans(
                  textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontSize: 16,
                        color: Color(0xff00299f),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              onPressed: () {
                VocsyEpub.open(
                  bookUrl,
                  // Configurações adicionais
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
