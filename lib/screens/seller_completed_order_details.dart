import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerCompletedOrderDetails extends StatelessWidget {

  SellerCompletedOrderDetails({this.time,
    this.date,
    this.buyerName,
    this.deliveryAddress,
    this.total, this.isCod});

  final String time, date, buyerName, deliveryAddress, total;
  final bool isCod;

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
                        buyerName,
                        style: GoogleFonts.lato(
                            color: Colors.black.withOpacity(0.75),
                            fontSize: 22),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        date,
                        style: GoogleFonts.lato(
                            color: Colors.black.withOpacity(0.75)),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        time,
                        style: GoogleFonts.lato(
                            color: Colors.black.withOpacity(0.75)),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        deliveryAddress,
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
                    'Rs.' + (double.parse(total) - 10).toString(),
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
                      'Rs ' + (double.parse(total)).toString(),
                      style: GoogleFonts.lato(color: Colors.black87),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.deepOrange[400],
                  ),
                  child: Text(
                    'Order Complete',
                    style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
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
