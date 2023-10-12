import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shoping_flutter/data/dummy_data.dart';
import 'package:shoping_flutter/models/products.dart';

class ProductsList with ChangeNotifier {
  List<Product> _Items = dummyProducts;

  // bool _showFavoriteOnly = false;

  List<Product> get items => [..._Items];

  List<Product> get itemsFavorite =>
      _Items.where((element) => element.isfavorite).toList();

  void addProductFromData(Map<String, dynamic> _formDataMap) {
    bool hasId = _formDataMap['id'] != null;
    final newProduct = Product(
      id: hasId ? _formDataMap['id'] : Random().nextDouble().toString(),
      title: _formDataMap['name'] as String,
      description: _formDataMap['descricao'] as String,
      price: _formDataMap['preco'] as double,
      imageUrl: _formDataMap['imageUrl'] as String,
    );

    if (hasId) {
      updateProdut(newProduct);
    } else {
      addProduct(newProduct);
    }
  }

  void addProduct(Product product) {
    _Items.add(product);
    notifyListeners();
  }

  void updateProdut(Product product) {
    int index = _Items.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      _Items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    int index = _Items.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      _Items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }

  int get itemsCount {
    return _Items.length;
  }
// if(_showFavoriteOnly){
//   return _Items.where((prod) => prod.isfavorite).toList();
// }
// return [..._Items];}

// void showFavoriteOnly(){
//   _showFavoriteOnly = true;
//   notifyListeners();
//
// }
// void showAll(){
//   _showFavoriteOnly = false;
//   notifyListeners();
// }
}
