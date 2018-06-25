import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DevelopPage extends StatefulWidget {

  @override
  State createState() {
    return new DevelopPageState();
  }
}

class DevelopPageState extends State<DevelopPage> {

  FirebaseAnalytics analytics;
  FirebaseAnalyticsObserver analyticsObserver;
  FirebaseAuth firebaseAuth;
  GoogleSignIn googleSignIn;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new MaterialButton(
              onPressed: SendTestAnalyticsEvent,
              color: Colors.redAccent,
              child: new Text(
                  "Send test analytics event"
              ),
            ),
            new Padding(
                padding: new EdgeInsets.only(
                  bottom: 10.0
                )
            ),

            new MaterialButton(
                onPressed: SignInGoogleAccount,
                color: Colors.orange,
                child: new Text(
                  "Test google auth"
                ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.blueAccent,
    );
  }

  Future<Null> SignInGoogleAccount() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
    FirebaseUser firebaseUser = await firebaseAuth.signInWithGoogle(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken
    );

    print("sign in account: " + firebaseUser.email);

    FirebaseUser currentUser = await firebaseAuth.currentUser();
    assert(currentUser.uid == firebaseUser.uid);

  }

  Future<Null> SendTestAnalyticsEvent() async {
    await analytics.logEvent(
        name: 'test_event',
        parameters: <String, dynamic> {
          'string': 'string',
          'int': 42,
          'long': 123456789,
          'double': 43.0,
          'bool': true
        }
    );
    print("event sent successfully");
  }

  @override
  void initState() {
    super.initState();
    analytics = new FirebaseAnalytics();
    analyticsObserver = new FirebaseAnalyticsObserver(analytics: analytics);
    firebaseAuth = FirebaseAuth.instance;
    googleSignIn = new GoogleSignIn();
  }

  @override
  void dispose() {
    super.dispose();
  }
}