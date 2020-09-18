import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_sell/screens/household_items_list.dart';
import 'package:home_sell/screens/seller_chat_list.dart';
import 'package:home_sell/screens/seller_completed_orders_screen.dart';
import 'package:home_sell/screens/seller_edit_address_screen.dart';
import 'package:home_sell/screens/seller_orders_screen.dart';
import 'package:home_sell/screens/store_image_screen.dart';
import 'package:home_sell/utilities/authservice.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';

import 'home_screen.dart';

class SellerProfileScreen extends StatefulWidget {

  static const String id = 'seller_profile_screen';

  @override
  _SellerProfileScreenState createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {

  String imageUrl = '';
  bool noImage = false;

  getStoreImage() async {
    try {
      String url = await FirebaseStorage.instance
          .ref()
          .child('images/$userUid.png')
          .getDownloadURL();
      setState(() {
        imageUrl = url;
      });
    } catch (e) {
      setState(() {
        noImage = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStoreImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[400],
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.chat),
            color: Colors.black,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return SellerChatList();
              }));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 70),
              decoration: BoxDecoration(
                color: Color(0xFFF1EFF1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return ImageCapture();
                    }));
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: MediaQuery.of(context).size.width / 2.5,
                      width: MediaQuery.of(context).size.width / 2.5,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: noImage
                          ? Image.asset(
                        'images/default_item_image.png',
                        fit: BoxFit.fill,
                      )
                          : imageUrl == ''
                          ? Loading(
                        size: 60,
                        indicator: BallScaleIndicator(),
                        color: Colors.black,
                      )
                          : Image.network(
                        imageUrl,
                        fit: BoxFit.fitHeight,
                        loadingBuilder:
                            (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: loadingProgress != null
                                ? Loading(
                              size: 60,
                              indicator: BallScaleIndicator(),
                              color: Colors.black,
                            )
                                : null,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    !isStore.value?GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, HouseholdItemsList.id);
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Items Sold',
                                style: GoogleFonts.lato(color: Colors.deepOrange[400], fontSize: 18),
                              ),
                              Icon(Icons.timer, color: Colors.black,),
                            ],
                          ),
                        ),
                      ),
                    ):Container(),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, SellerEditAddressScreen.id);
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Account Details',
                                style: GoogleFonts.lato(color: Colors.deepOrange[400], fontSize: 18),
                              ),
                              Icon(Icons.account_circle, color: Colors.black,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, SellerCompletedOrdersScreen.id);
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Completed Orders',
                                style: GoogleFonts.lato(color: Colors.deepOrange[400], fontSize: 18),
                              ),
                              Icon(Icons.timer, color: Colors.black,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, SellerOrderScreen.id);
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Ongoing Orders',
                                style: GoogleFonts.lato(color: Colors.deepOrange[400], fontSize: 18),
                              ),
                              Icon(Icons.timer, color: Colors.black,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        AuthService().signOut(context);
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Sign Out',
                                style: GoogleFonts.lato(color: Colors.deepOrange[400], fontSize: 18),
                              ),
                              Icon(Icons.power_settings_new, color: Colors.black,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
