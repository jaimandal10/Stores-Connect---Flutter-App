import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'account_screen.dart';
import 'home_screen.dart';

class LocationScreen extends StatefulWidget {
  static const String id = 'location_screen';

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

var nav = {
  1: HomeScreen.id,
  0: AccountScreen.id,
  2: LocationScreen.id,
};
int index = 2;

class _LocationScreenState extends State<LocationScreen> {
  bool mapToggle = false;
  var currentLoc;
  GoogleMapController mapController;
  String userCity;
  Position userPos;
  List<Widget> clients = [];

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  void initState() {
    super.initState();
    Geolocator().getCurrentPosition().then((value) {
      setState(() {
        currentLoc = value;
        mapToggle = true;
      });
    });
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
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 136,
                width: double.infinity,
                child: mapToggle
                    ? GoogleMap(
                        onMapCreated: onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target:
                              LatLng(currentLoc.latitude, currentLoc.longitude),
                          zoom: 16,
                        ),
                        markers: Set.from(markers),
                      )
                    : Center(
                        child: Text(
                          'Loading...Please Wait',
                          style: GoogleFonts.lato(
                              fontSize: 20, color: Colors.grey),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
