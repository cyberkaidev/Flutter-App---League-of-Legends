import 'package:flutter/material.dart';
import 'package:lol/components/app_bar_home.dart';
import 'package:lol/components/card_champion.dart';
import 'package:lol/servers/champions.dart';

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
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData ?
                ChampionsList(champ: snapshot.data)
                : const Center(
                  child: CircularProgressIndicator(color: Colors.black)
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ChampionsList extends StatelessWidget {
  final List<Map<String, dynamic>> champ;

  const ChampionsList({Key? key, required this.champ}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          onSubmit: (String value, bool action) {}
        );
      },
    );
  }
}
