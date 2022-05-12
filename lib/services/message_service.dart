import 'package:bwa_shamo/models/product_model.dart';
import 'package:bwa_shamo/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addMessage({
    UserModel? user,
    bool? isFromUser,
    String? message,
    ProductModel? product,
  }) async {
    try {
      firestore.collection('messages').add({
        'userId': user!.id,
        'userName': user.name,
        'userImage': user.profilePhotoUrl,
        'isFromUser': isFromUser,
        'message': message,
        'product': product!.name!.isEmpty ? {} : product.toJson(),
        'createdAt': DateTime.now().toString(),
        'updatedAt': DateTime.now().toString,
      }).then((value) => print('Pesan berhasil dikirim!'));
    } catch (e) {
      throw Exception('Pesan gagal dikirim');
    }
  }
}
