import 'package:bwa_shamo/models/cart_model.dart';
import 'package:bwa_shamo/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _cart = [];

// Mengatur getter untuk CartModel
  List<CartModel> get cart => _cart;

  // Mengatur setter untuk CartModel
  set cart(List<CartModel> cart) {
    _cart = cart;
    notifyListeners();
  }

// digunakan untuk menambah quantity dari item yang sudah ada dan memasukkan kedalam keranjang untuk item yang belum ada
  addCart({required ProductModel product}) {
    print(product.name);
    if (productExist(product)) {
      int index =
          _cart.indexWhere((element) => (element.product.id == product.id));
      _cart[index]
          .quantity++; //dimaksudkan untuk membuat quantity pada item tertentu bertambah satu jika item tersebut sebelumnya telah ada didalam cart (keranjang)
    } else {
      _cart.add(
        CartModel(
          id: _cart.length,
          product: product,
          quantity: 1,
        ),
      );
    }

    notifyListeners();
  }

// digunakan untuk menghapus item yang diinginkan yang ada pada cart (keranjang)
  removeCart({required int id}) {
    print(id);
    if (_cart.length <= 1 && _cart.isNotEmpty) {
      _cart.removeAt(0);
    } else {
      _cart.removeAt(id);
    }
    //menghapus item pada list _cart sesuai dengan id yang diinginkan
    notifyListeners();
  }

// digunakan untuk menambah quantity dari item yang sudah ada didalam cart(keranjang)
  addQuantity({required int id}) {
    if (_cart.length <= 1 && _cart.isNotEmpty) {
      _cart[0].quantity++;
    } else {
      _cart[id].quantity++;
    }

    notifyListeners();
  }

  reduceQuantity({required int id}) {
    _cart[id].quantity--;
    notifyListeners();
  }

// digunakan untuk mendapatkan jumlah total item yang ada didalam cart (keranjang)
  totalItem() {
    int total = 0;
    for (var item in _cart) {
      total += int.parse(item.quantity.toString());
    }

    return total;
  }

// digunakan untuk mendapatkan jumlah total harga yang ada didalam cart (keranjang)
  totalPrice() {
    double total = 0;
    for (var item in _cart) {
      total += double.parse(item.quantity.toString()) *
          double.parse(item.product.price.toString());
    }
    return total;
  }

// Mengecek apakah product sudah ada didalam cart (keranjang) atau belum
  productExist(ProductModel product) {
    if (_cart.indexWhere((element) => element.product.id == product.id) == -1) {
      return false;
    } else {
      return true;
    }
  }
}
