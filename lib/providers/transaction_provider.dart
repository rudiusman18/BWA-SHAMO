import 'package:bwa_shamo/models/cart_model.dart';
import 'package:bwa_shamo/models/transaction_model.dart';
import 'package:bwa_shamo/services/transaction_service.dart';
import 'package:flutter/foundation.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _productItem = [];

  List<TransactionModel> get productItem => _productItem;

  set product(List<TransactionModel> productItem) {
    _productItem = productItem;
    notifyListeners();
  }

  Future<bool> transaction({
    required String token,
    required List<CartModel> carts,
    required double totalPrice,
  }) async {
    try {
      if (await TransactionService()
          .checkout(token: token, carts: carts, totalPrice: totalPrice)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getTransactionItem({required String token}) async {
    print(token);
    try {
      List<TransactionModel> productItem =
          await TransactionService().getTransactionItem(token: token);
      _productItem = productItem;

      return true;
    } catch (e) {
      print(e);

      return false;
    }
  }
}
