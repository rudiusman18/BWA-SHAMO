import 'dart:convert';
import 'package:bwa_shamo/models/cart_model.dart';
import 'package:bwa_shamo/models/transaction_model.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  String baseUrl =
      'https://shamo-bwa.herokuapp.com/api'; //mengambil url dari API

  Future<bool> checkout({
    required String token,
    required List<CartModel> carts,
    required double totalPrice,
  }) async {
    var url = Uri.parse('$baseUrl/checkout');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'address': 'Jalan Surabaya, Universitas Negeri Malang',
      'transactionitem': carts.map((cartItem) {
        return {
          'id': cartItem.product.id,
          'quantity': cartItem.quantity,
        };
      }).toList(),
      'status': 'pending',
      'total_price': totalPrice,
      'shipping_price': 0,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal melakukan transaksi');
    }
  }

  Future getTransactionItem({required String token}) async {
    var url = Uri.parse('$baseUrl/transaction');
    var headers = {
      'Content-Type': 'application/jsjon',
      'Authorization': token,
    };
    var response = await http.get(url, headers: headers);

    print(jsonDecode(response.body)['data']['transaction']['data']);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['transaction']['data'];
      List<TransactionModel> productItem =
          data.map((e) => TransactionModel.fromJson(e)).toList();
      return productItem;
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }
}
