// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:rate_my_app/rate_my_app.dart';
//
// /// Main Rate my app instance.
// RateMyApp _rateMyApp = RateMyApp(
//   preferencesPrefix: 'rateMyApp_',
//   minDays: 7,
//   minLaunches: 10,
//   remindDays: 7,
//   remindLaunches: 10,
//   // appStoreIdentifier: '',
//   // googlePlayIdentifier: '',
// );
//
// class rating extends StatefulWidget {
//   @override
//   _ratingState createState() => _ratingState();
// }
//
// class _ratingState extends State<rating> {
//   @override
//   void initState() {
//     super.initState();
//     _rateMyApp.init().then((_) {
//       _rateMyApp.conditions.forEach((condition) {
//         if (condition is DebuggableCondition) {
//           //print(condition.valuesAsString());
//           // We iterate through our list of conditions and we print all debuggable ones.
//         }
//       });
//
//       print('Are all conditions met ? ' +
//           (_rateMyApp.shouldOpenDialog ? 'Yes' : 'No'));
//
//       if (_rateMyApp.shouldOpenDialog) _buildShowStarRateDialog(context);
//     });
//   }
//
//   _buildShowStarRateDialog(BuildContext context) {
//     _rateMyApp.showStarRateDialog(context, actionsBuilder: (_, count) {
//       final Widget cancelButton = RateMyAppNoButton(
//         // We create a custom "Cancel" button using the RateMyAppNoButton class.
//         _rateMyApp,
//         text: 'CANCEL',
//         callback: () => setState(() {}),
//       );
//       if (count == null || count == 0) {
//         // If there is no rating (or a 0 star rating), we only have to return our cancel button.
//         return [cancelButton];
//       }
//
//       // Otherwise we can do some little more things...
//       String message = 'You\'ve put ' + count.round().toString() + ' star(s). ';
//       Color color;
//       switch (count.round()) {
//         case 1:
//           message += 'Did this app hurt you physically ?';
//           color = Colors.red;
//           break;
//         case 2:
//           message += 'That\'s not really cool man.';
//           color = Colors.orange;
//           break;
//         case 3:
//           message += 'Well, it\'s average.';
//           color = Colors.yellow;
//           break;
//         case 4:
//           message += 'This is cool, like this app.';
//           color = Colors.lime;
//           break;
//         case 5:
//           message += 'Great ! <3';
//           color = Colors.green;
//           break;
//       }
//
//       return [
//         FlatButton(
//           child: const Text('OK'),
//           onPressed: () async {
//             print(message);
//             //Toast.show(message, context,
//               //  duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
//
//             // This allow to mimic a click on the default "Rate" button and thus update the conditions based on it ("Do not open again" condition for example) :
//             await _rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
//             Navigator.pop<RateMyAppDialogButton>(
//                 context, RateMyAppDialogButton.rate);
//
//             setState(() {});
//           },
//         ),
//         cancelButton,
//       ];
//     });
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Rating"),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ReachUs extends StatefulWidget {
  @override
  _ReachUsState createState() => _ReachUsState();
}

class _ReachUsState extends State<ReachUs> {
  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLMail() async {
    const url =
        'mailto:smith@example.org?subject=LifePlusApp&body=Your sugestions%20or Feedback..';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  String name;
  String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Reach Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 14.0, horizontal: 13),
              child: Text(
                "Leave us a message, and we'll get in contact with you as soon as possible.",
                style: TextStyle(
                  fontSize: 17.5,
                  height: 1.3,
                  fontFamily: 'RobotoSlab',
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (val) {
                  if (val != null || val.length > 0) name = val;
                },
                controller: t1,
                decoration: InputDecoration(
                  fillColor: Color(0xffe6e6e6),
                  filled: true,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: 'Your name',
                  hintStyle: TextStyle(
                      color: Colors.blueGrey, fontFamily: 'RobotoSlab'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0001,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (val) {
                  if (val != null || val.length > 0) message = val;
                },
                textAlign: TextAlign.start,
                controller: t2,
                decoration: InputDecoration(
                  fillColor: Color(0xffe6e6e6),
                  filled: true,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                  hintText: 'Your message',
                  hintStyle: TextStyle(
                    color: Colors.blueGrey,
                    fontFamily: 'RobotoSlab',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(17),
                    ),
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(17),
                    ),
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(17),
                    ),
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Card(
              color: Colors.green[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    t1.clear();
                    t2.clear();
                    launchUrl(
                        "mailto:avadheshnasit1@gmail.com?subject=From $name&body=$message");
                  });
                },
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Center(
                          child: Text(
                            "Send",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'RobotoSlab'),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: 21,
                  right: 21,
                  bottom: MediaQuery.of(context).size.height * 0.034),
              child: Text(
                "Alternatively, you can also report bugs and errors on following platforms",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  color: Colors.blueGrey[600],
                  fontSize: 17,
                  height: 1.3,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () => launchUrl(
                      "https://github.com/shivamkapasia0/lifeplusapp"),
                  child: Icon(
                    FontAwesomeIcons.github,
                    color: Colors.orange,
                    size: 35,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                GestureDetector(
                  onTap: () => launchUrl(
                      "https://play.google.com/store/apps/details?id=com.lifeplusapp&hl=en_IN"),
                  child: Icon(FontAwesomeIcons.googlePlay,
                      color: Color(0xfffb3958), size: 35),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                GestureDetector(
                  onTap: () => _launchURLMail(),
                  child: Icon(FontAwesomeIcons.at,
                      color: Color(0xff1DA1F2), size: 35),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class Rating {
  const Rating({@required this.UserId, this.rating});

  final String UserId;
  final double rating;

  factory Rating.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    if (name == null) {
      return null;
    }
    final double rating = data['rating'];
    return Rating(
      UserId: documentId,
      rating: rating,
    );
  }
}