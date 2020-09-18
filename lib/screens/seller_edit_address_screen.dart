import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';
import 'home_screen.dart';

class SellerEditAddressScreen extends StatefulWidget {
  static const String id = 'seller_edit_address_screen';
  @override
  _SellerEditAddressScreenState createState() =>
      _SellerEditAddressScreenState();
}

class _SellerEditAddressScreenState extends State<SellerEditAddressScreen> {
  bool showSpinner = false;
  var _fireStore = Firestore.instance;
  //Address variables
  String line1 = '';
  String line2 = '';
  String city = '';
  String state = '';
  String zip = '';
  String storeDesc = '';
  String storeName = '';
  String ownerName='';
  String ownerEmail='';
  String ownerPhoneNumber = '';

  //TextEditingControllers
  final _line1Controller = TextEditingController(text: storeAddressLine1.value);
  final _storeDescController = TextEditingController(text: storeDescription.value);
  final _line2Controller = TextEditingController(text: storeAddressLine2.value);
  final _cityController = TextEditingController(text: storeAddressCity.value);
  final _stateController = TextEditingController(text: storeAddressState.value);
  final _zipController  =TextEditingController(text: storeAddressZip.value);
  final _storeNameController = TextEditingController(text: storeAddressName.value);
  final _ownerNameController = TextEditingController(text: storeOwnerName.value);
  final _ownerEmailController = TextEditingController(text: storeOwnerEmail.value);
  final _ownerPhoneNumberController = TextEditingController(text: storeOwnerPhoneNumber.value);

