import 'package:bwa_shamo/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class WishlistProvider with ChangeNotifier {
  List<ProductModel> _wishlist = [];

  // Membuat getter
  List<ProductModel> get wishlist => _wishlist;

  // membuat setter
  set wishlist(List<ProductModel> wishlist) {
    _wishlist = wishlist;
    notifyListeners();
  }

  setProduct(ProductModel product) {
    if (!isWishlist(product)) {
      _wishlist.add(product);
    } else {
      _wishlist.remove(product);
    }

    notifyListeners();
  }

  isWishlist(ProductModel product) {
    // Kode dibawah digunakan untuk mendapatkan index dari sebuah elemen dengan mencocokkan id dari element yang merupakan turunan dari _wishlist dan id dari product
    if (_wishlist.indexWhere((element) => element.id == product.id) == -1) {
      return false;
    } else {
      return true;
    }
  }
}
