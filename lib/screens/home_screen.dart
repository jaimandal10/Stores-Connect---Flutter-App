import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_sell/screens/account_screen.dart';
import 'package:home_sell/screens/seller_approval_pending_screen.dart';
import 'package:home_sell/screens/seller_chat_list.dart';
import 'package:home_sell/screens/seller_orders_screen.dart';
import 'package:home_sell/screens/store_desc_screen.dart';
import 'package:home_sell/utilities/authservice.dart';
import 'package:home_sell/utilities/std_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'seller_entry_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'location_screen.dart';
import 'package:badges/badges.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var nav = {
  1: HomeScreen.id,
  0: AccountScreen.id,
  2: LocationScreen.id,
};
int index = 1;

List<Widget> stores = [];

//User Details' Variables
String userUid = '';

final ValueNotifier<int> numCart = ValueNotifier<int>(0);
final ValueNotifier<String> userFirstName = ValueNotifier<String>('');
final ValueNotifier<String> userLastName = ValueNotifier<String>('');
final ValueNotifier<String> userEmail = ValueNotifier<String>('');
final ValueNotifier<String> userPhoneNumber = ValueNotifier<String>('');
final ValueNotifier<String> userLine1 = ValueNotifier<String>('');
final ValueNotifier<String> userAddress = ValueNotifier<String>('');
final ValueNotifier<String> userLine2 = ValueNotifier<String>('');
final ValueNotifier<String> userLandmark = ValueNotifier<String>('');
final ValueNotifier<String> userCity = ValueNotifier<String>('');
final ValueNotifier<String> userState = ValueNotifier<String>('');
final ValueNotifier<String> userZip = ValueNotifier<String>('');
final ValueNotifier<bool> seller = ValueNotifier<bool>(false);
final ValueNotifier<bool> isApproved = ValueNotifier<bool>(false);
final ValueNotifier<bool> isStore = ValueNotifier<bool>(false);

final ValueNotifier<String> storeAddressCity = ValueNotifier<String>('');
final ValueNotifier<String> storeCity = ValueNotifier<String>('');
final ValueNotifier<String> storeAddressLine1 = ValueNotifier<String>('');
final ValueNotifier<String> storeAddressLine2 = ValueNotifier<String>('');
final ValueNotifier<String> storeAddressState = ValueNotifier<String>('');
final ValueNotifier<String> storeAddressZip = ValueNotifier<String>('');
final ValueNotifier<String> storeAddress = ValueNotifier<String>('');
final ValueNotifier<String> storeAddressName = ValueNotifier<String>('');
final ValueNotifier<String> storeDescription = ValueNotifier<String>('');
final ValueNotifier<String> storeOwnerEmail = ValueNotifier<String>('');
final ValueNotifier<String> storeOwnerPhoneNumber = ValueNotifier<String>('');
final ValueNotifier<String> storeOwnerName = ValueNotifier<String>('');

List<Placemark> placeMark;
Position userPos;
bool locPermission = false;
List<Marker> markers = [];

