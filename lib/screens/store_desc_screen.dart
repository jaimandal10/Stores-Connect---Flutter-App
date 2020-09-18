import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_sell/screens/chat_screen.dart';

import 'home_screen.dart';

class StoreDescScreen extends StatefulWidget {

  static const String id = 'store_desc_screen';

  StoreDescScreen(
      {this.sellerUid,
      this.storeName,
      this.imageUrl,
      this.position,
      this.distance, this.isStore, this.storeDesc});

  final String sellerUid;
  final String storeName;
  final String imageUrl;
  final String storeDesc;
  final String distance;
  final LatLng position;
  final bool isStore;

  @override
  _StoreDescScreenState createState() => _StoreDescScreenState();
}

class _StoreDescScreenState extends State<StoreDescScreen> {
  GoogleMapController mapController;
  bool mapToggle = false;
  var _fireStore = Firestore.instance;
  var currentLoc;
  List<Marker> markerList;

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  void initState() {
    super.initState();
    markerList = [
      Marker(
        markerId: MarkerId(widget.storeName),
        infoWindow: InfoWindow(
          title: widget.storeName,
          snippet: widget.distance + "m📍",
        ),
        draggable: false,
        onTap: () {},
        position: widget.position,
      )
    ];
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
      backgroundColor: Colors.white,
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
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.3, vertical: 10),
        height: MediaQuery.of(context).size.width*.12,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return ChatScreen(
                sellerUid: widget.sellerUid,
                isSeller: false,
                storeName: widget.storeName,
                imgUrl: widget.imageUrl,
              );
            }));
          },
          color: Colors.deepOrange[400],
          child: Hero(
            tag: 'chatIcon',
            child: Icon(
              Icons.chat_bubble_outline,
              color: Colors.black,
              size: 32,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03, bottom: 0),
                child: Hero(
                  tag: 'storeImage',
                  child: Image.network(
                    widget.imageUrl,
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.height * 0.15,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Hero(
                tag: 'storeName',
                child: Container(
                  height: MediaQuery.of(context).size.height*0.04,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      widget.storeName,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(color: Colors.black, fontSize: 20, decoration: TextDecoration.none, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.02),
                child: Text(
                  widget.storeDesc,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: Colors.black54,
                      fontSize: 20,
                      fontStyle: FontStyle.italic),
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),
              widget.isStore?Container():StreamBuilder(
                stream: _fireStore
                    .collection('sellers')
                    .document(placeMark[0].locality)
                    .collection('seller_info')
                    .document(widget.sellerUid)
                    .collection('items')
                    .orderBy('TimeStamp')
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

                  final items = snapshot.data.documents;

                  List<Widget> itemWidgets = [];
                  if(items.length!=0){
                    itemWidgets.add(Column(
                      children: <Widget>[
                        Text(
                          'Items Sold:',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(color: Colors.deepOrange[400], fontSize: 20),
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),);
                  }
                  for (var item in items) {
                    itemWidgets.add(Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: MediaQuery.of(context).size.width*0.15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.angleRight,
                            size: 16,
                            color: Colors.deepOrange[400],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Text(
                              item.documentID,
                              style: GoogleFonts.lato(color: Colors.black.withOpacity(0.7), fontSize: 18, fontStyle: FontStyle.italic),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ));
                  }

                  return Column(
                    children: itemWidgets,
                  );
                },
              ),
              Container(
                height: MediaQuery.of(context).size.width*0.8,
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1, vertical: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                  Border.all(color: Colors.deepOrange[400], width: 10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[400],
                      spreadRadius: 3,
                      blurRadius: 3,
                    ),
                  ],
                  color: Colors.black54,
                ),
                child: mapToggle
                    ? ClipOval(
                  child: GoogleMap(
                    onMapCreated: onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: widget.position,
                      zoom: 15,
                    ),
                    markers: Set.from(markerList),
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                  ),
                )
                    : Center(
                  child: Text(
                    'Loading...Please Wait',
                    style: GoogleFonts.lato(
                        fontSize: 20, color: Colors.white, fontStyle: FontStyle.italic),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
