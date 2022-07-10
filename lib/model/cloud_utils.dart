import 'package:cloud_firestore/cloud_firestore.dart';
import 'models.dart';

final cloud = FirebaseFirestore.instance;
final users = cloud.collection('clients');

class UsersDB{


  static Future<void> addUser(Users u) async {
    return users.doc(u.uid).set(u.toMap());
  }

  static Future<QuerySnapshot> validUser(String phone){
    return users.where("phone",isEqualTo: phone).get();
  }

  static Map<String, dynamic>getUser(String uid){
    return users.where("uid",isEqualTo: uid).get() as Map<String, dynamic>;
  }

  static Future<void> updatePassword(Users u) async {
    DocumentReference user = users.doc(u.uid);
    return user.update({'pwd':u.pwd});
  }
}