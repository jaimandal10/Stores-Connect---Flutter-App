import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_sell/screens/chat_screen.dart';
import 'package:home_sell/screens/home_screen.dart';
import 'package:intl/intl.dart';

class SellerChatList extends StatefulWidget {
  @override
  _SellerChatListState createState() => _SellerChatListState();
}

class _SellerChatListState extends State<SellerChatList> {
  var _fireStore = Firestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: _fireStore
                  .collection('sellers')
                  .document(storeCity.value)
                  .collection('seller_info')
                  .document(userUid)
                  .collection('chats')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                      Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.black54,
                        ),
                      ),
                    ],
                  );
                }

                final chats = snapshot.data.documents;
                List<Widget> chatWidgets = [];

                for (var chat in chats) {
                  final time = chat.data['RecentTimeStamp'].split(" ")[1];
                  final date = chat.data['RecentTimeStamp'].split(" ")[0];

//                  final dateFormatter = new DateFormat('yyyy-MM-dd');
//                  final timeFormatter = new DateFormat('HH:mm:ss');
//
//                  final formattedTime = timeFormatter.format(time);
//                  final formattedDate = dateFormatter.format(date);

                  final chatWidget = ChatTile(
                    time: time,
                    buyerUid: chat.documentID,
                    buyerName: chat.data['Name'],
                    date: date,
                  );
                  chatWidgets.add(chatWidget);
                }

                return Expanded(
                  child: ListView(
                    children: chatWidgets,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  ChatTile({this.time, this.buyerUid, this.buyerName, this.date});

  final String time;
  final String buyerUid;
  final String buyerName;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChatScreen(
                isSeller: true,
                buyerUid: buyerUid,
                buyerName: buyerName,
              );
            }));
          },
          child: ListTile(
            title: Text(
              buyerName,
              style: GoogleFonts.lato(color: Colors.black),
            ),
            subtitle: Text(
              date,
              style: GoogleFonts.lato(color: Colors.deepOrange[400]),
            ),
            trailing: Icon(
              Icons.chat_bubble_outline,
              color: Colors.deepOrange[400],
            ),
          ),
        ),
        Divider(
          indent: 25,
          endIndent: 25,
          color: Colors.grey,
          height: 8,
        ),
      ],
    );
  }
}
