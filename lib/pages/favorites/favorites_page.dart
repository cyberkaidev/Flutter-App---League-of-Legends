import 'package:flutter/material.dart';
import 'package:lol/components/app_bars/app_bar_back.dart';
import 'package:lol/components/cards/card_champion.dart';
import 'package:lol/repositories/favorites_repository.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late FavoritesRepository favorites;

  @override
  Widget build(BuildContext context) {
    //favorites = Provider.of<FavoritesRepository>(context);
    favorites = context.watch<FavoritesRepository>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height + 15),
        child: const AppBarBack(name: 'Favoritos'),
      ),
      body: Consumer<FavoritesRepository>(
        builder: (context, favorites, child) {
          return favorites.list.isEmpty
          ? const EmptyList()
          : ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            itemCount: favorites.list.length,
            itemBuilder: (_, index) {
              return CardChampion(
                id: favorites.list[index]["id"],
                name: favorites.list[index]["name"],
                title: favorites.list[index]["title"],
                image: favorites.list[index]["image"],
                tags: favorites.list[index]["tags"],
                isFavorite: favorites.isIndex(favorites.list[index]),
                onSubmit: (Map<String, dynamic> value, bool action) {
                  if(action){
                    favorites.saveAll(value);
                  }else{
                    favorites.remove(value);
                  }
                }
              );
            },
          );
        },
      ),
    );
  }
}

class EmptyList extends StatelessWidget {
  const EmptyList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Opacity(
        opacity: 0.5,
        child: Text(
          'Você ainda não adicionou\nnenhum campeão ao\nseu favorito',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
