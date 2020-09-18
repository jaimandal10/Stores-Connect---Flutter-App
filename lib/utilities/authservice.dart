import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_sell/screens/home_screen.dart';
import 'package:home_sell/screens/entry_screen.dart';
import 'account_update.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static String uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return EntryScreen();
        }
      },
    );
  }

  signOut(context) {
    try {
      googleSignIn.signOut();
    } catch (e) {
      print(e);
    } //Function to sign out
    FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  signIn(AuthCredential authCredential) async {
    //Function to login
    await FirebaseAuth.instance.signInWithCredential(authCredential);
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    uid = user.uid;
    var doc =
        Firestore.instance.collection('user_account_details').document(uid);
    await doc.get().then((docRef) {
      if (!docRef.exists) {
        doc.setData({
          'Line 1': '',
          'Line 2': '',
          'Landmark': '',
          'City': '',
          'State': '',
          'E-mail': user.email!=null?user.email:'',
          'FirstName': user.displayName!=null? user.displayName:'',
          'LastName': '',
          'PhoneNumber': user.phoneNumber!=null?user.phoneNumber:'',
        });
        userFirstName.value = user.displayName!=null? user.displayName:'';
        userEmail.value = user.email!=null?user.email:'';
        userPhoneNumber.value = user.phoneNumber!=null?user.phoneNumber:'';
      }
    });
  }

  signInWithOTP(smsCode, verId) {
    //Function to sign in with an OTP
    AuthCredential authCred = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    try{
      signIn(authCred);
    }catch(e){
      return 'Error. Try again.';
    }
    return 'Error. Try Again';
  }

  signInWithGoogle() async {
    //Function to sing in with google
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final AuthResult authResult = await signIn(credential);
    } catch (e) {
      print(e);
      return Fluttertoast.showToast(
          msg: 'Error. Please check your internet connection or try again later.',
          gravity: ToastGravity.TOP);
    }
//    final FirebaseUser user = authResult.user;
//    assert(!user.isAnonymous);
//    assert(await user.getIdToken() != null);
//    final FirebaseUser currentUser = await _auth.currentUser();
//    assert(user.uid == currentUser.uid);
  }
}
