import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:leitor_ebooks_escribo/providers/book_provider.dart';
import 'package:leitor_ebooks_escribo/screens/book_shelf_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => BookProvider(),
      child: MaterialApp(
        title: 'Leitor de eBooks',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xff00299f),
          textTheme: GoogleFonts.workSansTextTheme(),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color:Color(0xff00299f)),
            backgroundColor: Colors.white,
            titleTextStyle: GoogleFonts.workSans(
              textStyle: TextStyle(
                fontSize: 20,
                color: Color(0xff00299f),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        home: BookShelfScreen(),
      ),
    );
  }
}
