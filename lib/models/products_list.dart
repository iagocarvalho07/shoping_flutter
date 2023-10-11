import 'package:flutter/material.dart';
import 'package:shoping_flutter/data/dummy_data.dart';
import 'package:shoping_flutter/models/products.dart';

class ProductsList with ChangeNotifier {
  List<Product> _Items = dummyProducts;

  // bool _showFavoriteOnly = false;

  List<Product> get items => [..._Items];

  List<Product> get itemsFavorite =>
      _Items.where((element) => element.isfavorite).toList();

  void addProduct(Product product) {
    _Items.add(product);
    notifyListeners();
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
