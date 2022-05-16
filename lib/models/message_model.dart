import 'package:bwa_shamo/models/product_model.dart';

class MessageModel {
  String? message;
  int? userId;
  String? userName;
  String? userImage;
  bool? isFromUser;
  ProductModel product = ProductModel();
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  MessageModel({
    this.message,
    this.userId,
    this.userName,
    this.userImage,
    this.isFromUser,
    required this.product,
    required this.createdAt,
    required this.updatedAt,
  });
  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['userId'];
    userName = json['userName'];
    userImage = json['userImage'];
    isFromUser = json['isFromUser'];
    product = ProductModel.fromJson(json['product']);
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'isFromUser': isFromUser,
      'product': product.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
