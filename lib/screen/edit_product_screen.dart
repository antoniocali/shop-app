import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';

import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = "/edit-product";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _urlTextController = TextEditingController();
  final _urlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  Map<String, String> _initValues = {
    'title': '',
    'description': '',
    'imageUrl': '',
    'price': '',
    'id': null,
  };
  bool _init = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _urlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    if (!_init) {
      final _product = ModalRoute.of(context).settings.arguments as Product;
      if (_product != null) {
        _initValues['title'] = _product.title;
        _initValues['description'] = _product.description;
        _initValues['price'] = _product.price.toString();
        _initValues['imageUrl'] = _product.imageUrl;
        _initValues['id'] = _product.id;
        _urlTextController.text = _product.imageUrl;
      }
      _init = true;
    }
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_urlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _urlTextController.dispose();
    _urlFocusNode.removeListener(_updateImageUrl);
    _urlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      setState(() {
        _isLoading = true;
      });

      final Products _products = Provider.of<Products>(context, listen: false);
      try {
        await _products.addItem(
            _initValues['title'],
            _initValues['description'],
            _initValues['price'],
            _initValues['imageUrl'],
            _initValues['id']);

        Navigator.of(context).pop();
      } catch (_) {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Error occurs"),
              content: Text("Something went wrong."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Okay"),
                  onPressed: () => Navigator.of(ctx).pop(),
                )
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
            ),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(
                        labelText: "Title",
                      ),
                      validator: (value) {
                        if (value.isNotEmpty)
                          return null;
                        else
                          return "Please provide a title";
                      },
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_priceFocusNode),
                      onSaved: (value) => _initValues['title'] = value,
                    ),
                    TextFormField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(
                        labelText: "Price",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please provide a price";
                        }
                        if (double.tryParse(value) == null) {
                          return "Please provide a valid number";
                        }
                        if (double.parse(value) <= 0) {
                          return "Please provide a positive price";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode),
                      onSaved: (value) => _initValues['price'] = value,
                    ),
                    TextFormField(
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(
                        labelText: "Description",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Provide a description";
                        }
                        return null;
                      },
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) => _initValues['description'] = value,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8, right: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: _urlTextController.text.isEmpty
                              ? Text("Url not provided")
                              : FittedBox(
                                  child: Image.network(
                                    _urlTextController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: "Url"),
                            controller: _urlTextController,
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            focusNode: _urlFocusNode,
                            onFieldSubmitted: (_) => _saveForm(),
                            onSaved: (value) => _initValues['imageUrl'] = value,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
