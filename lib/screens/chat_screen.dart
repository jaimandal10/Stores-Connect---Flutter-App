import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_sell/screens/checkout.dart';
import 'package:home_sell/screens/confrim_address_screen.dart';
import 'package:home_sell/screens/home_screen.dart';
import 'package:home_sell/utilities/account_update.dart';
import 'package:home_sell/utilities/std_app_bar.dart';

import '../constants.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({this.sellerUid, this.isSeller, this.buyerUid, this.storeName, this.imgUrl,this.buyerName});

  final String sellerUid;
  final String storeName;
  final String imgUrl;
  final bool isSeller;
  final String buyerUid;
  final String buyerName;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var _fireStore = Firestore.instance;
  final msgController = TextEditingController();
  final amountController = TextEditingController();
  bool amountValidate = false;
  String txtMsg;
  String amount;
  String buyerName;

  checkDetails(context) {

    final _nameController = TextEditingController(text: userFirstName.value);
    final _phoneNumberController = TextEditingController(text: userPhoneNumber.value);

    bool _phoneNumberValidate = false;
    bool _nameValidate = false;


    String phoneNumber = userPhoneNumber.value;
    String firstName = userFirstName.value;

    if (userPhoneNumber.value == '' || userFirstName.value == '') {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Enter Details',
              style: GoogleFonts.lato(color: Colors.black),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  ValueListenableBuilder(
                    valueListenable: userFirstName,
                    builder: (context, value, child) {
                      return TextField(
                        controller: _nameController,
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
                          errorText: _nameValidate ? 'Can\'t be empty':null,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ValueListenableBuilder(
                    valueListenable: userFirstName,
                    builder: (context, value, child) {
                      return TextField(
                        controller: _phoneNumberController,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        cursorColor: Colors.black,
                        textAlign: TextAlign.start,
                        onChanged: (value) {
                          phoneNumber = value;
                        },
                        decoration: kTxtFld.copyWith(
                          hintText: '',
                          labelText: 'Phone Number',
                          labelStyle: GoogleFonts.lato(
                              color: Colors.grey, fontSize: 14, height: 0),
                          alignLabelWithHint: true,
                          errorText: _phoneNumberValidate ? 'Can\'t be empty': null,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: RaisedButton(
                  color: Colors.red[700],
                  child: Text(
                    'Done',
                    style: GoogleFonts.lato(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () {
                    setState(() {
                      _phoneNumberValidate = _phoneNumberController.text.isEmpty;
                      _nameValidate = _nameController.text.isEmpty;
                    });
                    if(!(_phoneNumberValidate || _nameValidate)){
                      userPhoneNumber.value = phoneNumber;
                      userFirstName.value = firstName;
                      AccountUpdate().updateUserData(firstName, userLastName.value,
                          phoneNumber, userEmail.value);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          );
        },
      );
    } else {
      return;
    }
  }


  sendPaymentRequest(String amount){
    _fireStore
        .collection('user_account_details')
        .document(widget.buyerUid)
        .collection('chats')
        .document(userUid)
        .collection('messages')
        .document(DateTime.now().toString())
        .setData({
      'amount': amount,
      'paid': false,
      'cod': false,
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buyerName = widget.isSeller?widget.buyerName:userFirstName.value==''?'Anonymous':userFirstName.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
        title: Icon(
          Icons.chat_bubble_outline,
          color: Colors.black,
          size: 32,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _fireStore
                  .collection('user_account_details')
                  .document(widget.isSeller?widget.buyerUid:userUid)
                  .collection('chats')
                  .document(widget.isSeller?userUid:widget.sellerUid)
                  .collection('messages')
                  .orderBy(FieldPath.documentId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black54,
                    ),
                  );
                }

                final messages = snapshot.data.documents.reversed;
                List<Widget> msgWidgets = [];
                for (var msg in messages) {
                  if(msg.data['amount']==null){
                    final msgTxt = msg.data['message'];
                    final senderDetail = msg.data['sender'];

                    final msgWidget = msgBubble(
                      msg: msgTxt,
                      isMe: widget.isSeller? senderDetail == 'seller': senderDetail=='user',
                    );
                    msgWidgets.add(msgWidget);
                  }else{
                    final paymentWidget = paymentBubble(
                      amount: msg.data['amount'],
                      paid: msg.data['paid'],
                      isSeller: widget.isSeller,
                      storeName: widget.isSeller? '':widget.storeName,
                      sellerUid: widget.isSeller? '':widget.sellerUid,
                      imgUrl: widget.isSeller?'':widget.imgUrl,
                      paymentId: msg.documentID,
                    );
                    msgWidgets.add(paymentWidget);
                  }
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    children: msgWidgets,
                  ),
                );
              },
            ),
            widget.isSeller?Container(
              padding: EdgeInsets.only(top: 5, bottom: 5, right: 20, left: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.deepOrange[400],
                  width: 1.5
                ),
                color: Colors.grey[300],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Card(
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      child: TextField(
                        onChanged: (value){
                          amount = value;
                        },
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly,
                        ],
                        style: TextStyle(color: Colors.black87, fontSize: 18),
                        controller: amountController,
                        cursorColor: Colors.black,
                        textAlign: TextAlign.left,
                        decoration: kTxtFld.copyWith(
                          contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          hintText: 'Enter Amount',
                          hintStyle: GoogleFonts.lato(color: Colors.black38),
                          errorText: amountValidate ? 'Can\'t be empty' : null,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    elevation: 10,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    child: Text(
                      'Request',
                      style: GoogleFonts.lato(color: Colors.deepOrange[300], fontSize: 18),
                    ),
                    color: Colors.white,
                    onPressed: (){
                      amountController.clear();
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text(
                              'Request Payment',
                              style: GoogleFonts.lato(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                    'Please click proceed if you\'d like to request the entered amount.',
                                    style: GoogleFonts.lato(color: Colors.grey, fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(50)),
                                    ),
                                    color: Colors.deepOrange[400],
                                    child: Text(
                                      'Proceed',
                                      style: GoogleFonts.lato(color: Colors.white, fontSize: 16),
                                    ),
                                    onPressed: (){
                                      sendPaymentRequest(amount);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ):Container(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: widget.isSeller?BorderSide.none:BorderSide(color: Colors.deepOrange[400], width: 1.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                        controller: msgController,
                        onChanged: (value) {
                          txtMsg = value;
                        },
                        maxLines: null,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          hintText: 'Type your message here...',
                          border: InputBorder.none,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: FlatButton(
                      disabledColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      color: Colors.deepOrange[400],
                      onPressed: () {
                        bool isTxtNull = msgController.text.isEmpty;
                        if(isTxtNull==false){
                          _fireStore
                              .collection('user_account_details')
                              .document(widget.isSeller? widget.buyerUid:userUid)
                              .collection('chats')
                              .document(widget.isSeller? userUid:widget.sellerUid)
                              .collection('messages')
                              .document(DateTime.now().toString())
                              .setData({
                            'message': txtMsg,
                            'sender': widget.isSeller?'seller':'user',
                          });
                          _fireStore
                              .collection('sellers')
                              .document(widget.isSeller?storeCity:placeMark[0].locality)
                              .collection('seller_info')
                              .document(widget.isSeller?userUid:widget.sellerUid)
                              .collection('chats')
                              .document(widget.isSeller?widget.buyerUid:userUid)
                              .setData({
                            'RecentTimeStamp': DateTime.now().toString(),
                            'Name': buyerName,
                          });
                          msgController.clear();
                        }
                      },
                      child: Text(
                        'Send',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class paymentBubble extends StatefulWidget {
  paymentBubble({this.amount, this.isSeller, this.sellerUid, this.storeName, this.imgUrl, this.paymentId, this.paid});

  final String amount;
  final String sellerUid;
  final String storeName;
  final String imgUrl;
  final String paymentId;
  final bool isSeller;
  final bool paid;

  @override
  _paymentBubbleState createState() => _paymentBubbleState();
}

class _paymentBubbleState extends State<paymentBubble> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: widget.isSeller ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            width: MediaQuery.of(context).size.width*0.4,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              border: Border.all(color: Colors.deepOrange[400], width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Text(
                    'Rs. '+widget.amount,
                    style: GoogleFonts.lato(color: Colors.black54, fontSize: 20,),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            width: MediaQuery.of(context).size.width*0.4,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.deepOrange[400],
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
              border: Border.all(color: Colors.deepOrange[400], width: 2),
            ),
            child: Center(
              child: widget.isSeller?Text(
                widget.paid?'Paid':'Requested',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(color: Colors.white, fontSize: 16),
              ):!widget.paid?RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                elevation: 10,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ConfirmAddressScreen(
                      amount: widget.amount,
                      storeName: widget.storeName,
                      sellerUid: widget.sellerUid,
                      imgUrl: widget.imgUrl,
                      paymentID: widget.paymentId,
                    );
                  }));
                },
                color: Colors.white,
                child: Text(
                  'Pay',
                  style: GoogleFonts.lato(color: Colors.black, fontSize: 20),
                ),
              ):Text(
                'Paid',
                style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class msgBubble extends StatelessWidget {
  msgBubble({this.msg, this.isMe});
  final String msg;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 5,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
            color: isMe ? Colors.deepOrange[300] : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                msg,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
