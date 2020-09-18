import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_sell/screens/home_screen.dart';
import 'package:home_sell/screens/seller_completed_order_details.dart';
import 'package:home_sell/screens/seller_order_details_screen.dart';

class SellerCompletedOrdersScreen extends StatefulWidget {
  static const String id = 'seller_completed_orders_screen';

  @override
  _SellerCompletedOrdersScreenState createState() =>
      _SellerCompletedOrdersScreenState();
}

class _SellerCompletedOrdersScreenState
    extends State<SellerCompletedOrdersScreen> {
  var _fireStore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Completed',
          style: GoogleFonts.lato(color: Colors.black),
        ),
        centerTitle: true,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: _fireStore
                  .collection('sellers')
                  .document(storeCity.value)
                  .collection('seller_info')
                  .document(userUid)
                  .collection('completed_orders').orderBy(FieldPath.documentId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    ),
                  );
                }

                final orders = snapshot.data.documents;

                if (orders.length == 0) {
                  return Center(
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Text(
                        'No Orders',
                        style: GoogleFonts.lato(
                            color: Colors.grey,
                            fontSize: 20,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  );
                }

                List<Widget> orderBubbles = [];

                for (var order in orders) {
                  orderBubbles.add(OrderBubble(
                    deliveryAddress: order.data['Delivery Address'],
                    isCod: order.data['Cod'],
                    total: double.parse(order.data['Total']),
                    date: order.documentID.split(" ")[0],
                    buyerName: order.data['BuyerName'],
                    time: order.documentID.split(" ")[1],
                  ));
                }

                return Expanded(
                  child: ListView(
                    children: orderBubbles.reversed.toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OrderBubble extends StatefulWidget {
  OrderBubble(
      {this.deliveryAddress,
        this.date,
        this.isCod, this.time, this.total, this.buyerName});

  final String deliveryAddress;
  final String date;
  final bool isCod;
  final String time;
  final String buyerName;
  final double total;

  @override
  _OrderBubbleState createState() => _OrderBubbleState();
}

class _OrderBubbleState extends State<OrderBubble> {
  String deliveryAddress = '';
  String date = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      date = widget.date;
      deliveryAddress = widget.deliveryAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.buyerName,
                    style:
                    GoogleFonts.lato(color: Colors.black54, fontSize: 16),
                  ),
                  Text(
                    widget.time,
                    style:
                    GoogleFonts.lato(color: Colors.black54, fontSize: 12),
                  ),
                  Text(
                    widget.date,
                    style:
                    GoogleFonts.lato(color: Colors.black54, fontSize: 12),
                  ),
                  RichText(
                    text: TextSpan(
                      style:
                      GoogleFonts.lato(color: Colors.black54, fontSize: 12),
                      children: <TextSpan>[
                        widget.isCod
                            ? TextSpan(
                          text: 'Cash On Delivery',
                          style: GoogleFonts.lato(
                              color: Colors.red[700], fontSize: 12,fontWeight: FontWeight.bold),
                        )
                            : TextSpan(
                          text: 'Paid',
                          style: GoogleFonts.lato(
                              color: Colors.green, fontSize: 12,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
//                  Text(
//                    widget.pickUp? 'Take Away':'Home Delivery',
//                    style:
//                    GoogleFonts.lato(color: Colors.black54, fontSize: 12),
//                  ),
                ],
              ),
              RaisedButton(
                color: Colors.deepOrange[400],
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SellerCompletedOrderDetails(
                      deliveryAddress: deliveryAddress,
                      isCod: widget.isCod,
                      total: widget.total.toString(),
                      date: widget.date,
                      time: widget.time,
                      buyerName: widget.buyerName,
                    );
                  }));
                },
                child: Text(
                  'View',
                  style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}