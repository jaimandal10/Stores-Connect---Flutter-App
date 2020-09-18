import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_sell/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:home_sell/utilities/login/register_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_sell/utilities/authservice.dart';
import 'package:home_sell/utilities/account_update.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class EntryScreen extends StatefulWidget {
  static String uid;
  static const String id = 'entry_screen';
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String phoneNo;
  String smsCode;
  String verificationId;
  bool showSpinner = false;
  final _text1 = TextEditingController();
  bool _validate1 = false;
  bool codeSent = false;
  String errMsg = '';

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified =
        (AuthCredential authResult) async {
      try{
        AuthService().signIn(authResult);
      }catch(e){
        setState(() {
          showSpinner=false;
        });
        Fluttertoast.showToast(
            msg: 'Error. Please check your internet connection or try again later.',
            gravity: ToastGravity.TOP);
      }
    };
    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      setState(() {
        showSpinner = false;
      });
      Fluttertoast.showToast(
          msg: 'Error. Please check the phone number or try later.',
          gravity: ToastGravity.TOP);
      print('${authException.message}');
    };
    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        codeSent = true;
        showSpinner = false;
      });
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verified,
      verificationFailed: verificationfailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Colors.deepOrange[400],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40,horizontal: 20),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          height: 100,
                          child: Image.asset('images/Logo_Circle.jpg'),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          width: double.infinity,
                          child: Text(
                            'Login/SignUp',
                            style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 26,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
//                          Container(
////                            height: 300,
////                            width: 300,
//                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
//                            child: ListView(
////                  mainAxisAlignment: MainAxisAlignment.center,
////                  crossAxisAlignment: CrossAxisAlignment.center,
//                              children: <Widget>[
//                              ],
//                            ),
//                          ),
                        SizedBox(height: 20,),
                        _signInButton(),
                        SizedBox(height: 30),
                        Container(
                          height: 50,
                          child: Text(
                            '(OR)',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                                fontSize: 16, color: Colors.black54),
                          ),
                        ),
                        TextField(
                          //Input Phone Number
                          keyboardType: TextInputType.phone,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(color: Colors.black),
                          controller: _text1,
                          cursorColor: Colors.black,
                          textAlign: TextAlign.left,
                          onChanged: (value) {
                            phoneNo =
                                '+91 ' + value; //Adding the country code
                          },
                          decoration: kTxtFld.copyWith(
                            hintStyle: TextStyle(
                              color: Colors.black54,
                            ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black54,
                              ),
                            ),
                            hintText: 'Mobile Number (10-digit)',
                            errorText: _validate1 ? 'Can\'t be empty' : null,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        codeSent //Introducing the pin input field only if an otp is sent
                            ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                child: PinInputTextField(
                                  pinLength: 6,
                                  decoration: UnderlineDecoration(
                                    enteredColor: Colors.black,
                                    obscureStyle: ObscureStyle(
                                      isTextObscure: true,
                                    ),
                                    color: Colors.black,
                                  ),
                                  onChanged: (value) {
                                    smsCode = value;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
//                                      FlatButton(
//                                        color: Colors.red,
//                                        child: Text(
//                                          'Enter OTP',
//                                          style: GoogleFonts.lato(
//                                              color: Colors.white),
//                                        ),
//                                        onPressed: () {
//                                          setState(() {
//                                            showSpinner = true;
//                                          });
//                                          errMsg = AuthService().signInWithOTP(
//                                              smsCode, verificationId);
//                                          setState(() {
//                                            showSpinner = false;
//                                          });
//                                        },
//                                      ),
                              errMsg == 'Error. Try Again'
                                  ? Text(
                                errMsg,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12),
                              )
                                  : Container(),
                            ],
                          ),
                        )
                            : Container(),
                        Container(
                          width: double.infinity,
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(30),
                            child: MaterialButton(
                              splashColor: Colors.grey,
                              disabledColor: Colors.grey,
                              child: Text(
                                codeSent ? 'Enter OTP' : 'Login/SignUp',
                                style: GoogleFonts.lato(
                                    fontSize: 20, color: Colors.black),
                              ),
                              onPressed: codeSent
                                  ? () {
                                setState(() {
                                  showSpinner = true;
                                });
                                errMsg = AuthService().signInWithOTP(
                                    smsCode, verificationId);
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                                  : () {
                                FocusScopeNode currentFocus = FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                setState(() {
                                  if (_text1.text.isEmpty) {
                                    _validate1 = true;
                                  } else {
                                    showSpinner = true;
                                  }
                                });
                                verifyPhone(phoneNo);
                              },
                            ),
                          ),
                        ),
                      ],
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

Widget _signInButton() {
  return MaterialButton(
    splashColor: Colors.grey,
    padding: EdgeInsets.zero,
    color: Colors.white,
    onPressed: () {
      AuthService().signInWithGoogle();
    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
    child: Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 20, 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image(image: AssetImage("images/google_logo.png"), height: 30.0),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Sign in with Google',
              style: GoogleFonts.lato(fontSize: 20, color: Colors.black),
            ),
          )
        ],
      ),
    ),
  );
}
