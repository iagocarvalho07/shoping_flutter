import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_flutter/models/products_list.dart';
import '../components/product_grid.dart';

enum FilterOptions{
  Favorito,
  All,
}

class ProductsOverViewScreen extends StatefulWidget {
  const ProductsOverViewScreen({super.key});

  @override
  State<ProductsOverViewScreen> createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ProductsList>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Minha Loja"),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favorito,
                child: Text("Somente Favoritos"),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text("Todos"),
              ),
            ],
            onSelected:(FilterOptions selecte){
              setState(() {
                if(selecte == FilterOptions.Favorito){
                  _showFavoriteOnly = true;
                }else{
                  _showFavoriteOnly = false;
                }
              },);
            } ,
          ),
        ],
      ),
      body: ProductGrid(showfavoriteOnly: _showFavoriteOnly,),
    );
  }
}