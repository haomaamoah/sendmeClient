import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendmeClient/Database/file_utils.dart';
import 'package:sendmeClient/Database/models.dart';
import 'package:sendmeClient/Screens/EditAccount.dart';
import 'LoginScreen.dart';
import 'MapScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool displayMap = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FileUtils.readFromFile().then((data){
      if (data!=null){
        setState(() {
          displayMap = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/Icons/ic_animated_bg.png")
            )
        ),
        child: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              //Banner
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  height: MediaQuery.of(context).size.width*0.8,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/Icons/ic_get_start.png")
                      )
                  ),
                ),
              ),
              //Sec2
              Padding(
                padding: const EdgeInsets.only(top: 25,bottom: 40,right: 20,left: 20),
                child: Container(
                  child: Text(
                    "SEND★ME is an On demand\nDelivery/Trasportation service.",
                    style: TextStyle(
                      color: Color(0xFF787878),
                      fontSize: 17,
                      fontFamily: 'narrowmedium',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              //Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        height: 48,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              displayMap ? _MapRoute():_logInRoute()
                          );
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2)
                        ),
                        color: Colors.pink,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        elevation: 0,
                        highlightElevation: 0,
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: 'narrowmedium'
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  //_logInRoute
  Route _logInRoute() {
    return  PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => EditAccountScreen(),
      transitionDuration: Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve),);

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  //_logInRoute
  Route _MapRoute() {
    Errand errand;
    return  PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MapScreen(errand),
      transitionDuration: Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve),);

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

}
