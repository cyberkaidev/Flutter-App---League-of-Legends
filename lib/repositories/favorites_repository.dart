import 'dart:collection';
import 'package:flutter/material.dart';

class FavoritesRepository extends ChangeNotifier {
  final List<Map<String, dynamic>> _list = [];

  UnmodifiableListView<Map<String, dynamic>> get list => (
    UnmodifiableListView(_list)
  );

  saveAll(Map<String, dynamic> champion) {
    if (isIndex(champion).isNegative) {
      _list.add(champion);
      notifyListeners();
    }
  }

  remove(Map<String, dynamic> champion) {
    _list.remove(_list[isIndex(champion)]);
    notifyListeners();
  }

  isIndex(Map<String, dynamic> champion) {
    return _list.indexWhere((element) => element['id'] == champion['id']);
  }
}
