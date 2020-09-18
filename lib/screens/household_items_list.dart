import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_sell/screens/home_screen.dart';

import '../constants.dart';

class HouseholdItemsList extends StatefulWidget {
  static const String id = 'household_items_list';

  @override
  _HouseholdItemsListState createState() => _HouseholdItemsListState();
}

class _HouseholdItemsListState extends State<HouseholdItemsList> {
  String item;
  TextEditingController _itemController = TextEditingController();
  bool _itemValidate = false;
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
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.3, vertical: 10),
        height: MediaQuery.of(context).size.width * .12,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          onPressed: () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Add Item',
                      style:
                          GoogleFonts.lato(color: Colors.black54, fontSize: 18),
                    ),
                    content: StatefulBuilder(
                      builder: (context, setState) {
                        return SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: TextField(
                                  controller: _itemController,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  cursorColor: Colors.black,
                                  textAlign: TextAlign.start,
                                  onChanged: (value) {
                                    item = value;
                                  },
                                  decoration: kTxtFld.copyWith(
                                    errorText: _itemValidate
                                        ? 'Can\'t be empty'
                                        : null,
                                    hintText: '',
                                    labelText: 'Item Name',
                                    labelStyle: GoogleFonts.lato(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        height: 0),
                                    alignLabelWithHint: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    actions: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            _itemValidate = _itemController.text.isEmpty;
                          });
                          if (!_itemValidate) {
                            _fireStore
                                .collection('sellers')
                                .document(storeCity.value)
                                .collection('seller_info')
                                .document(userUid)
                                .collection('items')
                                .document(item)
                                .setData({
                              'TimeStamp': DateTime.now().toString(),
                            });
                            _itemController.clear();
                            Navigator.of(context).pop();
                          } else {
                            setState(() {
                              _itemValidate = true;
                            });
                          }
                        },
                        color: Colors.red[700],
                        child: Text(
                          'Add',
                          style: GoogleFonts.lato(
                              color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  );
                });
          },
          color: Colors.deepOrange[400],
          child: Text(
            'Add Item',
            style: GoogleFonts.lato(color: Colors.white, fontSize: 16),
            softWrap: true,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  'Items Sold',
                  style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Note: You are not restricted to selling the items on this list only. This list is to only give buyers an idea of what you might be selling.',
                style: GoogleFonts.lato(
                    color: Colors.black54,
                    fontSize: 14,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: _fireStore
                    .collection('sellers')
                    .document(storeCity.value)
                    .collection('seller_info')
                    .document(userUid)
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
                  for (var item in items) {
                    itemWidgets.add(ListTile(
                      title: Text(
                        item.documentID,
                        style: GoogleFonts.lato(color: Colors.black.withOpacity(0.7), fontSize: 20, fontStyle: FontStyle.italic),
                      ),
                      leading: Icon(FontAwesomeIcons.angleRight, color: Colors.deepOrange[400],),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: (){
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context){
                              return AlertDialog(
                                title: Text(
                                  'Confirm',
                                  style: GoogleFonts.lato(color: Colors.black87, fontSize: 18),
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(
                                        'Please confirm if you\'d like to delete the item.',
                                        style: GoogleFonts.lato(color: Colors.black54, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  RaisedButton(
                                    onPressed: (){
                                      item.reference.delete();
                                      Navigator.of(context).pop();
                                    },
                                    color: Colors.red[700],
                                    child: Text(
                                      'Confirm',
                                      style: GoogleFonts.lato(color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                ],
                              );
                            }
                          );
                        },
                      ),
                    ));
                  }

                  return Expanded(
                    child: itemWidgets.length == 0
                        ? Container(
                            child: Text(
                              'Add a few items to let buyers know what kind of amazing things you\'re selling',
                              style: GoogleFonts.lato(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Center(
                          child: ListView(
                            shrinkWrap: true,
                              children: itemWidgets,
                            ),
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
