import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_sell/screens/seller_approval_pending_screen.dart';

import '../constants.dart';
import 'home_screen.dart';

class SellerEntryDescription extends StatefulWidget {

  SellerEntryDescription({this.isStore, this.cityStore});

  final bool isStore;
  final String cityStore;

  @override
  _SellerEntryDescriptionState createState() => _SellerEntryDescriptionState();
}

class _SellerEntryDescriptionState extends State<SellerEntryDescription> {

  String storeDesc;
  TextEditingController _descController = TextEditingController();
  bool descValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Final Step!!!',
                  style: GoogleFonts.lato(
                      fontSize: 24,
                      color: Colors.deepOrange[400],
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Enter a one line description of your store to be displayed to your potential buyers',
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _descController,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      storeDesc = value;
                    },
                    decoration: kTxtFld.copyWith(
                      errorText: null,
                      hintText: '',
                      labelText: 'Description',
                      labelStyle: GoogleFonts.lato(
                          color: Colors.grey, fontSize: 14, height: 0),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: (){
                    print(storeDesc);
                    Firestore
                        .instance //Storing the address under the city's folder
                        .collection('sellers')
                        .document(widget.cityStore)
                        .collection('seller_info')
                        .document(userUid)
                        .updateData({
                      'StoreDesc': storeDesc,
                    });
                    Firestore
                        .instance //Storing the location under the general seller's list
                        .collection('seller_list')
                        .document(userUid)
                        .updateData({
                      'StoreDesc': storeDesc,
                    });
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        SellerApprovalPendingScreen.id,
                            (route) => route.isFirst);
                  },
                  color: Colors.deepOrange[400],
                  child: Text(
                    'Register',
                    style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
