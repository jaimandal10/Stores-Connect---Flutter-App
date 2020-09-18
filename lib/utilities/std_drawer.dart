import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_sell/screens/buyer_orders_screen.dart';
import 'package:home_sell/screens/contatc_us_screen.dart';
import 'package:home_sell/screens/location_screen.dart';
import 'package:home_sell/screens/notifications_screen.dart';
import 'package:home_sell/screens/home_screen.dart';
import 'package:home_sell/screens/account_screen.dart';
import 'package:home_sell/screens/about_screen.dart';
import 'package:home_sell/screens/edit_account_details_screen.dart';
import 'package:home_sell/screens/privacy_policy_screen.dart';
import 'package:home_sell/screens/seller_approval_pending_screen.dart';
import 'package:home_sell/screens/seller_profile_screen.dart';
import 'package:home_sell/screens/store_or_household.dart';
import 'package:home_sell/utilities/authservice.dart';
import 'package:home_sell/utilities/list_tile.dart';
import 'package:home_sell/screens/faq_screen.dart';
import 'package:home_sell/screens/edit_address_screen.dart';
import 'package:home_sell/screens/seller_entry_screen.dart';

class StdDrawer extends StatefulWidget {
  StdDrawer(
      {this.isSeller, this.markers, this.address, this.userName, this.ctx});

  final isSeller;
  final List<Marker> markers;
  final String userName;
  final String address;
  final BuildContext ctx;

  @override
  _StdDrawerState createState() => _StdDrawerState();
}

class _StdDrawerState extends State<StdDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Stores',
                        style: GoogleFonts.lato(
                          color: Colors.deepOrange[400],
                          fontSize: 26,
                        ),
                      ),
                      Container(
                        width: 5,
                      ),
                      Text(
                        'Connect',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 26,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 5,
                  color: Colors.grey[300],
                ),
                Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(
                        child: ValueListenableBuilder(
                          valueListenable: userFirstName,
                          builder: (context, value, child) {
                            return Text(
                              'Hi, ' + userFirstName.value,
                              style: GoogleFonts.lato(
                                  fontSize: 16, color: Colors.black),
                            );
                          },
                        ),
                      ),
                      Flexible(
                        child: GestureDetector(
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, EditAccount.id);
                          },
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          color: Colors.white24,
                          child: Text(
                            userAddress.value,
                            softWrap: true,
                            style: GoogleFonts.lato(
                              color: Colors.black54,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: GestureDetector(
                          child: Icon(Icons.edit),
                          onTap: () {
                            Navigator.pushNamed(context, EditAddressScreen.id);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
//          ListTileStd(
//            txt: 'Home',
//            goTo: HomeScreen.id,
//            icon: Icons.home,
//          ),
          ListTileStd(
            txt: 'Account',
            goTo: AccountScreen.id,
            icon: Icons.account_circle,
          ),
          ListTileStd(
            txt: 'Orders',
            goTo: BuyerOrdersScreen.id,
            icon: Icons.history,
          ),
          ListTile(
            title: Text(
              'Map',
              style: GoogleFonts.lato(
                fontSize: 18,
                color: Colors.deepOrange[400],
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LocationScreen();
              }));
            },
            trailing: Icon(Icons.location_on, color: Colors.black),
          ),
          ListTileStd(
            txt: 'About',
            goTo: AboutScreen.id,
            icon: Icons.info,
          ),
          ListTileStd(
            txt: 'FAQs',
            goTo: FAQScreen.id,
            icon: FontAwesomeIcons.question,
          ),
          ListTileStd(
            txt: seller.value ? 'Seller Acc' : 'Want to sell?',
            goTo: seller.value
                ? isApproved.value
                    ? SellerProfileScreen.id
                    : SellerApprovalPendingScreen.id
                : StoreOrHousehold.id,
            icon: Icons.arrow_forward_ios,
          ),
          ListTileStd(
            txt: 'Contact Us',
            goTo: ContactUsScreen.id,
            icon: Icons.mail,
          ),
          ListTileStd(
            txt: 'Privacy Policy',
            goTo: PrivacyPolicyScreen.id,
            icon: Icons.lock,
          ),
          ListTile(
            title: Text(
              'Sign Out',
              style:
                  GoogleFonts.lato(fontSize: 18, color: Colors.deepOrange[400]),
            ),
            onTap: () {
              Navigator.of(context).pop();
              AuthService().signOut(widget.ctx);
            },
            trailing: Icon(Icons.power_settings_new, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
