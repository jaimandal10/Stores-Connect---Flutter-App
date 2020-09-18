import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_sell/screens/home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../constants.dart';

class EditAddressScreen extends StatefulWidget {
  static const String id = 'edit_address_screen';
  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  bool showSpinner = false;
  var _fireStore = Firestore.instance;
  //Address variables
  String line1='';
  String line2='';
  String city='';
  String state='';
  String landmark='';
  String zip='';
  //TextEditingControllers
  final _line1Controller = TextEditingController(text: userLine1.value);
  final _line2Controller = TextEditingController(text: userLine2.value);
  final _landmarkController = TextEditingController(text: userLandmark.value);
  final _cityController = TextEditingController(text: userCity.value);
  final _stateController = TextEditingController(text: userState.value);
  final _zipController = TextEditingController(text: userZip.value);
  bool _lin1Validate = false;
  bool _cityValidate = false;
  bool _stateValidate = false;
  bool _zipValidate = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      line1 = userLine1.value;
      line2 = userLine2.value;
      landmark = userLandmark.value;
      city = userCity.value;
      state = userState.value;
      zip = userZip.value;
    });
  }

  updateAddress () async {
    await _fireStore
        .collection('user_account_details')
        .document(userUid)
        .updateData({
      'Line 1': line1,
      'Line 2': line2,
      'Landmark': landmark,
      'City': city,
      'State': state,
      'ZipCode': zip,
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _line1Controller.dispose();
    _line2Controller.dispose();
    _landmarkController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: Text(
            'Update Address',
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
              });
              if (!(_lin1Validate || _cityValidate || _stateValidate || _zipValidate)) {
                setState(() {
                  showSpinner = true;
                });
                try{
                  updateAddress().then((value) {
                    setState(() {
                      userLine1.value = line1;
                      userLine2.value = line2;
                      userLandmark.value = landmark;
                      userCity.value = city;
                      userState.value = state;
                      userAddress.value = userLine1.value +
                          ", " +
                          userLine2.value +
                          ", " +
                          userCity.value +
                          ", " +
                          userState.value + "-" + userZip.value;
                      showSpinner=false;
                    });
                  });
                  Fluttertoast.showToast(msg: 'Updated',gravity: ToastGravity.CENTER);
                }catch(e){
                  setState(() {
                    showSpinner = false;
                  });
                  Fluttertoast.showToast(msg: 'Error',gravity: ToastGravity.CENTER);
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
                    controller: _landmarkController,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      landmark = value;
                    },
                    decoration: kTxtFld.copyWith(
                      hintText: '',
                      labelText: 'Landmark',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
