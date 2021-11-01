import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lol/pages/home/home_page.dart';
import 'package:lol/repositories/favorites_repository.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF2E3034),
      statusBarColor: Color(0xFF2E3034),
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Color(0xFF2E3034),
      systemNavigationBarIconBrightness: Brightness.light
    )
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesRepository(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF2E3034),
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.white)
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2E3034)
        )
      ),
      home: const HomePage()
    );
  }
}
