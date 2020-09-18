import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static const String id = 'privacy_policy_screen';

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
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: ListView(
                children: <Widget>[
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Stores Connect ',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.75),
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                '(“we” or “us” or “our”) respects the privacy of our users (“user” or “you”). This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you visit our mobile application (the “Application”).   Please read this Privacy Policy carefully.  IF YOU DO NOT AGREE WITH THE TERMS OF THIS PRIVACY POLICY, PLEASE DO NOT ACCESS THE APPLICATION.'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'We reserve the right to make changes to this Privacy Policy at any time and for any reason.  We will alert you about any changes by updating the “Last updated” date of this Privacy Policy.  You are encouraged to periodically review this Privacy Policy to stay informed of updates. You will be deemed to have been made aware of, will be subject to, and will be deemed to have accepted the changes in any revised Privacy Policy by your continued use of the Application after the date such revised Privacy Policy is posted.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'This Privacy Policy does not apply to the third-party online/mobile store from which you install the Application or make payments, including any in-game virtual items, which may also collect and use data about you.  We are not responsible for any of the data collected by any such third party.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'COLLECTION OF YOUR INFORMATION',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'We may collect information about you in a variety of ways.  The information we may collect via the Application depends on the content and materials you use, and includes: ',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Personal Data',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Demographic and other personally identifiable information (such as your name and email address) that you voluntarily give to us when choosing to participate in various activities related to the Application, such as chat, posting messages in comment sections or in our forums, liking posts, sending feedback, and responding to surveys.  If you choose to share data about yourself via your profile, online chat, or other interactive areas of the Application, please be advised that all data you disclose in these areas is public and your data will be accessible to anyone who accesses the Application.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Derivative Data',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Information our servers automatically collect when you access the Application, such as your native actions that are integral to the Application, including liking, re-blogging, or replying to a post, as well as other interactions with the Application and other users via server log files.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Financial Data',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Financial information, such as data related to your payment method (e.g. valid credit card number, card brand, expiration date) that we may collect when you purchase, order, return, exchange, or request information about our services from the Application. [We store only very limited, if any, financial information that we collect. Otherwise, all financial information is stored by our payment processor, Razorpay and you are encouraged to review their privacy policy and contact them directly for responses to your questions.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Google Account',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'In case you choose to sign in with Google, we may access your account’s information such as your name, email address and birthday.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Geolocation information',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'We may request access or permission to and track location-based information from your mobile device, either continuously or while you are using the Application, to provide location-based services. If you wish to change our access or permissions, you may do so in your device’s settings.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Mobile Device Access',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'We may request access or permission to certain features from your mobile device, including your mobile device’s [bluetooth, calendar, camera, contacts, microphone, reminders, sensors, SMS messages, social media accounts, storage,] and other features. If you wish to change our access or permissions, you may do so in your device’s settings.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Mobile Device Data',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Device information such as your mobile device ID number, model, and manufacturer, version of your operating system, phone number, country, location, and any other data you choose to provide.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Push Notifications',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'We may request to send you push notifications regarding your account or the Application. If you wish to opt-out from receiving these types of communications, you may turn them off in your device’s settings.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Third-Party Data',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Information from third parties, such as personal information or network friends, if you connect your account to the third party and grant the Application permission to access this information.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Data From Contests, Giveaways, and Surveys',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Personal and other information you may provide when entering contests or giveaways and/or responding to surveys.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'USE OF YOUR INFORMATION',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Having accurate information about you permits us to provide you with a smooth, efficient, and customized experience.  Specifically, we may use information collected about you via the Application to:',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  ListTile(
                    leading: Text(
                      '1.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Administer sweepstakes, promotions, and contests.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '2.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Assist law enforcement and respond to subpoena.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '3.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Compile anonymous statistical data and analysis for use internally or with third parties.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '4.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Create and manage your account.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '5.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Deliver targeted advertising, coupons, newsletters, and other information regarding promotions and the Application to you.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '6.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Email you regarding your account or order.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '7.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Enable user-to-user communications.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '8.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Fulfill and manage purchases, orders, payments, and other transactions related to the Application.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '9.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Generate a personal profile about you to make future visits to the Application more personalized.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '10.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Increase the efficiency and operation of the Application.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '11.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Monitor and analyze usage and trends to improve your experience with the Application.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '12.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Notify you of updates to the Application.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '13.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Offer new products, services, mobile applications, and/or recommendations to you.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '14.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Perform other business activities as needed.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '15.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Prevent fraudulent transactions, monitor against theft, and protect against criminal activity.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '16.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Process payments and refunds.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '17.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Request feedback and contact you about your use of the Application.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '18.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Resolve disputes and troubleshoot problems.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '19.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      ' Respond to product and customer service requests.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '20.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Send you a newsletter.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      '21.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                    title: Text(
                      'Solicit support for the Application.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'DISCLOSURE OF YOUR INFORMATION',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'We may share information we have collected about you in certain situations. Your information may be disclosed as follows:',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'By Law or to Protect Rights',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'If we believe the release of information about you is necessary to respond to legal process, to investigate or remedy potential violations of our policies, or to protect the rights, property, and safety of others, we may share your information as permitted or required by any applicable law, rule, or regulation.  This includes exchanging information with other entities for fraud protection and credit risk reduction.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Third-Party Service Providers',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'We may share your information with third parties that perform services for us or on our behalf, including payment processing, data analysis, email delivery, hosting services, customer service, and marketing assistance.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Marketing Communications',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'With your consent, or with an opportunity for you to withdraw consent, we may share your information with third parties for marketing purposes, as permitted by law.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Interactions with Other Users',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'If you interact with other users of the Application, those users may see your name, profile photo, and descriptions of your activity, including sending invitations to other users, chatting with other users, liking posts, following blogs.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Third-Party Advertisers',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'We may use third-party advertising companies to serve ads when you visit the Application. These companies may use information about your visits to the Application and other websites that are contained in web cookies in order to provide advertisements about goods and services of interest to you. ',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Social Media Contacts ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'If you connect to the Application through a social network, your contacts on the social network will see your name, profile photo, and descriptions of your activity.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Other Third Parties',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'We may share your information with advertisers and investors for the purpose of conducting general business analysis. We may also share your information with such third parties for marketing purposes, as permitted by law.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Sale or Bankruptcy',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'If we reorganize or sell all or a portion of our assets, undergo a merger, or are acquired by another entity, we may transfer your information to the successor entity.  If we go out of business or enter bankruptcy, your information would be an asset transferred or acquired by a third party.  You acknowledge that such transfers may occur and that the transferee may decline honor commitments we made in this Privacy Policy.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'We are not responsible for the actions of third parties with whom you share personal or sensitive data, and we have no authority to manage or control third-party solicitations.  If you no longer wish to receive correspondence, emails or other communications from third parties, you are responsible for contacting the third party directly.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'SECURITY OF YOUR INFORMATION',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'We use administrative, technical, and physical security measures to help protect your personal information.  While we have taken reasonable steps to secure the personal information you provide to us, please be aware that despite our efforts, no security measures are perfect or impenetrable, and no method of data transmission can be guaranteed against any interception or other type of misuse.  Any information disclosed online is vulnerable to interception and misuse by unauthorized parties.  Therefore, we cannot guarantee complete security if you provide personal information.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'POLICY FOR CHILDREN',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'We do not knowingly solicit information from or market to children under the age of 13. If you become aware of any data we have collected from children under age 13, please contact us using the contact information provided below.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'OPTIONS REGARDING YOUR INFORMATION',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Account Information',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'You may at any time review or change the information in your account or terminate your account by:',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.solidCircle, size: 12,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Resolve disputes and troubleshoot problems.',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.solidCircle, size: 12,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Contacting us using the contact information provided below',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Upon your request to terminate your account, we will deactivate or delete your account and information from our active databases. However, some information may be retained in our files to prevent fraud, troubleshoot problems, assist with any investigations, enforce our Terms of Use and/or comply with legal requirements.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Emails and Communications',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'If you no longer wish to receive correspondence, emails, or other communications from us, you may opt-out by:',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.solidCircle, size: 12,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Noting your preferences at the time you register your account with the Application',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.solidCircle, size: 12,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Logging into your account settings and updating your preferences',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.solidCircle, size: 12,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Contacting us using the contact information provided below',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75), fontSize: 12),
                    ),
                  ),
                  Text(
                    'If you no longer wish to receive correspondence, emails, or other communications from third parties, you are responsible for contacting the third party directly.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'CONTACT US',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'If you have questions or comments about this Privacy Policy, please contact us at:',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12),
                  ),
                  SizedBox(height: 15,),
                  Text(
                    'Stores Connect',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '+91 9845680592',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'help@storesconnect.in',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75), fontSize: 12, fontWeight: FontWeight.bold),
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
