import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../utils/constants.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isfavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isfavorite = false,
  });

  void _toggleFavorite(){
    isfavorite = !isfavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String userId) async {
    try {
      _toggleFavorite();

      final response = await put(
        Uri.parse(
          '${Constants.userFavoriteUrl}/$userId/$id.json?auth=$token',
        ),
        body: jsonEncode(isfavorite),
      );

      if (response.statusCode >= 400) {
        _toggleFavorite();
      }
    } catch (_) {
      _toggleFavorite();
    }
  }
}