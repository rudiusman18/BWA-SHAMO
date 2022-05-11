import 'dart:convert';
import 'package:bwa_shamo/models/category_model.dart';
import 'package:bwa_shamo/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  String baseUrl =
      'https://shamo-bwa.herokuapp.com/api'; //mengambil url dari API

  Future<List<ProductModel>> getProducts() async {
    var url = Uri.parse('$baseUrl/product');
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    print(response.body);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['product']['data'];
      List<ProductModel> product =
          data.map((item) => ProductModel.fromJson(item)).toList();
      return product; //Jika benar mengembalikan data dalam product
    } else {
      return <ProductModel>[]; //jika salah mengembalikan list kosong
    }
  }

  Future<List<CategoryModel>> getCategory() async {
    var url = Uri.parse('$baseUrl/category');
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    print(response.body);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<CategoryModel> category =
          data.map((item) => CategoryModel.fromJson(item)).toList();
      return category; //Jika benar mengembalikan data dalam category
    } else {
      return <CategoryModel>[]; //jika salah mengembalikan list kosong
    }
  }
}