  bool _lin1Validate = false;
  bool _cityValidate = false;
  bool _stateValidate = false;
  bool _zipValidate = false;
  bool _storeNameValidate = false;
  bool _ownerNameValidate =false;
  bool _ownerEmailValidate = false;
  bool _ownerPhoneNumberValidate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      line1 = storeAddressLine1.value;
      line2 = storeAddressLine2.value;
      city = storeAddressCity.value;
      state = storeAddressState.value;
      storeDesc = storeDescription.value;
      zip =storeAddressZip.value;
      storeName = storeAddressName.value;
      ownerName=storeOwnerName.value;
      ownerEmail=storeOwnerEmail.value;
      ownerPhoneNumber=storeOwnerPhoneNumber.value;
    });
  }

  updateAddressInList() async {
    await _fireStore.collection('seller_list').document(userUid).updateData({
      'Line 1': line1,
      'Line 2': line2,
      'ZipCode': zip,
      'City': city,
      'State': state,
      'Store Name': storeName,
      'OwnerEmail': ownerEmail,
      'OwnerPhoneNumber': ownerPhoneNumber,
      'OwnerName': ownerName,
      'StoreDesc': storeDesc,
    });
  }

  updateAddress() async {
    await _fireStore
        .collection('sellers')
        .document(storeCity.value)
        .collection('seller_info')
        .document(userUid)
        .updateData({
      'AddressLine1': line1,
      'AddressLine2': line2,
      'ZipCode': zip,
      'City': city,
      'State': state,
      'Store Name': storeName,
      'OwnerEmail': ownerEmail,
      'OwnerPhoneNumber': ownerPhoneNumber,
      'OwnerName': ownerName,
      'StoreDesc': storeDesc,
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _line1Controller.dispose();
    _line2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _storeNameController.dispose();
    _ownerEmailController.dispose();
    _ownerNameController.dispose();
    _ownerPhoneNumberController.dispose();
    _storeDescController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
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
          centerTitle: true,
          title: Text(
            'Seller Account',
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.lato(color: Colors.black),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.red[700],
          child: FlatButton(
            child: Container(
              child: Text(
                'Update',
                style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
              ),
            ),
            color: Colors.red[700],
            onPressed: () async {
              setState(() {
                _lin1Validate = _line1Controller.text.isEmpty;
                _cityValidate = _cityController.text.isEmpty;
                _stateValidate = _stateController.text.isEmpty;
                _zipValidate = _zipController.text.isEmpty || (_zipController.text.length!=6);
                _storeNameValidate = _storeNameController.text.isEmpty;
                _ownerEmailValidate = _ownerEmailController.text.isEmpty;
                _ownerPhoneNumberValidate=_ownerPhoneNumberController.text.isEmpty;
                _ownerNameValidate=_ownerNameController.text.isEmpty;
              });
              if (!(_lin1Validate || _cityValidate || _stateValidate || _zipValidate || _storeNameValidate || _ownerNameValidate || _ownerPhoneNumberValidate || _ownerEmailValidate)) {
                setState(() {
                  showSpinner = true;
                });
                try {
                  updateAddressInList().then((value) {
                    setState(() {
                      storeAddressLine1.value = line1;
                      storeAddressLine2.value = line2;
                      storeAddressZip.value = zip;
                      storeAddressCity.value = city;
                      storeAddressState.value = state;
                      storeOwnerPhoneNumber.value=ownerPhoneNumber;
                      storeOwnerEmail.value=ownerEmail;
                      storeOwnerName.value=ownerName;
                      storeDescription.value=storeDesc;
                      Fluttertoast.showToast(
                          msg: 'Updated', gravity: ToastGravity.CENTER);
                      showSpinner=false;
                    });
                  });
                  updateAddress();
                } catch (e) {
                  setState(() {
                    showSpinner = false;
                  });
                  Fluttertoast.showToast(
                      msg: 'Error', gravity: ToastGravity.CENTER);
                }
              }
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 25,
                horizontal: MediaQuery.of(context).size.width * .04),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 5,),
                Container(
                  child: TextField(
                    controller: _storeNameController,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      storeName = value;
                    },
                    decoration: kTxtFld.copyWith(
                      hintText: '',
                      errorText: _storeNameValidate ? 'Can\'t be empty' : null,
                      labelText: 'Store Name',
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
                  child: TextField(
                    controller: _storeDescController,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      storeDesc = value;
                    },
                    decoration: kTxtFld.copyWith(
                      hintText: '',
                      labelText: 'Store Description',
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
                  child: TextField(
                    controller: _line1Controller,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      line1 = value;
                    },
                    decoration: kTxtFld.copyWith(
                      hintText: '',
                      errorText: _lin1Validate ? 'Can\'t be empty' : null,
                      labelText: 'Address Line 1',
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
                  child: TextField(
                    controller: _line2Controller,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      line2 = value;
                    },
                    decoration: kTxtFld.copyWith(
                      hintText: '',
                      labelText: 'Address Line 2',
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
                  child: TextField(
                    controller: _cityController,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      city = value;
                    },
                    decoration: kTxtFld.copyWith(
                      hintText: '',
                      errorText: _cityValidate ? 'Can\'t be empty' : null,
                      labelText: 'City',
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
                  child: TextField(
                    controller: _stateController,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      state = value;
                    },
                    decoration: kTxtFld.copyWith(
                      hintText: '',
                      errorText: _stateValidate ? 'Can\'t be empty' : null,
                      labelText: 'State',
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
                  child: TextField(
                    controller: _zipController,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      zip = value;
                    },
                    decoration: kTxtFld.copyWith(
                      hintText: '',
                      errorText: _zipValidate ? _zipController.text.isEmpty ? 'Can\'t be empty' :'Please enter 6 digits':null,
                      labelText: 'Zip',
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
                  child: TextField(
                    controller: _ownerNameController,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      ownerName = value;
                    },
                    decoration: kTxtFld.copyWith(
                      hintText: '',
                      errorText: _ownerNameValidate ? 'Can\'t be empty' :null,
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
                  child: TextField(
                    controller: _ownerEmailController,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      ownerEmail = value;
                    },
                    decoration: kTxtFld.copyWith(
                      hintText: '',
                      errorText: _ownerEmailValidate ? 'Can\'t be empty' :null,
                      labelText: 'Owner Email',
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
                  child: TextField(
                    controller: _ownerPhoneNumberController,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      ownerPhoneNumber = value;
                    },
                    decoration: kTxtFld.copyWith(
                      hintText: '',
                      errorText: _ownerPhoneNumberValidate ? 'Can\'t be empty':null,
                      labelText: 'Store Phone Number',
                      labelStyle: GoogleFonts.lato(
                          color: Colors.grey, fontSize: 14, height: 0),
                      alignLabelWithHint: true,
                    ),
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
