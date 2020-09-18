import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_sell/screens/home_screen.dart';
import 'package:home_sell/screens/seller_entry_screen_2.dart';
import 'package:home_sell/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class SellerEntryScreen extends StatefulWidget {

  SellerEntryScreen({this.isStore});

  final bool isStore;

  static const String id = 'seller_login_screen';

  @override
  _SellerEntryScreenState createState() => _SellerEntryScreenState();
}

class _SellerEntryScreenState extends State<SellerEntryScreen> {
  String storeName; //Address variables
  String addressLine1;
  String addressLine2;
  String city;
  String state;
  String zipCode;
  bool store;

  TextEditingController _line1Controller; //Respective text editing controllers
  TextEditingController _stateController;
  TextEditingController _cityController;
  TextEditingController _zipController;
  TextEditingController _nameController;

  bool _line1Validate = false; //Respective validating booleans
  bool _stateValidate = false;
  bool _cityValidate = false;
  bool _zipValidate = false;
  bool _nameValidate = false;
  bool _storeValidate = false;

  @override
  void initState() {
    super.initState();
    _line1Controller = new TextEditingController();
    _stateController = new TextEditingController();
    _cityController = new TextEditingController();
    _zipController = new TextEditingController();
    _nameController = new TextEditingController();
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
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  widget.isStore?'Enter the address of your store':'Enter the address of your household business',
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _nameController,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        cursorColor: Colors.black,
                        textAlign: TextAlign.start,
                        onChanged: (value) {
                          storeName = value;
                        },
                        decoration: kTxtFld.copyWith(
                          errorText: _nameValidate ? 'Can\'t be empty' : null,
                          hintText: '',
                          labelText: widget.isStore?'Store Name':'Online Store Name',
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
                        controller: _line1Controller,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        cursorColor: Colors.black,
                        textAlign: TextAlign.start,
                        onChanged: (value) {
                          addressLine1 = value;
                        },
                        decoration: kTxtFld.copyWith(
                          errorText:
                              _line1Validate ? 'Can\'t be empty' : null,
                          hintText: '',
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
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        cursorColor: Colors.black,
                        textAlign: TextAlign.start,
                        onChanged: (value) {
                          addressLine2 = value;
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
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _cityController,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        cursorColor: Colors.black,
                        textAlign: TextAlign.start,
                        onChanged: (value) {
                          city = value;
                        },
                        decoration: kTxtFld.copyWith(
                          errorText:
                          _stateValidate ? 'Can\'t be empty' : null,
                          hintText: '',
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
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _stateController,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        cursorColor: Colors.black,
                        textAlign: TextAlign.start,
                        onChanged: (value) {
                          state = value;
                        },
                        decoration: kTxtFld.copyWith(
                          errorText:
                          _stateValidate ? 'Can\'t be empty' : null,
                          hintText: '',
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
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _zipController,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        cursorColor: Colors.black,
                        textAlign: TextAlign.start,
                        onChanged: (value) {
                          zipCode = value;
                        },
                        decoration: kTxtFld.copyWith(
                          errorText: _zipValidate ? _zipController.text.isEmpty ? 'Can\'t be empty' :'Please enter 6 digits':null,
                          hintText: '',
                          labelText: 'Zip Code',
                          labelStyle: GoogleFonts.lato(
                              color: Colors.grey, fontSize: 14, height: 0),
                          alignLabelWithHint: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                elevation: 10,
                onPressed: () async {
                  setState(() {
                    _line1Validate = _line1Controller.text.isEmpty;
                    _stateValidate = _stateController.text.isEmpty;
                    _cityValidate = _cityController.text.isEmpty;
                    _zipValidate = _zipController.text.isEmpty || (_zipController.text.length!=6);
                    _nameValidate = _nameController.text.isEmpty;
                  });
                  if (!_line1Validate &&
                      !_zipValidate &&
                      !_stateValidate &&
                      !_cityValidate &&
                      !_nameValidate) {
                    List<Placemark> sellerPlacemark = await Geolocator()
                        .placemarkFromAddress(addressLine1 +
                        " " +
                        addressLine2 +
                        " " +
                        city +
                        " " +
                        state +
                        " " +
                        zipCode);
                    Firestore
                        .instance //Storing the address under the city's folder
                        .collection('sellers')
                        .document(sellerPlacemark[0].locality)
                        .collection('seller_info')
                        .document(userUid)
                        .setData({
                      'Store Name': storeName,
                      'AddressLine1': addressLine1,
                      'AddressLine2': addressLine2,
                      'State': state,
                      'City': city,
                      'ZipCode': zipCode,
                      'Position': GeoPoint(
                          sellerPlacemark[0].position.latitude,
                          sellerPlacemark[0].position.longitude),
                      'IsApproved': null,
                      'IsStore': widget.isStore,
                    });
                    Firestore
                        .instance //Storing the location under the general seller's list
                        .collection('seller_list')
                        .document(userUid)
                        .setData({
                      'Store Name': storeName,
                      'AddressLine1': addressLine1,
                      'AddressLine2': addressLine2,
                      'State': state,
                      'City': city,
                      'ZipCode': zipCode,
                      'Position': GeoPoint(
                          sellerPlacemark[0].position.latitude,
                          sellerPlacemark[0].position.longitude),
                      'IsApproved': null,
                      'IsStore': widget.isStore,
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SellerEntryScreen2(
                              cityStore: sellerPlacemark[0].locality,
                              isStore: widget.isStore,
                            )));
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
    );
  }
}