class _HomeScreenState extends State<HomeScreen> {
  String userCurrentCity;
  int selectedIndex = 1;
  bool showSpinner = false;
  List<Widget> store = [];
  List<Widget> householdBusinesses = [];
  bool error = false;
  var _fireStore = Firestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging();
  bool storesGot = false;
  bool gotLoc = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      showSpinner = true;
      error = false;
      seller.value = false;
    });
    try {
      getUid().then((value) {
        getToken();
        isSeller().then((value) {
          if (seller.value) {
            getStoreDetails();
          }
        });
        getUserInfo();
      });
    } catch (e) {
      setState(() {
        setState(() {
          showSpinner = false;
          error = true;
        });
      });
    }

    try {
      getLoc().then((value) {
        getStores().then((value) {
          setState(() {
            stores = value;
            showSpinner = false;
          });
        });
      }).catchError((e) {
        setState(() {
          showSpinner = false;
          error = true;
        });
      });
    } catch (e) {
      setState(() {
        showSpinner = false;
        error = true;
      });
    }
  }

  getToken() {
    _messaging.getToken().then((token) async {
      await _fireStore
          .collection('user_account_details')
          .document(userUid)
          .collection('Tokens')
          .document('token')
          .setData({
        'Token': token,
      });
    });
  }

  getLoc() async {
    userPos = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    placeMark = await Geolocator()
        .placemarkFromCoordinates(userPos.latitude, userPos.longitude);
    setState(() {
      userCurrentCity = placeMark[0].locality;
    });
  }

  getStoreDetails() async {
    //Getting the store's location
    final data = await Firestore.instance
        .collection('seller_list')
        .document(userUid)
        .get();
    print(seller.value);
    storeAddressCity.value = data.data['City'];
    storeAddressLine1.value = data.data['AddressLine1'];
    storeAddressLine2.value = data.data['AddressLine2'];
    storeAddressState.value = data.data['State'];
    storeAddressZip.value = data.data['ZipCode'];
    storeAddressName.value = data.data['Store Name'];
    storeOwnerPhoneNumber.value = data.data['OwnerPhoneNumber'];
    storeOwnerName.value = data.data['OwnerName'];
    storeOwnerEmail.value = data.data['OwnerEmail'];
    storeDescription.value = data.data['StoreDesc'];

    var sellerPos = await Geolocator().placemarkFromCoordinates(
        data.data['Position'].latitude, data.data['Position'].longitude);
    setState(() {
      storeCity.value = sellerPos[0].locality;
    });
  }

  getUserInfo() async {
    final detDoc = await Firestore.instance
        .collection('user_account_details')
        .document(userUid)
        .get();
    userFirstName.value = detDoc.data['FirstName'];
    userLastName.value = detDoc.data['LastName'];
    userEmail.value = detDoc.data['E-mail'];
    userPhoneNumber.value = detDoc.data['PhoneNumber'];
    userLine1.value = detDoc.data['Line 1'];
    userLine2.value = detDoc.data['Line 2'];
    userLandmark.value = detDoc.data['Landmark'];
    userCity.value = detDoc.data['City'];
    userState.value = detDoc.data['State'];
    userZip.value = detDoc.data['ZipCode'];
    if (userLine1.value == '') {
      userAddress.value = '...';
    } else if (userLine2.value == '') {
      userAddress.value = userLine1.value +
          ", " +
          userCity.value +
          ", " +
          userState.value +
          "-" +
          userZip.value;
    } else {
      userAddress.value = userLine1.value +
          ", " +
          userLine2.value +
          ", " +
          userCity.value +
          ", " +
          userState.value +
          "-" +
          userZip.value;
    }
  }

  getUid() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      userUid = user.uid;
    });
  }

  isSeller() async {
    final snap = await Firestore.instance
        .collection('seller_list')
        .document(userUid)
        .get();
    if (snap.data['IsApproved'] != null) {
      seller.value = true;
      isApproved.value = snap.data['IsApproved'];
      isStore.value = snap.data['IsStore'];
    }
  }

  getStores() async {
    final docs = await Firestore.instance
        .collection('sellers')
        .document(userCurrentCity)
        .collection('seller_info')
        .getDocuments();
    if (docs.documents.isNotEmpty) {
      for (int i = 0; i < docs.documents.length; i++) {
        if (docs.documents[i].data['IsApproved']) {
          final dist = await Geolocator().distanceBetween(
              userPos.latitude,
              userPos.longitude,
              docs.documents[i].data['Position'].latitude,
              docs.documents[i].data['Position'].longitude);
          if (dist < 1000) {
            final storeCard = StoreCard(
              sellerID: docs.documents[i].documentID,
              storeName: docs.documents[i].data['Store Name'],
              distance: dist.toStringAsFixed(2),
              isOpen: true, //IsOpen, just in case we decide to add the feature
//              storePhoneNumber: docs.documents[i].data['OwnerPhoneNumber'],
              storeDesc: docs.documents[i].data['StoreDesc'],
              position: LatLng(docs.documents[i].data['Position'].latitude,
                  docs.documents[i].data['Position'].longitude),
              isStore: docs.documents[i].data['IsStore'],
            );
            docs.documents[i].data['IsStore']
                ? store.add(storeCard)
                : householdBusinesses.add(storeCard);
            markers.add(Marker(
              markerId: MarkerId(docs.documents[i].data['Store Name']),
              infoWindow: InfoWindow(
                title: docs.documents[i].data['Store Name'],
                snippet: dist.toStringAsFixed(2) + "m📍",
              ),
              draggable: false,
              onTap: () {},
              position: LatLng(docs.documents[i].data['Position'].latitude,
                  docs.documents[i].data['Position'].longitude),
            ));
          }
        }
      }
    }
    storesGot = true;
    return store;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: error
          ? Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: 200,
                        alignment: Alignment.center,
                        child: Image.asset(
                          'images/Logo_SC_400.png',
                        )),
                    Text(
                      'Please check your internet connection and whether or not this app has permission to access your location.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(color: Colors.grey, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Settings ➡️Apps ➡️Permissions ➡️Location',
                      style: GoogleFonts.lato(color: Colors.grey, fontSize: 16),
                    ),
                    RaisedButton(
                      color: Colors.deepOrange[400],
                      child: Text(
                        'Try Again',
                        style:
                            GoogleFonts.lato(color: Colors.black, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, HomeScreen.id);
                      },
                    ),
                  ],
                ),
              ),
            )
          : Scaffold(
              backgroundColor: Colors.deepOrange[400],
              drawer: StdDrawer(
                isSeller: seller.value,
                markers: markers,
                ctx: context,
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
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: 15, right: 20, left: 20, bottom: 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Builder(
                            builder: (context) => GestureDetector(
                              child: Icon(
                                Icons.menu,
                                color: Colors.black,
                                size: 32,
                              ),
                              onTap: () => Scaffold.of(context).openDrawer(),
                            ),
                          ),
                          seller.value
                              ? Row(
                                  children: <Widget>[
                                    Builder(
                                      builder: (context) => GestureDetector(
                                        child: Icon(
                                          Icons.store,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return SellerOrderScreen();
                                          }));
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Builder(
                                      builder: (context) => GestureDetector(
                                        child: Icon(
                                          Icons.chat,
                                          color: Colors.black,
                                          size: 28,
                                        ),
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return SellerChatList();
                                          }));
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            margin: EdgeInsets.only(left: 20, right: 10),
                            decoration: BoxDecoration(
                              color: selectedIndex == 1
                                  ? Colors.white.withOpacity(0.4)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Stores',
                              style: GoogleFonts.lato(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 2;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 20, left: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: selectedIndex == 2
                                  ? Colors.white.withOpacity(0.4)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Household',
                              style: GoogleFonts.lato(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
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
                          selectedIndex == 1 ?? storesGot
                              ? (stores.length != 0)
                                  ? ListView.builder(
                                      itemCount: stores.length,
                                      itemBuilder: (context, index) {
                                        return stores[index];
                                      },
                                    )
                                  : Center(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 100, horizontal: 10),
                                        child: Text(
                                          'No stores near you',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.lato(
                                              color: Colors.grey,
                                              fontSize: 20,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    )
                              : Container(),
                          selectedIndex == 2 ?? storesGot
                              ? (householdBusinesses.length != 0)
                                  ? ListView.builder(
                                      itemCount: householdBusinesses.length,
                                      itemBuilder: (context, index) {
                                        return householdBusinesses[index];
                                      },
                                    )
                                  : Center(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 100, horizontal: 10),
                                        child: Text(
                                          'No household businesses near you',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.lato(
                                              color: Colors.grey,
                                              fontSize: 20,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class StoreCard extends StatefulWidget {
  //Display card fr items on the seller's side
  StoreCard(
      {this.storeName,
      this.distance,
      this.sellerID,
      this.isOpen,
      this.storePhoneNumber,
      this.position,
      this.isStore, this.storeDesc});
  final String storeName;
  final String distance;
  final String sellerID;
  final bool isOpen;
  final String storeDesc;
  final String storePhoneNumber;
  final LatLng position;
  final bool isStore;

  @override
  _StoreCardState createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  String imageUrl = '';
  bool noImage = false;

  getStoreImage() async {
    try {
      String url = await FirebaseStorage.instance
          .ref()
          .child('images/${widget.sellerID}.png')
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
    return GestureDetector(
      onTap: widget.isOpen
          ? () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return StoreDescScreen(
                  sellerUid: widget.sellerID,
                  storeName: widget.storeName,
                  imageUrl: imageUrl,
                  position: widget.position,
                  distance: widget.distance,
                  isStore: widget.isStore,
                  storeDesc: widget.storeDesc,
                );
              }));
            }
          : null,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: widget.isOpen ? Colors.white : Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  //spreadRadius: 3,
                  blurRadius: 5,
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'storeImage',
                    child: Container(
                      height: MediaQuery.of(context).size.width / 2.5,
                      width: MediaQuery.of(context).size.width / 2.5,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: noImage
                          ? Image.asset(
                              'images/default_item_image.png',
                              fit: BoxFit.fill,
                            )
                          : imageUrl == ''
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Loading(
                                    size: 60,
                                    indicator: BallScaleIndicator(),
                                    color: Colors.black,
                                  ),
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
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                        tag: 'storeName',
                        child: Text(
                          widget.storeName,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.distance + " m" + "📍",
                        style:
                            GoogleFonts.lato(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
//                      Text(
//                        'Ph: ' + widget.storePhoneNumber,
//                        style: GoogleFonts.lato(
//                            color: Colors.black54, fontSize: 14),
//                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          widget.isOpen
              ? Container()
              : Transform.rotate(
                  angle: -0.2,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black54, width: 1),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Text(
                        'Store Closed',
                        style: GoogleFonts.lato(
                            color: Colors.black54, fontSize: 25),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
