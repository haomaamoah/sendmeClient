import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sendmeClient/view/widgets/animations.dart';
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
          " local and international snacks and dishes",
      "img": Constants.imageIndex["foodIntro"],
    },
    {
      "title": "Feeling Sick?",
      "body": "Order medicine from accredited pharmacies and"
          " have it safely delivered to your doorstep",
      "img": Constants.imageIndex["medicineIntro"],
    },
    {
      "title": "Need Your Trash Taken?",
      "body": "Just SEND★ME by ordering on the app and"
          " it will be taken in less than 48 hours",
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
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(Constants.imageIndex["backgroundSplash"] as String)
              )
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: IntroductionScreen(
              globalBackgroundColor: Colors.transparent,
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
        )
      ),
    );
  }

  _buildPageModel(Map item){
    return PageViewModel(
      titleWidget: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              WavyAnimatedText(
                item['title'],
                textStyle: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).accentColor,
                )
              )
            ]
        ),
      ),
      body: item['body'],
      image: BreathingLogo(image: item['img'],size: MediaQuery.of(context).size.width*0.7,),
      decoration: PageDecoration(
        bodyTextStyle: TextStyle(
            fontSize: 22.0,fontWeight: FontWeight.w500,
            fontFamily: "narrowmeduim",letterSpacing: 2),
//        dotsDecorator: DotsDecorator(
//          activeColor: Theme.of(context).accentColor,
//          activeSize: Size.fromRadius(8),
//        ),
        pageColor: Colors.transparent,
      ),
    );
  }
}