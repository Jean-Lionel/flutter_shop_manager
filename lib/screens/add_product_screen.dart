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
  final _imageUrlController = TextEditingController();
  String _title = "";
  String _description = "";
  String _imageUrl = "";
  double _price = 0.0;
  final _formKey = GlobalKey<FormState>();

  var product;

  void _submitForm() {
    final validate = _formKey.currentState!.validate();
    if (!validate) {
      return;
    }
    _formKey.currentState!.save();
    product = Product(
      id: DateTime.now().toString(),
      title: _title,
      price: _price,
      description: _description,
      imageUrl: _imageUrl,
    );

    Provider.of<Products>(context, listen: false).addItem(product);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Title"),
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
              decoration: InputDecoration(labelText: "price"),
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
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Description"),
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
                    ? Text("No Image")
                    : FittedBox(
                        child: Image.network(
                          _imageUrlController.text,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Image Url"),
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
