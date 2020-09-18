import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_sell/screens/seller_approval_pending_screen.dart';
import 'package:home_sell/screens/seller_entry_description_screen.dart';

import '../constants.dart';
import 'home_screen.dart';

class SellerEntryScreen2 extends StatefulWidget {
  SellerEntryScreen2({this.cityStore, this.isStore});

  final String cityStore;
  final bool isStore;

  @override
  _SellerEntryScreen2State createState() => _SellerEntryScreen2State();
}

class _SellerEntryScreen2State extends State<SellerEntryScreen2> {
  String storeOwnerName;
  String storeOwnerPhoneNumber;
  String storeOwnerEmailId;

  TextEditingController _nameController;
  TextEditingController _phoneNumberController;
  TextEditingController _emailController;

  bool _nameValidate = false;
  bool _phoneNumberValidate = false;
  bool _emailValidate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = new TextEditingController();
    _phoneNumberController = new TextEditingController();
    _emailController = new TextEditingController();
  }

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
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    'Enter your details',
                    style: GoogleFonts.lato(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _nameController,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      storeOwnerName = value;
                    },
                    decoration: kTxtFld.copyWith(
                      errorText: _nameValidate ? 'Can\'t be empty' : null,
                      hintText: '',
                      labelText: 'Owner Name',
                      labelStyle: GoogleFonts.lato(
                          color: Colors.grey, fontSize: 14, height: 0),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _emailController,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      storeOwnerEmailId = value;
                    },
                    decoration: kTxtFld.copyWith(
                      errorText: _emailValidate ? 'Can\'t be empty' : null,
                      hintText: '',
                      labelText: 'Owner E-mail',
                      labelStyle: GoogleFonts.lato(
                          color: Colors.grey, fontSize: 14, height: 0),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _phoneNumberController,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      storeOwnerPhoneNumber = value;
                    },
                    decoration: kTxtFld.copyWith(
                      errorText: _phoneNumberValidate ? 'Can\'t be empty' : null,
                      hintText: '',
                      labelText: 'Owner Phone Number',
                      labelStyle: GoogleFonts.lato(
                          color: Colors.grey, fontSize: 14, height: 0),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                RaisedButton(
                  elevation: 10,
                  onPressed: () async {
                    setState(() {
                      _nameValidate = _nameController.text.isEmpty;
                      _phoneNumberValidate =
                          _phoneNumberController.text.isEmpty;
                      _emailValidate = _emailController.text.isEmpty;
                    });
                    if (!_nameValidate &&
                        !_phoneNumberValidate &&
                        !_emailValidate) {
                      Firestore
                          .instance //Storing the address under the city's folder
                          .collection('sellers')
                          .document(widget.cityStore)
                          .collection('seller_info')
                          .document(userUid)
                          .updateData({
                        'OwnerName': storeOwnerName,
                        'OwnerPhoneNumber': storeOwnerPhoneNumber,
                        'OwnerEmail': storeOwnerEmailId,
                        'IsApproved': false,
                        'IsOpen': true,
                      });
                      Firestore
                          .instance //Storing the location under the general seller's list
                          .collection('seller_list')
                          .document(userUid)
                          .updateData({
                        'OwnerName': storeOwnerName,
                        'OwnerPhoneNumber': storeOwnerPhoneNumber,
                        'OwnerEmail': storeOwnerEmailId,
                        'IsApproved': false,
                        'IsOpen': true,
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return SellerEntryDescription(
                          cityStore: widget.cityStore,
                          isStore: widget.isStore,
                        );
                      }));
                    }
                  },
                  child: Text(
                    'Next',
                    style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  color: Colors.deepOrange[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
