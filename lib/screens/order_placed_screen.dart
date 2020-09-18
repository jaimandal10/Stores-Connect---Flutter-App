import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_sell/screens/home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl/intl.dart';

class OrderPlacedScreen extends StatefulWidget {
  OrderPlacedScreen(
      {this.amount,
      this.deliveryAddress,
      this.cod,
      this.pickUp,
      this.sellerUid,
      this.storeName,
      this.paymentId});

  final String deliveryAddress;
  final String amount;
  final bool cod;
  final bool pickUp;
  final String sellerUid;
  final String storeName;
  final String paymentId;

  static const String id = 'order_placed_screen';

  @override
  _OrderPlacedScreenState createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  var _fireStore = Firestore.instance;
  bool showSpinner = false;
  String deliveryAddress = '';
  String formattedDate;
  String formattedTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime now = new DateTime.now();
    var dateFormatter = new DateFormat('yyyy-MM-dd');
    var timeFormatter = new DateFormat('HH:mm:ss');
    setState(() {
      formattedTime = timeFormatter.format(now);
      formattedDate = dateFormatter.format(now);
      deliveryAddress = widget.deliveryAddress;
      showSpinner = true;
    });
    sendOrderToSeller();
    saveOrderDetails();
    setState(() {
      showSpinner = false;
    });
  }

  saveOrderDetails() async {
    _fireStore
        .collection('user_account_details')
        .document(userUid)
        .collection('orders')
        .document(formattedDate + " " + formattedTime)
        .setData({
      'Delivery Address': deliveryAddress,
      'Total': widget.amount,
      'Cod': widget.cod,
      'StoreName': widget.storeName,
      'SellerUid': widget.sellerUid,
      'Delivered': false,
      'OutForDelivery': false,
    });
    _fireStore
        .collection('user_account_details')
        .document(userUid)
        .collection('chats')
        .document(widget.sellerUid)
        .collection('messages')
        .document(widget.paymentId).updateData({
      'paid': true,
      'cod': widget.cod,
    });
  }

  sendOrderToSeller() async {
    _fireStore
        .collection('sellers')
        .document(placeMark[0].locality)
        .collection('seller_info')
        .document(widget.sellerUid)
        .collection('ongoing_orders')
        .document(formattedDate + " " + formattedTime)
        .setData({
      'Delivery Address': deliveryAddress,
      'Total': widget.amount,
      'Cod': widget.cod,
      'BuyerName': userFirstName.value + userLastName.value,
      'BuyerUid': userUid,
      'Delivered': false,
      'OutForDelivery': false,
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                numCart.value = 0;
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.thumb_up,
                    color: Colors.deepOrange[400],
                    size: 200,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Congratulations!!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(color: Colors.black, fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Your order has been placed',
                    style: GoogleFonts.lato(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      numCart.value = 0;
                      Navigator.of(context).pop();
                    },
                    color: Colors.deepOrange[400],
                    child: Text(
                      'Continue Shopping',
                      style:
                          GoogleFonts.lato(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
