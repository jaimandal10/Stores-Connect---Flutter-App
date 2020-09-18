import 'package:flutter/material.dart';
import 'package:home_sell/screens/account_screen.dart';
import 'authservice.dart';


class StdAppBar extends StatefulWidget{
  @override
  _StdAppBarState createState() => _StdAppBarState();
}

class _StdAppBarState extends State<StdAppBar>{

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        '',
        style: TextStyle(color: Colors.black, fontSize: 24),
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.green,
      iconTheme: IconThemeData(color: Colors.white),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AccountScreen.id);
              },
              child: Icon(
                Icons.person,
                size: 26.0,
              ),
            )),
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: (){
              AuthService().signOut(context);
            },
            child: Icon(
              Icons.exit_to_app,
              size: 26,
            ),
          ),
        ),
      ],
    );
  }
}
