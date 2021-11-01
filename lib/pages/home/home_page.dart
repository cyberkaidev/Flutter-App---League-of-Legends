import 'package:flutter/material.dart';
import 'package:lol/components/app_bars/app_bar_home.dart';
import 'package:lol/components/cards/card_champion.dart';
import 'package:lol/components/messages/message_error.dart';
import 'package:lol/repositories/favorites_repository.dart';
import 'package:lol/servers/champions.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height + 15),
        child: const AppBarHome(),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: FutureBuilder<dynamic>(
              future: getChampions(),
              builder: (context, snapshot) {
                // ignore: avoid_print
                if (snapshot.hasError) return const MessageError();
                return snapshot.hasData ?
                ChampionsList(champ: snapshot.data)
                : const Center(
                  child: CircularProgressIndicator(color: Colors.white)
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class ChampionsList extends StatelessWidget {
  final List<Map<String, dynamic>> champ;
  late FavoritesRepository favorites;

  ChampionsList({Key? key, required this.champ}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    favorites = context.watch<FavoritesRepository>();

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: champ.length,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      itemBuilder: (context, index) {
        return CardChampion(
          id: champ[index]["id"],
          name: champ[index]["name"],
          title: champ[index]["title"],
          image: champ[index]["image"],
          iconChampion: champ[index]["icon"],
          tags: champ[index]["tags"],
          isFavorite: favorites.isIndex(champ[index]),
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
  }
}