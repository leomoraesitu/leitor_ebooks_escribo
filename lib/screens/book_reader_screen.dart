import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class BookReaderScreen extends StatelessWidget {
  final String bookUrl;  // URL para baixar o livro
  final String coverUrl; // URL da capa do livro

  const BookReaderScreen(this.bookUrl, this.coverUrl, {super.key});

  Future<void> _downloadAndOpenBook(BuildContext context) async {
    try {
      // Obtém o diretório de documentos do aplicativo
      final dir = await getApplicationDocumentsDirectory();

      // Define o caminho do arquivo EPUB (usando o último segmento da URL como nome do arquivo)
      final file = File('${dir.path}/${Uri.parse(bookUrl).pathSegments.last}');

      // Baixa o livro apenas se ele ainda não existir
      if (!file.existsSync()) {
        final response = await http.get(Uri.parse(bookUrl));
        if (response.statusCode == 200) {
          await file.writeAsBytes(response.bodyBytes);
        } else {
          throw Exception('Falha ao baixar o livro: ${response.statusCode}');
        }
      }

      // Abre o livro usando VocsyEpubViewer
      VocsyEpub.open(
        file.path,  // Caminho local do arquivo EPUB
        //lastLocation: '',  // Última posição de leitura (opcional)
        // Configurações adicionais podem ser passadas aqui
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao baixar o livro: $e')),
      );
    }
  }

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
            // Exibição da capa do livro
            Image.network(
              coverUrl,
              fit: BoxFit.cover,
              height: 300,
            ),
            SizedBox(height: 20),

            // Botão para baixar e abrir o livro
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
              onPressed: () => _downloadAndOpenBook(context), // Faz o download e abre o livro
            ),
          ],
        ),
      ),
    );
  }
}
