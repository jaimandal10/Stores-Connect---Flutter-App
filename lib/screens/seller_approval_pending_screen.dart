import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerApprovalPendingScreen extends StatefulWidget {

  static const String id = 'seller_approval_pending_screen';

  @override
  _SellerApprovalPendingScreenState createState() => _SellerApprovalPendingScreenState();
}

class _SellerApprovalPendingScreenState extends State<SellerApprovalPendingScreen> {
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
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Approval Pending',
                      style: GoogleFonts.lato(color: Colors.deepOrange[400],fontSize: 24,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'Your request for selling on the app has been placed. We will contact you as soon as possible to confirm your request.',
                      style: GoogleFonts.lato(color: Colors.black,fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
