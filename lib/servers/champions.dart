import 'package:dio/dio.dart';
import 'dart:async';

Future<List<Map<String, dynamic>>> getChampions() async {
  Response response = await Dio().get('https://ddragon.leagueoflegends.com/cdn/11.12.1/data/pt_BR/champion.json');

  Map<String, dynamic> champions = response.data["data"];
  List<Map<String, dynamic>> listChampions = [];

  for (final champion in champions.keys) {
    final String name = champions[champion]["name"];
    final String title = champions[champion]["title"];
    final List tags = champions[champion]["tags"];
    final String imageFull = champions[champion]["image"]["full"];
    final String idName = imageFull.substring(0, imageFull.length-4);

    listChampions.add({
      "id": idName,
      "name": name,
      "title": title,
      "image": "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/"+idName+"_0.jpg",
      "icon": "http://ddragon.leagueoflegends.com/cdn/11.12.1/img/champion/"+idName+".png",
      "tags": tags
    });
  }
  
  return listChampions;
}