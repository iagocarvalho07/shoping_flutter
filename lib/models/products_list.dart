import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shoping_flutter/data/dummy_data.dart';
import 'package:shoping_flutter/models/products.dart';

class ProductsList with ChangeNotifier {
  String _token;
  List<Product> _Items = [];

  ProductsList(this._token, this._Items);

  final _baseUrl = 'https://shop-flutter-fb908-default-rtdb.firebaseio.com';
  final _baseUrlGet =
      'https://shop-flutter-fb908-default-rtdb.firebaseio.com/products.json';
  final _baseUrlUpdate =
      'https://shop-flutter-fb908-default-rtdb.firebaseio.com/products';

  // bool _showFavoriteOnly = false;

  List<Product> get items => [..._Items];

  List<Product> get itemsFavorite =>
      _Items.where((element) => element.isfavorite).toList();

  Future<void> addProductFromData(Map<String, dynamic> _formDataMap) {
    bool hasId = _formDataMap['id'] != null;
    final newProduct = Product(
      id: hasId ? _formDataMap['id'] : Random().nextDouble().toString(),
      title: _formDataMap['name'] as String,
      description: _formDataMap['descricao'] as String,
      price: _formDataMap['preco'] as double,
      imageUrl: _formDataMap['imageUrl'] as String,
    );

    if (hasId) {
      return updateProdut(newProduct);
    } else {
      return addProduct(newProduct);
    }
  }

  Future<void> addProduct(Product product) {
    final future = post(
      Uri.parse('$_baseUrl/products.json?auth=$_token'),
      body: jsonEncode({
        "name": product.title,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
        "isFavorite": product.isfavorite,
      }),
    );
    return future.then<void>((value) {
      final id = jsonDecode(value.body)['name'];
      _Items.add(
        Product(
          id: id,
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
          isfavorite: product.isfavorite,
        ),
      );
      notifyListeners();
    });
  }

  Future<void> loadProducts() async {
    _Items.clear();
    final getProductsFromFb = await get(Uri.parse('$_baseUrlGet?auth=$_token'));
    print(" oque que aconteceu ${getProductsFromFb.body} final da solicitação");
    Map<String, dynamic> data = jsonDecode(getProductsFromFb.body);
    data.forEach((productId, productData) {
      _Items.add(
        Product(
            id: productId,
            title: productData['name'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isfavorite: productData['isFavorite']),
      );
    });
    notifyListeners();
  }

  Future<void> updateProdut(Product product) async {
    int index = _Items.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      await patch(
        Uri.parse('$_baseUrlUpdate/${product.id}.json?auth=$_token'),
        body: jsonEncode({
          "name": product.title,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        }),
      );
      _Items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product) async {
    int index = _Items.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      await delete(
        Uri.parse('$_baseUrlUpdate/${product.id}.json?auth=$_token'),
      );
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
