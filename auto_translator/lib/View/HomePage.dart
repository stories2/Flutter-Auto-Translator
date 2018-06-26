import 'package:flutter/material.dart';

import './CameraPage.dart';
import './TranslateHistoryPage.dart';
import './DevelopPage.dart';
import '../Model/PictureData.dart';

class HomePage extends StatefulWidget {

  @override
  State createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  TabController homeTabController;
  PictureData pictureData;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new TabBarView(
          controller: homeTabController,
          children: <Widget>[
            new CameraPage(homeTabController, pictureData),
            new TranslateHistoryPage(pictureData),
            new DevelopPage()
          ]
      ),
      bottomNavigationBar: new Material(
        color: Colors.redAccent,
        child: new TabBar(
            controller: homeTabController,
            tabs: <Tab>[
              new Tab(
                icon: new Icon(
                  Icons.camera
                ),
              ),
              new Tab(
                icon: new Icon(
                  Icons.history
                ),
              ),
              new Tab(
                icon: new Icon(
                  Icons.developer_mode
                ),
              )
            ]
        ),
      ),
      backgroundColor: Colors.green,
    );
  }

  @override
  void initState() {
    super.initState();
    homeTabController = new TabController(
        length: 3,
        vsync: this
    );
    setState(() {
      pictureData = new PictureData();
    });
  }

  @override
  void dispose() {
    homeTabController.dispose();
    super.dispose();
  }
}