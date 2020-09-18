import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_sell/screens/buyer_order_seller_items_screen.dart';
import 'package:home_sell/screens/home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class BuyerOrderDetailsScreen extends StatefulWidget {
  BuyerOrderDetailsScreen({this.deliveryAddress, this.delivered, this.total, this.outForDelivery, this.storeName, this.date, this.isCod, this.time});

  final String deliveryAddress, time, date, total, storeName;
  final bool isCod, delivered, outForDelivery;

  @override
  _BuyerOrderDetailsScreenState createState() =>
      _BuyerOrderDetailsScreenState();
}

class _BuyerOrderDetailsScreenState extends State<BuyerOrderDetailsScreen> {
  var _fireStore = Firestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Order Details',
                  style: GoogleFonts.lato(
                      color: Colors.deepOrange[400], fontSize: 32),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.storeName,
                        style: GoogleFonts.lato(
                            color: Colors.black.withOpacity(0.75),
                            fontSize: 22),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        widget.date,
                        style: GoogleFonts.lato(
                            color: Colors.black.withOpacity(0.75)),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        widget.time,
                        style: GoogleFonts.lato(
                            color: Colors.black.withOpacity(0.75)),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.deliveryAddress,
                        style: GoogleFonts.lato(
                            color: Colors.black87, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text(
                    'Order Amount',
                    style: GoogleFonts.lato(color: Colors.black, fontSize: 20),
                  ),
                  trailing: Text(
                    'Rs.' + (double.parse(widget.total) - 10).toString(),
                    style: GoogleFonts.lato(color: Colors.black, fontSize: 20),
                  ),
                ),
                Divider(
                  color: Colors.black54,
                  thickness: 1,
                ),
                ListTile(
                  title: Text(
                    'Delivery Charges',
                    style: GoogleFonts.lato(color: Colors.black, fontSize: 20),
                  ),
                  trailing: Text(
                    'Rs.10',
                    style: GoogleFonts.lato(color: Colors.black, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'Total amount',
                      style: GoogleFonts.lato(color: Colors.deepOrange[400]),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'Rs ' + (double.parse(widget.total)).toString(),
                      style: GoogleFonts.lato(color: Colors.black87),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                !widget.outForDelivery?Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.deepOrange[400],
                  ),
                  child: Text(
                    'Not Out For Delivery',
                    style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
                  ),
                ):Container(),
                (widget.outForDelivery && !widget.delivered)?Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.deepOrange[400],
                  ),
                  child: Text(
                    'Out For Delivery',
                    style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
                  ),
                ):Container(),
                (widget.outForDelivery && widget.delivered)?Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.deepOrange[400],
                  ),
                  child: Text(
                    'Order Complete',
                    style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
                  ),
                ):Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

