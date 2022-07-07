import 'dart:math';
import 'package:flutter/material.dart';
import '../../model/const.dart';
import '../../model/file_utils.dart';
import '../widgets/animations.dart';
import '../widgets/utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  bool displayHome = false;
  late AnimationController breathingController,rotationController;
  double breathingValue = 0;
  List<Color> colors = [Colors.pink,Colors.blue,Colors.amber,Colors.purple,Colors.green,Colors.indigo,Colors.red,Colors.orange,Colors.yellow];
  late Color color1,color2,color3,color4;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FileUtils.readFromFile().then( (data){
      if (data!=null){
        setState(() {
          displayHome = true;
        });
      }
    });
    breathingController = AnimationController(vsync: this, duration: Duration(seconds: 1))
      ..addStatusListener((status) {
      switch (status){
        case AnimationStatus.dismissed:
          breathingController.forward();
          break;
        case AnimationStatus.completed:
          breathingController.reverse();
          break;
        case AnimationStatus.forward: break;
        case AnimationStatus.reverse: break;
      }
    })
    ..addStatusListener((status)=>setState(()=>breathingValue = breathingController.value));
    breathingController.forward();
    rotationController = AnimationController(vsync: this,duration: Duration(seconds: 10));
    rotationController.repeat();
    color1 = colors[Random().nextInt(9)];colors.remove(color1);
    color2 = colors[Random().nextInt(8)];colors.remove(color2);
    color3 = colors[Random().nextInt(7)];colors.remove(color3);
    color4 = colors[Random().nextInt(6)];


  }

  @override
  void dispose() {
    breathingController.dispose();
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double riderImageSize = MediaQuery.of(context).size.width*0.6 - 5 * breathingValue;
    final Shader linearGradient = LinearGradient(
      colors: <Color>[Colors.black,Colors.red, Colors.pink,Colors.black],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

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
                        children: [
                          rotatingDeliveryOption(controller: rotationController, image: Constants.imageIndex["packageSplash"] as String, subtitle: 'Package',color: color1),
                          rotatingDeliveryOption(controller: rotationController, image: Constants.imageIndex["foodSplash"] as String, subtitle: 'Food',color: color2),
                          rotatingDeliveryOption(controller: rotationController, image: Constants.imageIndex["medicineSplash"] as String, subtitle: 'Medicine',color: color3),
                          rotatingDeliveryOption(controller: rotationController, image: Constants.imageIndex["trashSplash"] as String, subtitle: 'Trash',color: color4),
                        ],
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
              child: animatedRiderLogo(animatedRiderSize: MediaQuery.of(context).size.width*0.8,riderImageSize: riderImageSize),
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
