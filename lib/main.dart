import 'package:flutter/material.dart';
import 'package:flutter_book_search/ui/detail/detail_page.dart';
import 'package:flutter_book_search/ui/home/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      // home: DetailPage(),
    );
  }
}
