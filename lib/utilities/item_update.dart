import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_sell/screens/home_screen.dart';

class ItemUpdate {
  ItemUpdate({this.itemName,this.city});
  String city;
  String uid;
  String itemName;

  Future updateItem(String price, String metric) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    uid = user.uid;
    return await Firestore.instance
        .collection('sellers')
        .document(city)
        .collection('seller_info')
        .document(uid)
        .collection('item_details')
        .document(itemName)
        .setData({
      'Price': price,
      'Metric': metric,
      'Available': true,
      'OfferPrice': '',
    });
  }
}
