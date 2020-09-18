import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_sell/screens/home_screen.dart';

class BuyerOrderSellerItemsScreen extends StatefulWidget {
  BuyerOrderSellerItemsScreen({this.orderID, this.sellerID, this.isPending, this.storeTotal});

  final String orderID;
  final String sellerID;
  final bool isPending;
  final double storeTotal;

  @override
  _BuyerOrderSellerItemsScreenState createState() =>
      _BuyerOrderSellerItemsScreenState();
}

class _BuyerOrderSellerItemsScreenState
    extends State<BuyerOrderSellerItemsScreen> {
  var _fireStore = Firestore.instance;

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
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey[900],
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
          child: Text(
            'Total: Rs.${widget.storeTotal}',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(color: Colors.white,fontSize: 20),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: <Widget>[
              Text(
                'Items Purchased',
                style: GoogleFonts.lato(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder(
                stream: _fireStore
                    .collection('user_account_details')
                    .document(userUid)
                    .collection(widget.isPending?'orders_pending':'orders_completed')
                    .document(widget.orderID)
                    .collection('sellers')
                    .document(widget.sellerID)
                    .collection('items_purchased')
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

                  final itemsPurchased = snapshot.data.documents;

                  List<Widget> itemBoughtBubbles = [];

                  for (var itemPurchased in itemsPurchased) {
                    Widget itemBoughtBubble = ItemBoughtBubble(
                      price: itemPurchased.data['Price'].toString(),
                      name: itemPurchased.documentID,
                      number: itemPurchased.data['Number'].toString(),
                      metric: itemPurchased.data['Metric'],
                    );
                    itemBoughtBubbles.add(itemBoughtBubble);
                  }

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
