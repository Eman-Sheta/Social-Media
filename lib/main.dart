import 'package:flutter/material.dart';
import 'package:social_media/view/pages/home_page.dart';
import 'package:social_media/view/presentation/themes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(color: MyTheme.appbar),
          brightness: Brightness.light
      ),
      home: const HomePage(),
    );
  }
}
