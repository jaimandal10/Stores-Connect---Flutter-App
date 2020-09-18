import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_sell/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_sell/screens/account_screen.dart';
import 'package:home_sell/utilities/account_update.dart';
import 'package:home_sell/utilities/authservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EditAccount extends StatefulWidget {
  static const String id = 'edit_account';

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  String firstName;
  String lastName;
  String phoneNo;
  String address;
  String email;
  String uid;
  bool showSpinner = false;

  final _firstNameController = TextEditingController(text: userFirstName.value);
  final _lastNameController = TextEditingController(text: userLastName.value);
  final _phoneNumberController = TextEditingController(text: userPhoneNumber.value);
  final _emailController = TextEditingController(text: userEmail.value);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstName = userFirstName.value;
    lastName = userLastName.value;
    email = userEmail.value;
    phoneNo = userPhoneNumber.value;
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
        centerTitle: true,
        title: Text(
          'Update Profile',
          style: GoogleFonts.lato(color: Colors.black),
        ),
        //backgroundColor: Colors.green,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.red[700],
        child: FlatButton(
          child: Container(
              child: Text(
            'Update',
            style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
          )),
          color: Colors.red[700],
          onPressed: () async {
            setState(() {
              showSpinner = true;
            });
            try{
              AccountUpdate()
                  .updateUserData(firstName, lastName, phoneNo, email)
                  .then((value) {
                userFirstName.value = firstName;
                userLastName.value = lastName;
                userEmail.value = email;
                userPhoneNumber.value = phoneNo;
                setState(() {
                  showSpinner = false;
                });
                Fluttertoast.showToast(msg: 'Updated',gravity: ToastGravity.CENTER);
              });
            }catch(e){
              setState(() {
                showSpinner = false;
              });
              Fluttertoast.showToast(msg: 'Error',gravity: ToastGravity.CENTER);
            }
          },
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: MediaQuery.of(context).size.width*.04),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/2.5,
                    child: ValueListenableBuilder(
                      valueListenable: userFirstName,
                      builder: (context, value, child) {
                        return TextField(
                          controller: _firstNameController,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          cursorColor: Colors.black,
                          textAlign: TextAlign.start,
                          onChanged: (value) {
                            firstName = value;
                          },
                          decoration: kTxtFld.copyWith(
                            hintText: '',
                            labelText: 'First Name',
                            labelStyle: GoogleFonts.lato(
                                color: Colors.grey, fontSize: 14, height: 0),
                            alignLabelWithHint: true,
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2.5,
                    child: ValueListenableBuilder(
                      valueListenable: userLastName,
                      builder: (context, value, child) {
                        return TextField(
                          controller: _lastNameController,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          cursorColor: Colors.black,
                          textAlign: TextAlign.start,
                          onChanged: (value) {
                            lastName = value;
                          },
                          decoration: kTxtFld.copyWith(
                            hintText: '',
                            labelText: 'Last Name',
                            labelStyle: GoogleFonts.lato(
                                color: Colors.grey, fontSize: 14, height: 0),
                            alignLabelWithHint: true,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                //width: double.infinity,
                child: ValueListenableBuilder(
                  valueListenable: userEmail,
                  builder: (context, value, child) {
                    return TextField(
                      controller: _emailController,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      cursorColor: Colors.black,
                      textAlign: TextAlign.start,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: kTxtFld.copyWith(
                        hintText: '',
                        labelText: 'Email Address',
                        labelStyle: GoogleFonts.lato(
                            color: Colors.grey, fontSize: 14, height: 0),
                        alignLabelWithHint: true,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: ValueListenableBuilder(
                  valueListenable: userPhoneNumber,
                  builder: (context, value, child) {
                    return TextField(
                      controller: _phoneNumberController,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      cursorColor: Colors.black,
                      textAlign: TextAlign.start,
                      onChanged: (value) {
                        phoneNo = value;
                      },
                      decoration: kTxtFld.copyWith(
                        hintText: '',
                        labelText: 'Mobile Number',
                        labelStyle: GoogleFonts.lato(
                            color: Colors.grey, fontSize: 14, height: 0),
                        alignLabelWithHint: true,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
