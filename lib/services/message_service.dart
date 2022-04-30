part of 'services.dart';

class MessageService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<MessageModel>> getMessagesByUserId({int? userId}) {
    try {
      return firestore
          .collection('messages')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((QuerySnapshot list) {
        var result = list.docs.map<MessageModel>((DocumentSnapshot message) {
          debugPrint('${message.data()}');
          return MessageModel.fromJson(message.data() as Map<String, dynamic>);
        }).toList();
        result.sort((MessageModel a, MessageModel b) =>
            a.createdAt!.compareTo(b.createdAt!));
        return result;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addMessage(
      {UserModel? user,
      bool? isFromUser,
      String? message,
      ProductModel? product}) async {
    try {
      firestore.collection('messages').add({
        'userId': user!.id,
        'userName': user.name,
        'userImage': user.profilePictureUrl,
        'isFromUser': isFromUser,
        'message': message,
        'product':
            product is UninitializedProductModel ? {} : product!.toJson(),
        'createdAt': DateTime.now().toString(),
        'updatedAt': DateTime.now().toString(),
      }).then((value) => debugPrint('Pesan Berhasil Dikirim!'));
    } catch (e) {
      throw Exception('Pesan Gagal Dikirim!');
    }
  }
}
