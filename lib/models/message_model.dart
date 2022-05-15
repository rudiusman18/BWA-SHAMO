import 'package:bwa_shamo/models/product_model.dart';

class MessageModel {
  String? message;
  int? userId;
  String? userName;
  String? userImage;
  bool? isFromuser;
  ProductModel product = ProductModel();
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  MessageModel({
    this.message,
    this.userId,
    this.userName,
    this.userImage,
    this.isFromuser,
    // required this.product,
    required this.createdAt,
    required this.updatedAt,
  });
  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['userId'];
    userName = json['userName'];
    userImage = json['userImage'];
    isFromuser = json['isFromuser'];
    product = ProductModel.fromJson(json['product']);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'isFromuser': isFromuser,
      'product': product.toJson(),
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
  }
}
