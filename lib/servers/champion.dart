import 'package:dio/dio.dart';
import 'dart:async';

Future<Map<String, dynamic>> getChampion(String id) async {
  Response response = await Dio().get('https://ddragon.leagueoflegends.com/cdn/11.12.1/data/pt_BR/champion/$id.json');

  Map<String, dynamic> championResponse = response.data["data"];
  Map<String, dynamic> championInfor = {};

  for (final champion in championResponse.keys) {
    final String id = championResponse[champion]["name"];
    final String name = championResponse[champion]["name"];
    final String title = championResponse[champion]["title"];
    final List tags = championResponse[champion]["tags"];
    final String imageFull = championResponse[champion]["image"]["full"];
    final String imageFormat = imageFull.substring(0, imageFull.length-4);
    List<Map<String, dynamic>> skins = [];
    final String lore = championResponse[champion]["lore"];
    final List<dynamic> allytips = championResponse[champion]["allytips"];
    final List<dynamic> enemytips = championResponse[champion]["enemytips"];
    final Map<String, dynamic> info = championResponse[champion]["info"];
    final Map<String, dynamic> stats = championResponse[champion]["stats"];

    championResponse[champion]["skins"].map((e) => 
      skins.add({
        "skin": "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/"+imageFormat+"_"+e["num"].toString()+".jpg",
        "name": e["name"] == "default" ? name : e["name"]
      })
    ).toList();

    championInfor["id"] = id;
    championInfor["name"] = name;
    championInfor["title"] = title;
    championInfor["image"] = "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/"+imageFormat+"_0.jpg";
    championInfor["tags"] = tags;
    championInfor["skins"] = skins;
    championInfor["lore"] = lore;
    championInfor["allytips"] = allytips;
    championInfor["enemytips"] = enemytips;
    championInfor["info"] = info;
    championInfor["stats"] = stats;
  }
  
  return championInfor;
}