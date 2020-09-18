import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQScreen extends StatefulWidget {
  static const String id='faq_screen';
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
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
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              //side: BorderSide(color: Colors.deepOrange[400], width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: ListView(
                children: <Widget>[
                  Text(
                    'FAQs',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(color: Colors.black,fontSize: 24),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'How do I set up my own online store?',
                    softWrap: true,
                    style: GoogleFonts.lato(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5,),
                  RichText(
                  text: TextSpan(
                    style: GoogleFonts.lato(color: Colors.deepOrange[400],fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(text: 'To be a seller, please click on the '),
                      TextSpan(text: 'Want To Sell',style: GoogleFonts.lato(color: Colors.deepOrange[400],fontSize: 16,fontStyle: FontStyle.italic),),
                      TextSpan(text: ' option in the menu present in the home screen. Answer a few questions about your business and we\'ll get back to you.'),
                    ],
                  ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'What are the available payment options?',
                    softWrap: true,
                    style: GoogleFonts.lato(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    'Payments can be made with cash at the time of receiving the order, or can be made before hand through the app. The payment gateway is completely secure and provides various payment options inlcuding credit and debit cards and UPI.',
                    style: GoogleFonts.lato(color: Colors.deepOrange[400],fontSize: 16,),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'What if I want to return/exchange something from my order?',
                    softWrap: true,
                    style: GoogleFonts.lato(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    'If you wish to exchange/return any item you purchased, you will need to message the store and discuss the matter with them. If you\'re not satissfied, please feel free to contact us.',
                    style: GoogleFonts.lato(color: Colors.deepOrange[400],fontSize: 16,),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'How quickly can I expect my deliveries?',
                    softWrap: true,
                    style: GoogleFonts.lato(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    'Our delivery boys will be present in the locality to fulfill the deliveries. So, rest assured, you will receive your order in the shortest times possible.',
                    style: GoogleFonts.lato(color: Colors.deepOrange[400],fontSize: 16,),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Where can I view my past orders?',
                    softWrap: true,
                    style: GoogleFonts.lato(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    'You can view your past orders from the menu in the home screen, or from your account.',
                    style: GoogleFonts.lato(color: Colors.deepOrange[400],fontSize: 16,),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Can I view a store\'s location?',
                    softWrap: true,
                    style: GoogleFonts.lato(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    'Yes, you can view the location of all the stores on the map. You can visit the map from the menu or from the bottom navigation bar. The location of each store is also displayed on the screen after clicking on them.',
                    style: GoogleFonts.lato(color: Colors.deepOrange[400],fontSize: 16,),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'I\'m a household business on the app. Can I sell items other than those I\'ve listed?',
                    softWrap: true,
                    style: GoogleFonts.lato(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    'Yes, you can sell items other than the ones you\'ve listed. The listed items are to give the buyer an idea of what you sell.',
                    style: GoogleFonts.lato(color: Colors.deepOrange[400],fontSize: 16,),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'I\'m a seller on the app. Where can I view my ongoing orders?',
                    softWrap: true,
                    style: GoogleFonts.lato(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    'You can view your ongoing orders from your seller\'s account or from the second icon from the right on the top right corner of the home screen.',
                    style: GoogleFonts.lato(color: Colors.deepOrange[400],fontSize: 16,),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'I\'m a seller on the app. Where can I view my completed orders?',
                    softWrap: true,
                    style: GoogleFonts.lato(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    'You can view your completed orders from your seller\'s account. The seller\'s account can be accessed from the menu on the home screen.',
                    style: GoogleFonts.lato(color: Colors.deepOrange[400],fontSize: 16,),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'I\'m a seller on the app. Where can I view my chats?',
                    softWrap: true,
                    style: GoogleFonts.lato(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    'You can view your chats from the first icon from the right on the top right corner of the home screen or from the top icon on the top right corner of your seller\'s account.',
                    style: GoogleFonts.lato(color: Colors.deepOrange[400],fontSize: 16,),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'I\'m a seller on the app. How do I request buyers for money?',
                    softWrap: true,
                    style: GoogleFonts.lato(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    'Seller\'s chats have an extra section above the messaging section. Just enter the amount and hit request. A message asking the users for money will be sent and the user will be able to make the payment.',
                    style: GoogleFonts.lato(color: Colors.deepOrange[400],fontSize: 16,),
                  ),
                  SizedBox(height: 20,),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style:
                      GoogleFonts.abel(color: Colors.black, fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Stores',
                            style: GoogleFonts.abel(
                                color: Colors.deepOrange[400])),
                        TextSpan(
                          text: ' Connect',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
