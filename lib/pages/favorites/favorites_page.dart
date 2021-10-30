import 'package:flutter/material.dart';
import 'package:lol/components/app_bar_back.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height + 15),
        child: const AppBarBack(name: 'Favoritos'),
      ),
      body: Container(),
    );
  }
}
