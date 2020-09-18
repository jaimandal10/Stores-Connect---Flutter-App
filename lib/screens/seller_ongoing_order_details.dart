import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_sell/screens/home_screen.dart';

class SellerOngoingOrderDetails extends StatefulWidget {
  SellerOngoingOrderDetails(
      {this.time,
      this.date,
      this.buyerName,
      this.buyerUid,
      this.deliveryAddress,
      this.total,
      this.delivered,
      this.isCod, this.outForDelivery});

  final String buyerName, buyerUid, total, date, time, deliveryAddress;
  final bool isCod, delivered, outForDelivery;

  @override
  _SellerOngoingOrderDetailsState createState() =>
      _SellerOngoingOrderDetailsState();
}

class _SellerOngoingOrderDetailsState extends State<SellerOngoingOrderDetails> {
  bool outForDelivery = false;
  bool delivered = false;
  var _fireStore = Firestore.instance;

  updateDeliveryStatus(bool delivered) {
    if(!delivered){
      _fireStore
          .collection('user_account_details')
          .document(widget.buyerUid)
          .collection('orders')
          .document(widget.date+" "+widget.time)
          .updateData({
        'OutForDelivery': true ,
      });

      _fireStore
          .collection('sellers')
          .document(storeCity.value)
          .collection('seller_info')
          .document(userUid)
          .collection('ongoing_orders')
          .document(widget.date + " " + widget.time)
          .updateData({
        'OutForDelivery': true,
      });
    }else{
      _fireStore
          .collection('user_account_details')
          .document(widget.buyerUid)
          .collection('orders')
          .document(widget.date+" "+widget.time)
          .updateData({
        'Delivered': true ,
      });

      _fireStore
          .collection('sellers')
          .document(storeCity.value)
          .collection('seller_info')
          .document(userUid)
          .collection('ongoing_orders')
          .document(widget.date + " " + widget.time)
          .updateData({
        'Delivered': true,
      });

      _fireStore
          .collection('sellers')
          .document(storeCity.value)
          .collection('seller_info')
          .document(userUid)
          .collection('ongoing_orders')
          .document(widget.date+" "+widget.time)
          .delete();

      _fireStore
          .collection('sellers')
          .document(storeCity.value)
          .collection('seller_info')
          .document(userUid)
          .collection('completed_orders')
          .document(widget.date+" "+widget.time)
          .setData({
        'Delivery Address': widget.deliveryAddress,
        'Total': widget.total,
        'Cod': widget.isCod,
        'BuyerName': userFirstName.value + userLastName.value,
        'BuyerUid': userUid,
      });
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    outForDelivery = widget.outForDelivery;
    delivered = widget.delivered;
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
                        widget.buyerName,
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
                !outForDelivery?RaisedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text(
                            'Confirm',
                            style: GoogleFonts.lato(color: Colors.black.withOpacity(0.75), fontSize: 18),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(
                                  'Please click confirm only if the order is out for delivery.',
                                  style: GoogleFonts.lato(color: Colors.black54, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            RaisedButton(
                              onPressed: (){
                                setState(() {
                                  outForDelivery = true;
                                });
                                updateDeliveryStatus(false);
                                Navigator.of(context).pop();
                              },
                              color: Colors.red[700],
                              child: Text(
                                'Confirm',
                                style: GoogleFonts.lato(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  color: Colors.deepOrange[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Text(
                    'Out For Delivery ?',
                    style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
                  ),
                ):Container(),
                (outForDelivery && !delivered)?RaisedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text(
                            'Confirm',
                            style: GoogleFonts.lato(color: Colors.black.withOpacity(0.75), fontSize: 18),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(
                                  'Please click confirm only if the order has been delivered.',
                                  style: GoogleFonts.lato(color: Colors.black54, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            RaisedButton(
                              onPressed: (){
                                setState(() {
                                  delivered = true;
                                });
                                updateDeliveryStatus(true);
                                Navigator.of(context).pop();
                              },
                              color: Colors.red[700],
                              child: Text(
                                'Confirm',
                                style: GoogleFonts.lato(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  color: Colors.red[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Text(
                    'Delivered ?',
                    style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
                  ),
                ):Container(),
                (outForDelivery && delivered)?Container(
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
