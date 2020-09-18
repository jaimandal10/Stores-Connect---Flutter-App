import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountUpdate{
  String uid;

  //collection reference
  final CollectionReference userInfo = Firestore.instance.collection('user_account_details');


  Future updateUserData(String firstName, String lastName, String phoneNo, String email) async{
    FirebaseUser user= await FirebaseAuth.instance.currentUser();
    uid=user.uid;
    return await userInfo.document(uid).updateData({
      'FirstName': firstName,
      'LastName': lastName,
      'PhoneNumber': phoneNo,
      'E-mail': email,
    });
  }

  //get user collection
  Stream<QuerySnapshot> get users{
    return userInfo.snapshots();
  }
}