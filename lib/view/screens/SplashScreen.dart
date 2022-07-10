import 'dart:async';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sendmeClient/view/screens/WalkthroughScreen.dart';
import '../../model/const.dart';
import '../widgets/animations.dart';
import '../widgets/pageRoutes.dart';
import '../widgets/utils.dart';
import 'HomeScreen.dart';

class SplashScreen extends StatefulHookWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.black,Colors.red, Colors.pink,Colors.black],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  List<Color> colors = [Colors.pink,Colors.blue,Colors.amber,Colors.purple,Colors.green,Colors.indigo,Colors.red,Colors.orange,Colors.yellow];
  late Color color1,color2,color3,color4;
  late Timer timer;
  late List<Widget> deliveryOptions;
  Stream<ConnectivityResult> subscription = Connectivity().onConnectivityChanged;

  Future<void> checkIfUserIsLoggedIn()async{
    if (FirebaseAuth.instance.currentUser != null) {
      timer = Timer.periodic(Duration(seconds:1), (timer){
        if(timer.tick == 5){launchApp();timer.cancel();}
      });
    }
    else{
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.of(context).pushReplacement(BouncyPageRoute(widget: WalkthroughScreen()));
      });
    }
  }

  Future<void> launchApp () async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {Navigator.of(context).pushReplacement(FadePageRoute(widget: const NoInternet()));}
    else{
      Navigator.of(context).pushReplacement(BouncyPageRoute(widget: HomeScreen(null)));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    color1 = colors[Random().nextInt(9)];colors.remove(color1);
    color2 = colors[Random().nextInt(8)];colors.remove(color2);
    color3 = colors[Random().nextInt(7)];colors.remove(color3);
    color4 = colors[Random().nextInt(6)];
    deliveryOptions = [
      RotatingDeliveryOptionIcon(image: Constants.imageIndex["packageSplash"] as String, subtitle: 'Package',color: color1),
      RotatingDeliveryOptionIcon(image: Constants.imageIndex["foodSplash"] as String, subtitle: 'Food',color: color2),
      RotatingDeliveryOptionIcon(image: Constants.imageIndex["medicineSplash"] as String, subtitle: 'Medicine',color: color3),
      RotatingDeliveryOptionIcon(image: Constants.imageIndex["trashSplash"] as String, subtitle: 'Trash',color: color4),
    ];

    checkIfUserIsLoggedIn();


  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.8,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(Constants.imageIndex["backgroundSplash"] as String)
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    //Sec2
                    Padding(
                      padding: const EdgeInsets.only(top: 25,bottom: 30,right: 20,left: 20),
                      child: Column(
                        children: [
                          Text(
                            "SEND★ME",
                            style: TextStyle(
                                fontSize: 50,letterSpacing: 10,
                                fontFamily: 'narrowmedium',
                                foreground: Paint()..shader = linearGradient,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "\nMY",
                            style: TextStyle(
                              color: Color(0xFF787878),
                              fontSize: 25,
                              fontFamily: 'narrowmedium',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    //Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: deliveryOptions,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: AnimatedRiderLogo(),
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: copyrightBanner(),
          ),
        ],
      ),
    ));
  }
}


class NoInternet extends StatefulWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.satelliteDish,size: 100,color: Colors.red,),
            Divider(),
            Text(
              "\nNO INTERNET CONNECTION!\n",
              style: TextStyle(fontWeight: FontWeight.w800,color: Colors.brown,fontSize: 18),
            ),
            Divider(),
            Text(
              "Check your network or settings.",
              style: TextStyle(fontSize: 12,fontFamily: "Times New Roman"),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushReplacement(FadePageRoute(widget: SplashScreen()));
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(child: Text('TRY AGAIN',style: TextStyle(color: Colors.brown,fontFamily: "Times New Roman",fontWeight: FontWeight.w900,fontSize: 20),)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
