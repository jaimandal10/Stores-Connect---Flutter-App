import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_sell/screens/seller_entry_screen.dart';

class StoreOrHousehold extends StatefulWidget {
  static const String id = 'store_or_household';

  @override
  _StoreOrHouseholdState createState() => _StoreOrHouseholdState();
}

class _StoreOrHouseholdState extends State<StoreOrHousehold> {
  bool isStore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Hi! If you\'d like to setup your online store for free, please fill in the details and we will get back to you shortly.',
                      style: GoogleFonts.lato(
                          color: Colors.deepOrange[400],
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Are you a store or a household business?',
                          style: GoogleFonts.lato(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          onTap: () {
                            setState(() {
                              isStore = true;
                            });
                          },
                          title: Text(
                            'Store',
                            style: GoogleFonts.openSans(
                                color: Colors.black, fontSize: 18),
                          ),
                          trailing: Icon(
                            isStore == true
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: Colors.deepOrange[400],
                          ),
                        ),
                        Divider(
                          height: 0,
                          color: Colors.grey,
                          indent: MediaQuery.of(context).size.width * 0.1,
                          endIndent: MediaQuery.of(context).size.width * 0.1,
                        ),
                        ListTile(
                          onTap: () {
                            setState(() {
                              isStore = false;
                            });
                          },
                          title: Text(
                            'Household',
                            style: GoogleFonts.openSans(
                                color: Colors.black, fontSize: 18),
                          ),
                          trailing: Icon(
                            isStore == false
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: Colors.deepOrange[400],
                          ),
                        ),
                      ],
                    ),
                    RaisedButton(
                      elevation: 10,
                      onPressed: isStore!=null?() {
                        print(isStore);
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SellerEntryScreen(
                            isStore: isStore,
                          );
                        }));
                      }:null,
                      child: Text(
                        'Next',
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      color: Colors.deepOrange[400],
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
