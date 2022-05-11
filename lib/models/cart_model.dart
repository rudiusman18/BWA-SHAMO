import 'package:bwa_shamo/models/product_model.dart';

class CartModel {
  int id = 0;
  ProductModel product = ProductModel();
  int quantity = 0;

  CartModel({
    required this.id,
    required this.product,
    required this.quantity,
  });

  CartModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductModel.fromJson(json['product']);
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  double getTotalPrice() {
    double total = 0;
    total = double.parse(product.price.toString()) *
        double.parse(quantity.toString());
    return total;
  }
}
