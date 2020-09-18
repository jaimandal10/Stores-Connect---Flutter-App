import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_sell/screens/about_screen.dart';
import 'package:home_sell/screens/account_screen.dart';
import 'package:home_sell/screens/add_delivery_address_screen.dart';
import 'package:home_sell/screens/buyer_orders_screen.dart';
import 'package:home_sell/screens/contatc_us_screen.dart';
import 'package:home_sell/screens/edit_address_screen.dart';
import 'package:home_sell/screens/faq_screen.dart';
import 'package:home_sell/screens/home_screen.dart';
import 'package:home_sell/screens/household_items_list.dart';
import 'package:home_sell/screens/location_screen.dart';
import 'package:home_sell/screens/order_placed_screen.dart';
import 'package:home_sell/screens/privacy_policy_screen.dart';
import 'package:home_sell/screens/seller_approval_pending_screen.dart';
import 'package:home_sell/screens/seller_completed_orders_screen.dart';
import 'package:home_sell/screens/seller_edit_address_screen.dart';
import 'package:home_sell/screens/seller_orders_screen.dart';
import 'package:home_sell/screens/entry_screen.dart';
import 'package:home_sell/screens/seller_profile_screen.dart';
import 'package:home_sell/screens/store_desc_screen.dart';
import 'package:home_sell/screens/store_or_household.dart';
import 'package:home_sell/utilities/authservice.dart';
import 'package:home_sell/screens/edit_account_details_screen.dart';
import 'package:home_sell/screens/seller_entry_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    runApp(HomeSell());
  });
}

class HomeSell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stores Connect',
      theme: ThemeData(
        primaryColor: Colors.deepOrange[400],
        accentColor: Colors.black,
      ),
      home: AuthService().handleAuth(),                           //Defining the first page that pops up
      routes:{                                               //Defining routes to all the screens
        AboutScreen.id:(context)=>AboutScreen(),
        AccountScreen.id:(context)=>AccountScreen(),
        AddDeliveryAddressScreen.id:(context)=>AddDeliveryAddressScreen(),
        HomeScreen.id:(context)=>HomeScreen(),
        LocationScreen.id:(context)=>LocationScreen(),
        EntryScreen.id:(context)=>EntryScreen(),
        EditAccount.id:(context)=>EditAccount(),
        EditAddressScreen.id:(context)=>EditAddressScreen(),
        SellerEntryScreen.id:(context)=>SellerEntryScreen(),
        SellerOrderScreen.id:(context)=>SellerOrderScreen(),
        OrderPlacedScreen.id: (context)=>OrderPlacedScreen(),
        BuyerOrdersScreen.id: (context)=>BuyerOrdersScreen(),
        SellerEditAddressScreen.id: (context)=> SellerEditAddressScreen(),
        SellerApprovalPendingScreen.id: (context)=> SellerApprovalPendingScreen(),
        SellerCompletedOrdersScreen.id: (context)=> SellerCompletedOrdersScreen(),
        ContactUsScreen.id: (context)=> ContactUsScreen(),
        FAQScreen.id: (context)=> FAQScreen(),
        StoreDescScreen.id: (context)=> StoreDescScreen(),
        SellerProfileScreen.id: (context)=> SellerProfileScreen(),
        StoreOrHousehold.id: (context)=> StoreOrHousehold(),
        HouseholdItemsList.id: (context)=> HouseholdItemsList(),
        PrivacyPolicyScreen.id: (context)=> PrivacyPolicyScreen(),
      }
    );
  }
}
