import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../model/const.dart';
import 'LoginScreen.dart';


class WalkthroughScreen extends StatefulWidget {
  @override
  _WalkthroughScreenState createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {

  List pageInfos = [
    {
      "title": "Need A Delivery Rider?",
      "body": "You can SEND★ME with just a few clicks on your phone",
      "img": Constants.imageIndex["packageIntro"],
    },
    {
      "title": "Feeling Hungry?",
      "body": "Order breakfast to lunch for both"
          "local and international snacks and dishes",
      "img": Constants.imageIndex["foodIntro"],
    },
    {
      "title": "Feeling Sick?",
      "body": "Order medicine from accredited pharmacies and"
          "have it safely delivered to your doorstep",
      "img": Constants.imageIndex["medicineIntro"],
    },
    {
      "title": "Need Your Trash Taken?",
      "body": "Just SEND★ME by ordering on the app and"

          "it will taken in less than 48 hours",
      "img": Constants.imageIndex["trashIntro"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages = [
      for(int i = 0; i<pageInfos.length; i++)
        _buildPageModel(pageInfos[i])
    ];

    return WillPopScope(
      onWillPop: ()=>Future.value(false),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: IntroductionScreen(
            pages: pages,
            onDone: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context){
                    return LoginScreen();
                  },
                ),
              );
            },
            onSkip: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context){
                    return LoginScreen();
                  },
                ),
              );
            },
            showSkipButton: true,
            skip: Text("Skip"),
            next: Text(
              "Next",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).accentColor,
              ),
            ),
            done: Text(
              "Done",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildPageModel(Map item){
    return PageViewModel(
      title: item['title'],
      body: item['body'],
      image: Image.asset(
        item['img'],
        height: 185.0,
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).accentColor,
        ),
        bodyTextStyle: TextStyle(fontSize: 15.0),
//        dotsDecorator: DotsDecorator(
//          activeColor: Theme.of(context).accentColor,
//          activeSize: Size.fromRadius(8),
//        ),
        pageColor: Theme.of(context).primaryColor,
      ),
    );
  }
}