import 'package:bwa_shamo/models/message_model.dart';
import 'package:bwa_shamo/models/product_model.dart';
import 'package:bwa_shamo/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  FirebaseFirestore firestore = FirebaseFirestore
      .instance; //Digunakan untuk menghubungkan Flutter dengan firestore
  Stream<List<MessageModel>> getMessageById({int? userId}) {
    try {
      // fierstore.collection digunakan untuk menangkap data pada coillection dengan nama 'messages' dengan kondisi dimana field userId sama dengan parameter userId untuk kemudian diambil data snapshot nya lalu diubah menjadi map dengan parameter QuerySnapshot list lalu dimasukkan kedalam variabel result

      return firestore
          .collection('messages')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((QuerySnapshot list) {
        var result = list.docs.map<MessageModel>((DocumentSnapshot message) {
          return MessageModel.fromJson(message.data()!);
        }).toList();
        // NOTE: Mengurutkan berdasarkan data paling lama
        result.sort(
          (MessageModel a, MessageModel b) =>
              a.createdAt.compareTo(b.createdAt),
        );
        print('Ada data dibawah ini');
        return result;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addMessage({
    required UserModel user,
    required bool isFromUser,
    required String message,
    required ProductModel product,
  }) async {
    try {
      firestore.collection('messages').add({
        'userId': user.id,
        'userName': user.name,
        'userImage': user.profilePhotoUrl,
        'isFromUser': isFromUser,
        'message': message,
        'product': product.name == null ? {} : product.toJson(),
        'createdAt': DateTime.now().toString(),
        'updatedAt': DateTime.now().toString(),
      }).then((value) => print('Pesan berhasil dikirim!'));
    } catch (e) {
      throw Exception(e);
    }
  }
}
