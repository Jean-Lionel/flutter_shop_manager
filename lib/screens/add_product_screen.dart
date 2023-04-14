import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop_manager/providers/product.dart';
import 'package:flutter_shop_manager/providers/products.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/add-product-screen";
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  var _imageUrlController = TextEditingController();
  var _isLoading = false;
  String _product_id = "";
  bool _isFavorite = false;
  String _title = "";
  String _description = "";
  String _imageUrl = "";
  double _price = 0.0;
  final _formKey = GlobalKey<FormState>();

  var product;

  Future<void> _submitForm() async {
    final validate = _formKey.currentState!.validate();
    if (!validate) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    _formKey.currentState!.save();
    if (_product_id.isEmpty) {
      _product_id = DateTime.now().toString();
    }
    product = Product(
      id: _product_id,
      title: _title,
      price: _price,
      description: _description,
      imageUrl: _imageUrl,
      isFavorite: _isFavorite,
    );

    try {
      await Provider.of<Products>(context, listen: false).addItem(product);
      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
        context: context,
        builder: (cxt) => AlertDialog(
          title: Text("Erreur"),
          content: Text("Erreur"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Okay"),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  var _isInitial = true;

  @override
  void didChangeDependencies() {
    if (_isInitial) {
      final productId = ModalRoute.of(context)?.settings.arguments;
      if (productId != null) {
        Product p =
            Provider.of<Products>(context).findById(productId as String);
        _product_id = p.id;
        _title = p.title;
        _description = p.description;
        _price = p.price;
        _isFavorite = p.isFavorite;
        //_imageUrl = p.imageUrl;
        _imageUrlController.text = p.imageUrl;
      }
    }
    _isInitial = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _imageUrlController.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product "),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(children: [
                  TextFormField(
                    initialValue: _title,
                    decoration: const InputDecoration(labelText: "Title"),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter a title";
                      }
                      return null;
                    },
                    onSaved: (v) {
                      _title = v!;
                    },
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                  ),
                  TextFormField(
                    initialValue: _price.toString(),
                    decoration: const InputDecoration(labelText: "price"),
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter a price.";
                      }
                      if (double.tryParse(value) == null) {
                        return "Please enter a valid price.";
                      }

                      if (double.parse(value) <= 0) {
                        return "Please enter a price greater than zero.";
                      }

                      return null;
                    },
                    onSaved: (v) {
                      if (double.tryParse(v as String) != null) {
                        _price = double.parse(v as String);
                      } else {
                        _price = 0.0;
                      }
                    },
                    onFieldSubmitted: (v) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                  ),
                  TextFormField(
                    initialValue: _description,
                    decoration: const InputDecoration(labelText: "Description"),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    focusNode: _descriptionFocusNode,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Please select a description";
                      }
                      return null;
                    },
                    onSaved: (v) {
                      _description = v!;
                    },
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, right: 10),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 2,
                        color: Colors.grey,
                      )),
                      child: _imageUrlController.text.isEmpty
                          ? const Text("No Image")
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Image Url"),
                        controller: _imageUrlController,
                        textInputAction: TextInputAction.done,
                        onSaved: (v) {
                          _imageUrl = v!;
                        },
                        onFieldSubmitted: (_) {
                          _submitForm();
                        },
                      ),
                    ),
                  ]),
                ]),
              ),
            ),
    );
  }
}
