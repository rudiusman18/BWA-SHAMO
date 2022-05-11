import 'package:bwa_shamo/models/category_model.dart';
import 'package:bwa_shamo/models/product_model.dart';

import 'package:bwa_shamo/services/product_service.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _product = [];
  ProductModel _product1 = ProductModel();
  List<CategoryModel> _category = [];

  // mengatur getter pada ProductModel
  List<ProductModel> get product => _product;
  ProductModel get product1 => _product1;
  List<CategoryModel> get category => _category;

  // Mengatur setter pada ProductModel
  set product(List<ProductModel> product) {
    _product = product;
    notifyListeners();
  }

  set product1(ProductModel product) {
    _product1 = product;
    notifyListeners();
  }

  set category(List<CategoryModel> category) {
    _category = category;
    notifyListeners();
  }

  getProduct() async {
    try {
      List<ProductModel> product = await ProductService().getProducts();
      _product = product;
      return true;
    } catch (e) {
      print(e); // Melakukan cetak pesan error jika terdapat error
      return false;
    }
  }

  getCategory() async {
    try {
      List<CategoryModel> category = await ProductService().getCategory();
      _category = category;
      return true;
    } catch (e) {
      print(e); // Melakukan cetak pesan error jika terdapat error
      return false;
    }
  }
}
