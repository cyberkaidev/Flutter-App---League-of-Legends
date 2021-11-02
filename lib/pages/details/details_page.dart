import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/rendering.dart';
import 'package:lol/components/app_bars/app_bar_back.dart';
import 'package:lol/components/cards/card_infor_champion.dart';
import 'package:lol/components/messages/message_error.dart';
import 'package:lol/servers/champion.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:lol/repositories/favorites_repository.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
  
  final String id;
  final String name;

  const DetailsPage({
    Key? key,
    required this.id,
    required this.name
  }) : super(key: key);
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height + 15),
        child: AppBarBack(name: widget.name),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return FutureBuilder<dynamic>(
            future: getChampion(widget.id),
            builder: (context, snapshot) {
              // ignore: avoid_print
              if (snapshot.hasError) return const MessageError();
              return snapshot.hasData
              ? ChampionInformation(champ: snapshot.data)
              : const Center(
                child: CircularProgressIndicator(color: Colors.white)
              );
            },
          );
        },
      )
    );
  }
}

class ChampionInformation extends StatefulWidget {
  @override
  _ChampionInformationState createState() => _ChampionInformationState();

  final Map<String, dynamic> champ;

  const ChampionInformation({
    Key? key,
    required this.champ
  }) : super(key: key);
}


class _ChampionInformationState extends State<ChampionInformation>with TickerProviderStateMixin {

  String name = "";
  bool showFloatingButton = true;

  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this
  )..forward();

  late final _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn
  );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _animation.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      name = widget.champ["skins"][0]["name"];
    });
  }

  @override
  Widget build(BuildContext context) {
    var favorites = context.watch<FavoritesRepository>();

    return Scaffold(
      body: NotificationListener<UserScrollNotification>(
        onNotification: (scroll) {
          if(scroll.direction == ScrollDirection.reverse
          && showFloatingButton) {
            _controller.reverse();
            showFloatingButton = false;
          }else if(scroll.direction == ScrollDirection.forward
          && !showFloatingButton) {
            _controller.forward();
            showFloatingButton = true;
          }
          return true;
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    StringUtils.capitalize(widget.champ["title"]),
                    style: const TextStyle(
                      fontSize: 20
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2,
                  margin: const EdgeInsets.only(bottom: 25),
                  child: Swiper(
                    itemBuilder: (BuildContext context,int index){
                      return SizedBox(
                        width: MediaQuery.of(context).size.width/1.5,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only( 
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(20)
                          ),
                          child: Image(
                            image: NetworkImage(widget.champ["skins"][index]["skin"]),
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      );
                    },
                    itemCount: widget.champ["skins"].length,
                    viewportFraction: 0.6,
                    scale: 0.9,
                    onIndexChanged: (int index) {
                      setState(() {
                        name = widget.champ["skins"][index]["name"];
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CardInforChampion(
                        title: "Tipo",
                        component: Row(
                          children: List.generate(
                            widget.champ["tags"].length, (index) => (
                              Text(
                                index+1 == widget.champ["tags"].length ?
                                widget.champ["tags"][index] :
                                widget.champ["tags"][index]+" - ",
                                style: const TextStyle(
                                  fontSize: 15
                                ),
                              )
                            )
                          ),
                        ),
                      ),
                      CardInforChampion(
                        title: "Informações",
                        component: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ataque: "+
                                widget.champ["info"]["attack"].toString(),
                                style: const TextStyle(
                                  fontSize: 15
                                ),
                              ),
                              Text("Defesa: "+
                                widget.champ["info"]["defense"].toString(),
                                style: const TextStyle(
                                  fontSize: 15
                                ),
                              ),
                              Text("Magia: "+
                                widget.champ["info"]["magic"].toString(),
                                style: const TextStyle(
                                  fontSize: 15
                                ),
                              ),
                              Text("Dificuldade: "+
                                widget.champ["info"]["difficulty"].toString(),
                                style: const TextStyle(
                                  fontSize: 15
                                ),
                              )
                            ]
                          ),
                        ),
                      ),
                      CardInforChampion(
                        title: "História",
                        component: Text(
                          widget.champ["lore"],
                          style: const TextStyle(
                            fontSize: 15
                          ),
                        ),
                      ),
                      CardInforChampion(
                        title: "Dicas de aliados",
                        component: Column(
                          children: List.generate(
                            widget.champ["allytips"].length, (index) => (
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: index+1 == widget.champ["allytips"].length ?
                                  0 : 10,
                                ),
                                child: Text(
                                  widget.champ["allytips"][index],
                                  style: const TextStyle(
                                    fontSize: 15
                                  ),
                                ),
                              )
                            )
                          ),
                        ),
                      ),
                      CardInforChampion(
                        title: "Dicas de inimigos",
                        component: Column(
                          children: List.generate(
                            widget.champ["enemytips"].length, (index) => (
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: index+1 == widget.champ["enemytips"].length ?
                                  0 : 10,
                                ),
                                child: Text(
                                  widget.champ["enemytips"][index],
                                  style: const TextStyle(
                                    fontSize: 15
                                  ),
                                ),
                              )
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      floatingActionButton: ScaleTransition(
        scale: _animation,
        child: FloatingActionButton(
          onPressed: () {
          // ignore: avoid_print
          if(favorites.isIndex(widget.champ).isNegative){
              favorites.saveAll(widget.champ);
            }else{
              favorites.remove(widget.champ);
            }
          },
          backgroundColor: const Color(0xFF0CDEFF),
          child: Icon(
            favorites.isIndex(widget.champ).isNegative
            ? Icons.favorite_border_sharp
            : Icons.favorite,
            color: const Color(0xFF111111)
          ),
        ),
      ),
    );
  }
}