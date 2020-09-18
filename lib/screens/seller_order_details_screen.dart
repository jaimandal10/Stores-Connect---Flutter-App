import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_sell/screens/home_screen.dart';
import 'package:home_sell/screens/seller_orders_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SellerOrderDetails extends StatefulWidget {
  SellerOrderDetails(
      {this.buyerID,
      this.deliveryAddress,
      this.dateAndTime,
      this.cod,
      this.delivered,
      this.total,
      this.isCompleted});

  final String buyerID;
  final String deliveryAddress;
  final String dateAndTime;
  final bool cod;
  final bool delivered;
  final double total;
  final bool isCompleted;

  @override
  _SellerOrderDetailsState createState() => _SellerOrderDetailsState();
}

class _SellerOrderDetailsState extends State<SellerOrderDetails> {
  var _fireStore = Firestore.instance;
  String buyerID = '';
  String deliveryAddress = '';
  bool showSpinner = false;
  bool delivered = false;
  List items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(deliveryAddress);
    setState(() {
      buyerID = widget.buyerID;
      deliveryAddress = widget.deliveryAddress;
      delivered = widget.delivered;
    });
  }

  onDeliveryConfirmed() async {
    sendOrderToBuyerCompleted();
    sellerSaveOrder();
    deleteOrder();
    deleteBuyerOrder();
    Navigator.of(context).pop();
  }

  deleteBuyerOrder() async {
    var ref = _fireStore
        .collection('user_account_details')
        .document(buyerID)
        .collection('orders_pending')
        .document(widget.dateAndTime);
    ref.collection('sellers').getDocuments().then((snapshot) {
      if (snapshot.documents.length == 1) {
        ref.collection('sellers').document(userUid).delete();
        ref.delete();
      } else {
        ref.collection('sellers').document(userUid).delete();
      }
    });
  }

  sendOrderToBuyerCompleted() async {
    var ref = _fireStore
        .collection('user_account_details')
        .document(buyerID.split(" ")[0])
        .collection('orders_completed')
        .document(widget.dateAndTime);
    ref.setData({
      'DeliveryDone': true,
      'COD': widget.cod,
      'DeliveryAddress': deliveryAddress,
    }).then((value) {
      for (var item in items) {
        ref.collection('sellers').document(userUid).setData({
          'HasDelivered': true,
          'StoreTotal': widget.total,
        });
        ref
            .collection('sellers')
            .document(userUid)
            .collection('items_purchased')
            .document(item['Name'])
            .setData({
          'Metric': item['Metric'],
          'Number': item['Number'],
          'Price': item['Price']
        });
      }
    });
  }

  sellerSaveOrder() async {
    var ref = _fireStore
        .collection('sellers')
        .document(storeCity.value)
        .collection('seller_info')
        .document(userUid)
        .collection('completed_orders')
        .document(buyerID);
    ref.setData({
      'DateAndTime': widget.dateAndTime,
      'COD': widget.cod,
      'DeliveryAddress': widget.deliveryAddress,
      'Total': widget.total,
    });
    for (var item in items) {
      ref.collection('items_bought').document(item['Name']).setData({
        'Metric': item['Metric'],
        'Number': item['Number'],
        'Price': item['Price']
      });
    }
  }

  deleteOrder() async {
    _fireStore
        .collection('sellers')
        .document(placeMark[0].locality)
        .collection('seller_info')
        .document(userUid)
        .collection('orders')
        .document(buyerID)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: widget.isCompleted
                  ? () {
                      Navigator.of(context).pop();
                    }
                  : () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return SellerOrderScreen();
                      }));
                    },
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.blueGrey[900],
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                'Total: Rs.${widget.total}',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Order Details',
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                StreamBuilder(
                  stream: _fireStore
                      .collection('user_account_details')
                      .document(buyerID.split(" ")[0])
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        ),
                      );
                    }

                    String phoneNumber = snapshot.data['PhoneNumber'];
                    String name = snapshot.data['FirstName'] +
                        " " +
                        snapshot.data['LastName'];

                    return Card(
                      shape: RoundedRectangleBorder(
                        side:
                            BorderSide(color: Colors.deepOrange[400], width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.white,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Name: ',
                                  style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  name,
                                  style: GoogleFonts.lato(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Phone Number: ',
                                  style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  phoneNumber,
                                  style: GoogleFonts.lato(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Delivery Address: ',
                                  style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  deliveryAddress,
                                  softWrap: true,
                                  style: GoogleFonts.lato(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 5,
                ),
//                delivered
//                    ? Card(
//                        shape: CircleBorder(),
//                        color: Colors.deepOrange[400],
//                        child: Padding(
//                          padding: EdgeInsets.all(5),
//                          child: Icon(
//                            Icons.check,
//                            color: Colors.black,
//                          ),
//                        ),
//                      )
//                    : RaisedButton(
//                        onPressed: confirmed
//                            ? () {
//                                showDialog(
//                                    context: context,
//                                    barrierDismissible: true,
//                                    builder: (BuildContext context) {
//                                      return AlertDialog(
//                                        title: Text(
//                                          'Confirm Delivery',
//                                          style: GoogleFonts.lato(
//                                              color: Colors.black,
//                                              fontSize: 16),
//                                        ),
//                                        content: SingleChildScrollView(
//                                          child: ListBody(
//                                            children: <Widget>[
//                                              Text(
//                                                'Please press confirm only if the delivey has been completed successfuly',
//                                                style: GoogleFonts.lato(
//                                                    color: Colors.black54,
//                                                    fontSize: 12),
//                                              ),
//                                            ],
//                                          ),
//                                        ),
//                                        actions: <Widget>[
//                                          RaisedButton(
//                                              color: Colors.red,
//                                              child: Text(
//                                                'Confirm',
//                                                style: GoogleFonts.lato(
//                                                    color: Colors.white,
//                                                    fontSize: 10),
//                                              ),
//                                              onPressed: () {
//                                                setState(() {
//                                                  showSpinner = true;
//                                                });
//                                                onDeliveryConfirmed()
//                                                    .then((value) {
//                                                  setState(() {
//                                                    showSpinner = false;
//                                                    delivered = true;
//                                                  });
//                                                });
//                                              }),
//                                        ],
//                                      );
//                                    });
//                              }
//                            : () {
//                                setState(() {
//                                  confirmed = true;
//                                });
//                                _fireStore
//                                    .collection('sellers')
//                                    .document(storeCity)
//                                    .collection('seller_info')
//                                    .document(userUid)
//                                    .collection('orders')
//                                    .document(buyerID)
//                                    .updateData({
//                                  'IsConfirmed': true,
//                                });
//                                _fireStore
//                                    .collection('user_account_details')
//                                    .document(buyerID.split(' ')[0])
//                                    .collection('orders_pending')
//                                    .document(buyerID.split(' ')[1] +
//                                        " " +
//                                        buyerID.split(' ')[2]).collection('sellers').document(userUid).updateData({
//                                  'IsConfirmed': true,
//                                });
//                              },
//                        color: confirmed
//                            ? Colors.deepOrange[400]
//                            : Colors.red[700],
//                        child: Text(
//                          confirmed ? 'Delivery Completed' : 'Confirm Order',
//                          style: GoogleFonts.lato(
//                              color: confirmed? Colors.black:Colors.white, fontSize: 16),
//                        ),
//                      ),
                SizedBox(
                  height: 5,
                ),
                StreamBuilder(
                  stream: _fireStore
                      .collection('sellers')
                      .document(storeCity.value)
                      .collection('seller_info')
                      .document(userUid)
                      .collection(delivered ? 'completed_orders' : 'orders')
                      .document(buyerID)
                      .collection('items_bought')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        ),
                      );
                    }

                    final itemsInOrder = snapshot.data.documents;

                    List<Widget> itemBoughtBubbles = [];
                    List itemsTemp = [];

                    for (var itemInOrder in itemsInOrder) {
                      Widget itemBoughtBubble = ItemBoughtBubble(
                        price: itemInOrder.data['Price'].toString(),
                        name: itemInOrder.documentID,
                        number: itemInOrder.data['Number'].toString(),
                        metric: itemInOrder.data['Metric'],
                      );
                      itemBoughtBubbles.add(itemBoughtBubble);
                      var itemData = {
                        'Price': itemInOrder.data['Price'].toString(),
                        'Name': itemInOrder.documentID,
                        'Number': itemInOrder.data['Number'].toString(),
                        'Metric': itemInOrder.data['Metric'],
                      };
                      itemsTemp.add(itemData);
                    }

                    items = itemsTemp;

                    return Expanded(
                      child: ListView(
                        children: itemBoughtBubbles,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemBoughtBubble extends StatefulWidget {
  ItemBoughtBubble({this.name, this.price, this.metric, this.number});

  final String name;
  final String price;
  final String number;
  final String metric;

  @override
  _ItemBoughtBubbleState createState() => _ItemBoughtBubbleState();
}

class _ItemBoughtBubbleState extends State<ItemBoughtBubble> {
  String name;
  String price;
  String metric;
  String number;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.name;
    price = widget.price;
    metric = widget.metric;
    number = widget.number;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.deepOrange[400], width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: GoogleFonts.lato(color: Colors.black, fontSize: 18),
                ),
                Text(
                  price + "/" + metric,
                  style: GoogleFonts.lato(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            Text(
              'Quantity: ' + number,
              style: GoogleFonts.lato(color: Colors.black54, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
