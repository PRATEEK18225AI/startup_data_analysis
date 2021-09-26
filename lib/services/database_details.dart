import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startup_funding_prediction/utilities/object_converter.dart';

class UserDetails {
  CollectionReference _users = FirebaseFirestore.instance.collection("Users");

  Stream<QuerySnapshot> get userStream => _users.snapshots();

  //check
  Future<bool> isNewUser(uid) async {
    var result = await _users.doc(uid).get();
    return result.exists == false;
  }

  //get
  Future<Map<String, dynamic>> getUserDataFromUid(String uid) async {
    var result = await _users.doc(uid).get();
    return ObjectToContainer.toJson(result.data());
  }

  //add
  Future<void> addUserDetails(String uid, Map<String, dynamic> data) async {
    await _users.doc(uid).set(data);
  }

  //update
  Future<void> updateUserDetails(uid, data) async {
    await _users.doc(uid).update(data);
  }
}
