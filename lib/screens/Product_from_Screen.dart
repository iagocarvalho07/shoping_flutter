import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_flutter/models/products.dart';
import 'package:shoping_flutter/models/products_list.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final priceFocus = FocusNode();
  final descriptionFocus = FocusNode();
  final imageFocus = FocusNode();
  final _imageUrlControler = TextEditingController();
  final _formeKey = GlobalKey<FormState>();
  final _formDataMap = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    _imageUrlControler.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_formDataMap.isEmpty){
      final argument = ModalRoute.of(context)?.settings.arguments;
      if(argument != null){
        final product = argument as Product;
        _formDataMap['id'] = product.id;
        _formDataMap['name'] = product.title;
        _formDataMap['descricao'] = product.description;
        _formDataMap['preco'] = product.price;
        _formDataMap['imageUrl'] = product.imageUrl;

        _imageUrlControler.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    priceFocus.dispose();
    descriptionFocus.dispose();
    _imageUrlControler.removeListener(updateImage);
    imageFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  void _submitForm() {
    final isValide = _formeKey.currentState?.validate() ?? false;
    if (!isValide) {
      return;
    }
    _formeKey.currentState?.save();
    // final newProduct = Product(
    //   id: Random().nextDouble().toString(),
    //   title: _formDataMap['name'] as String,
    //   description: _formDataMap['descricao'] as String,
    //   price: _formDataMap['preco'] as double,
    //   imageUrl: _formDataMap['imageUrl'] as String,
    // );
    Provider.of<ProductsList>(context, listen: false).addProductFromData(_formDataMap);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formalario de Produtos"),
        actions: [
          IconButton(onPressed: _submitForm, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formeKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formDataMap['name']?.toString(),
                decoration: const InputDecoration(labelText: 'Nome'),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(priceFocus);
                },
                textInputAction: TextInputAction.next,
                onSaved: (name) => _formDataMap['name'] = name ?? '-',
                validator: (_name) {
                  final name = _name ?? '';
                  if (name.trim().isEmpty) {
                    return "Nome é Obrigatorio";
                  }
                  if (name.trim().length < 3) {
                    return "Nome pricisa no minimo de 3 letras";
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formDataMap['preco']?.toString(),
                decoration: const InputDecoration(labelText: 'Preço'),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(descriptionFocus);
                },
                focusNode: priceFocus,
                textInputAction: TextInputAction.next,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSaved: (preco) =>
                    _formDataMap['preco'] = double.parse(preco ?? '0'),
                validator: (_preci) {
                  final priceString = _preci ?? '-1';
                  final prince = double.tryParse(priceString) ?? -1;
                  if (prince <= 0) {
                    return 'informe um preço valido';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formDataMap['descricao']?.toString(),
                decoration: const InputDecoration(labelText: 'Descrição'),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(imageFocus);
                },
                onSaved: (descricao) =>
                    _formDataMap['descricao'] = descricao ?? '-',
                focusNode: descriptionFocus,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                validator: (_descricao) {
                  final descricao = _descricao ?? '';
                  if (descricao.trim().isEmpty) {
                    return "descrição é Obrigatorio";
                  }
                  if (descricao.trim().length < 10) {
                    return "descrição pricisa no minimo de 10 letras";
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Url Da Imagem'),
                      focusNode: imageFocus,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      controller: _imageUrlControler,
                      onFieldSubmitted: (_) => _submitForm(),
                      onSaved: (imageUrl) =>
                          _formDataMap['imageUrl'] = imageUrl ?? '-',
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1)),
                    alignment: Alignment.center,
                    child: _imageUrlControler.text.isEmpty
                        ? const Text("Informe A url")
                        : FittedBox(
                            child: Image.network(
                              _imageUrlControler.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
