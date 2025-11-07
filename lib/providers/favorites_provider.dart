import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  static const _kKey = 'favorites_v1';
  final Set<String> _ids = {};

  FavoritesProvider() {
    _load();
  }

  bool isFavorite(String id) => _ids.contains(id);
  List<String> get all => _ids.toList();

  Future<void> toggle(String id) async {
    if (_ids.contains(id)) _ids.remove(id); else _ids.add(id);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_kKey, _ids.toList());
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_kKey) ?? [];
    _ids.addAll(list);
    notifyListeners();
  }

  Future<void> clear() async {
    _ids.clear();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kKey);
  }
}
