import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_sell/screens/buyer_orders_screen.dart';
import 'package:home_sell/screens/seller_approval_pending_screen.dart';
import 'package:home_sell/screens/seller_profile_screen.dart';
import 'package:home_sell/screens/store_or_household.dart';
import 'edit_account_details_screen.dart';
import 'home_screen.dart';
import 'package:home_sell/utilities/list_tile_account.dart';
import 'location_screen.dart';
import 'notifications_screen.dart';
import 'package:home_sell/utilities/authservice.dart';
import 'seller_entry_screen.dart';
import 'edit_address_screen.dart';

class AccountScreen extends StatefulWidget {

  static const String id = 'account_screen';
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

var nav = {
  1: HomeScreen.id,
  0: AccountScreen.id,
  2: LocationScreen.id,
};
int index = 0;

class _AccountScreenState extends State<AccountScreen> {

  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'My Account',
          style: GoogleFonts.lato(color: Colors.black),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Account'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            title: Text('Map'),
          ),
//                  BottomNavigationBarItem(
//                    icon: ValueListenableBuilder(
//                      valueListenable: numCart,
//                      builder: (context, value, child) {
//                        return Badge(
//                          showBadge: (numCart.value != 0),
//                          padding: (numCart.value > 9)
//                              ? EdgeInsets.all(3)
//                              : EdgeInsets.all(5),
//                          position:
//                              BadgePosition.topRight(top: -15, right: -10),
//                          animationDuration: Duration(milliseconds: 300),
//                          //animationType: BadgeAnimationType.slide,
//                          badgeContent: Center(
//                            child: Text(
//                              numCart.value.toString(),
//                              style: GoogleFonts.lato(
//                                  fontSize: 14, color: Colors.white),
//                            ),
//                          ),
//                          child: Icon(
//                            Icons.shopping_cart,
//                          ),
//                        );
//                      },
//                    ),
//                    title: Text('Cart'),
//                  ),
        ],
        currentIndex: index,
        showSelectedLabels: true,
        unselectedFontSize: 10,
        unselectedIconTheme: IconThemeData(size: 20),
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.deepOrange[400],
        onTap: (int index) async {
          if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return LocationScreen();
                }));
          } else
            Navigator.pushNamed(context, nav[index]);
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: ListView(
          children: <Widget>[
            Container(
              //Logo
              height: 30,
              child: Image.asset('images/Logo_SC_400.png')
            ),
            Container(
              //User Details
              color: Colors.deepOrange[400],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ValueListenableBuilder(
                          //User Name
                          valueListenable: userFirstName,
                          builder: (context, value, child) {
                            return ValueListenableBuilder(
                              valueListenable: userLastName,
                              builder: (context, value, child) {
                                return Text(
                                  (userFirstName.value == "" &&
                                          userLastName.value == "")
                                      ? "..."
                                      : userFirstName.value +
                                          " " +
                                          userLastName.value,
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                    //color: Colors.white,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        GestureDetector(
                          //Edit Icon
                          child: Icon(Icons.edit),
                          onTap: () {
                            Navigator.pushNamed(context, EditAccount.id);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ValueListenableBuilder(
                      //User Email
                      valueListenable: userEmail,
                      builder: (context, value, child) {
                        return Text(
                          userEmail.value == null ? "..." : userEmail.value,
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            //color: Colors.white,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ValueListenableBuilder(
                      //User Phone Number
                      valueListenable: userPhoneNumber,
                      builder: (context, value, child) {
                        return Text(
                          userPhoneNumber.value == null
                              ? "..."
                              : userPhoneNumber.value,
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            //color: Colors.white,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      //User Address
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Address:',
                                style: GoogleFonts.lato(color: Colors.black54),
                              ),
                              GestureDetector(
                                child: Icon(Icons.edit),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, EditAddressScreen.id);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            userLine1.value +
                                ", " +
                                userLine2.value +
                                ", " +
                                userCity.value +
                                ", " +
                                userState.value,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                                color: Colors.black54,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTileAcc(
              txt: 'My Orders',
              goTo: BuyerOrdersScreen.id,
              icon: Icons.history,
            ),
            Divider(
              indent: 15,
              endIndent: 15,
              color: Colors.grey,
              height: 8,
            ),
//            ListTileAcc(
//              txt: 'Notifications',
//              goTo: NotificationsScreen.id,
//              icon: Icons.notifications,
//            ),
//            Divider(
//              indent: 15,
//              endIndent: 15,
//              color: Colors.grey,
//              height: 8,
//            ),
            ValueListenableBuilder(
              valueListenable: seller,
              builder: (context, value, child) {
                return ListTileAcc(
                  txt: 'Want to sell?',
                  goTo:
                  seller.value ? isApproved.value?SellerProfileScreen.id:SellerApprovalPendingScreen.id : StoreOrHousehold.id,
                  icon: Icons.arrow_forward_ios,
                );
              },
            ),
            Divider(
              indent: 15,
              endIndent: 15,
              color: Colors.grey,
              height: 8,
            ),
            ListTile(
              title: Text(
                'Log Out',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                AuthService().signOut(context);
              },
              leading: Icon(
                Icons.power_settings_new,
                color: Colors.black,
              ),
            ),
            Divider(
              indent: 15,
              endIndent: 15,
              color: Colors.grey,
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
