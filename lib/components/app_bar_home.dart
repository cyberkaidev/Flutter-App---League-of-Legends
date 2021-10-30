import 'package:flutter/material.dart';
import 'package:lol/pages/favorites/favorites_page.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 20,
      title: const Text('League of Legends'),
      leadingWidth: double.infinity,
      elevation: 0,
      toolbarHeight: AppBar().preferredSize.height + 15,
      backgroundColor: const Color(0xFF111111),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesPage())
            );
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 20),
            child: const Text(
              'Favoritos',
              style: TextStyle(
                color: Color(0xFF0CDEFF), fontWeight: FontWeight.bold
              ),
            ),
          ),
        )
      ],
    );
  }
}
