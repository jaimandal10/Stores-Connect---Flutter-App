import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_sell/screens/confrim_address_screen.dart';
import 'package:home_sell/screens/home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../constants.dart';

class AddDeliveryAddressScreen extends StatefulWidget {
  static const String id = 'add_delivery_address_screen';
  @override
  _AddDeliveryAddressScreenState createState() =>
      _AddDeliveryAddressScreenState();
}

class _AddDeliveryAddressScreenState extends State<AddDeliveryAddressScreen> {
  bool showSpinner = false;
  var _fireStore = Firestore.instance;
  //Address Variables
  String line1='';
  String line2='';
  String city='';
  String state='';
  String landmark='';
  String zip='';
  //TextEditingControllers
  final _line1Controller = TextEditingController();
  final _line2Controller = TextEditingController();
  final _landmarkController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();
  bool _line1Validate = false;
  bool _cityValidate = false;
  bool _stateValidate = false;
  bool _zipValidate = false;
  int numAddresses;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      numAddresses=numberOfAddresses+1;
    });
  }

  addAddress() async {
    await _fireStore
        .collection('user_account_details')
        .document(userUid)
        .collection('Delivery Addresses')
        .document('Address '+DateTime.now().toString()).setData({
      'Line 1': line1,
      'Line 2': line2,
      'Landmark': landmark,
      'City': city,
      'State': state,
      'Zip': zip,
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
                'Add Address',
                style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
              ),
            ),
            color: Colors.red[700],
            onPressed: () async {
              setState(() {
                _line1Validate=_line1Controller.text.isEmpty;
                _cityValidate=_cityController.text.isEmpty;
                _stateValidate=_stateController.text.isEmpty;
                _zipValidate=(_zipController.text.length!=6 || _zipController.text.isEmpty);
              });
              if(!(_line1Validate || _stateValidate|| _cityValidate || _zipValidate)){
                setState(() {
                  showSpinner = true;
                });
                try{
                  addAddress().then((value){
                    setState(() {
                      showSpinner=false;
                    });
                    Fluttertoast.showToast(msg: 'Address Added',gravity: ToastGravity.CENTER);
                  });
                }catch(e){
                  setState(() {
                    showSpinner=false;
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
                      errorText: _line1Validate ? 'Can\'t be empty' : null,
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
                    keyboardType: TextInputType.number,
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
                      labelText: 'Zip Code',
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
