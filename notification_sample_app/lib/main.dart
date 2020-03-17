
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_sample_app/Questions.dart';
import 'package:notification_sample_app/TopicsScreen.dart';



void main() => runApp(NotificationHome());

class NotificationHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}


class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String fcmToken = "";
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();


  @override
  void initState() {
    super.initState();
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage called: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume called: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch called: $message');
      },
    );


    firebaseMessaging.getToken().then((token) {
      fcmToken = token;
      print("FCM-Token"+fcmToken);
    });
  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Notifications Sample App'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TopicsScreen(fcmToken: fcmToken,)));
              },
              child: Text('Fetch Topics'),
              ),
              RaisedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Question(fcmToken: fcmToken,)));
              },
                child: Text('Questions'),
              )

            ],
          ),
        ),
      ),
    );
  }
}

//Container(
//padding: const EdgeInsets.all(10.0),
//child: StreamBuilder<QuerySnapshot>(
//stream: Firestore.instance.collection('topics').snapshots(),
//builder: (BuildContext context,
//    AsyncSnapshot<QuerySnapshot> snapshot) {
//if (snapshot.hasError)
//return new Text('Error: ${snapshot.error}');
//switch (snapshot.connectionState) {
//case ConnectionState.waiting:
//return new Text('Loading...');
//default:
//return new ListView(
//children: snapshot.data.documents
//    .map((DocumentSnapshot document) {
//return GestureDetector(
//onTap: () async {
//ProjectUtils.showToast(document.documentID);
//
//print(fcmToken);
//
//String json =
//'{"topic_id": "${document.documentID}", "device_token": "$fcmToken"}';
//
//String url =
//'https://us-central1-notification-sample-bdb6a.cloudfunctions.net/subscribeToTopic';
//ProjectUtils.showToast(
//await ProjectUtils.fetchChannelStatus(
//json, url));
//},
//child: new ListTile(
//leading: Icon(Icons.track_changes),
//title: Text(document['name']),
//subtitle: Text(document.documentID),
//),
//);
//}).toList(),
//);
//}
//},
//))
