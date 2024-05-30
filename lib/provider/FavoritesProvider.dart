import 'package:flutter/material.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Map<String, String>> _favorites = [];

  List<Map<String, String>> get favorites => _favorites;

  void addFavorite(Map<String, String> product) {
    _favorites.add(product);
    notifyListeners();
  }

  bool isFavorite(String imageUrl) {
    return _favorites.any((product) => product['imageUrl'] == imageUrl);
  }
    void removeFavorite(String imageUrl) {
    _favorites.removeWhere((product) => product['imageUrl'] == imageUrl);
    notifyListeners();
  }

  void toggleFavorite(String imageUrl) {
    if (isFavorite(imageUrl)) {
      _favorites.removeWhere((product) => product['imageUrl'] == imageUrl);
    } else {
      // If the product is not already a favorite, you may want to add it here.
      // For now, let's assume we're just toggling the favorite status.
    }
    notifyListeners();
  }
}

