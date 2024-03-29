import 'package:flutter/material.dart';
import 'package:sendmeClient/Database/file_utils.dart';
import 'package:sendmeClient/Database/models.dart';
import 'package:sendmeClient/Screens/ChangePasswordDrawerScreen.dart';
import 'package:sendmeClient/Screens/HomePage.dart';
import 'package:sendmeClient/Screens/SettingScreen.dart';

import 'ChangePasswordScreen.dart';
import 'EditAccount.dart';
import 'OrderHistoryScreen.dart';
import 'PaymentMethodScreen.dart';
import 'MapScreen.dart';
class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var myfile;
  Users user ;Errand errand;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FileUtils.readFromFile().then((data){
      if (data!=null){
        List<String> info = data.split('||');
        setState(() {
          user = Users(info[0], info[1], info[2], info[3], info[4], null);
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.6,
      child: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              //Drawer Header
              Container(
                height: MediaQuery.of(context).size.height*0.3-55,
                padding: EdgeInsets.only(top: 70,left: 15,right: 20),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 62,
                      width: 65,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/Icons/ic_profile.png",)
                          )
                      ),

                    ),
                    SizedBox(width: 12,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.2,
                      child: Text(user.uname,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'narrowmedium',
                        ),),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 30,right: 20),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      //Home
                      InkWell(
                        onTap: (){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (context)=>MapScreen( errand)
                          ), (route) => false);
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Container(
                          height: 50,
                          child:  Row(
                            children: <Widget>[
                              Container(
                                child: Image.asset("assets/Icons/ic_home.png",width: 22,),
                              ),
                              SizedBox(width: 16,),
                              Container(
                                child: Text("Home",
                                  style: TextStyle(
                                    color: Color(0xFF787878),
                                    fontSize: 12,
                                    fontFamily: 'narrowmedium',
                                  ),),
                              )
                            ],
                          ),
                        ),
                      ),
                      //Payment Method
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                          Navigator.of(context).push(_paymentMethidScreenRoute());
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Container(
                          height: 50,
                          child:  Row(
                            children: <Widget>[
                              Container(
                                child: Image.asset("assets/Icons/ic_payment.png",width: 22,),
                              ),
                              SizedBox(width: 16,),
                              Container(
                                child: Text("Payment Method",
                                  style: TextStyle(
                                    color: Color(0xFF787878),
                                    fontSize: 12,
                                    fontFamily: 'narrowmedium',
                                  ),),
                              )
                            ],
                          ),
                        ),
                      ),
                      //History
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                           Navigator.of(context).push(_historyScreenRoute());
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Container(
                          height: 50,
                          child:  Row(
                            children: <Widget>[
                              Container(
                                child: Image.asset("assets/Icons/ic_history.png",width: 22,),
                              ),
                              SizedBox(width: 16,),
                              Container(
                                child: Text("History",
                                  style: TextStyle(
                                    color: Color(0xFF787878),
                                      fontSize: 12,
                                      fontFamily: 'narrowmedium',
                                  ),),
                              )
                            ],
                          ),
                        ),
                      ),
                      //Profile
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                          Navigator.of(context).push(_profileScreenRoute());
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child:Container(
                          height: 50,
                          child:  Row(
                            children: <Widget>[
                              Container(
                                child: Image.asset("assets/Icons/ic_user1.png",width: 22,),
                              ),
                              SizedBox(width: 16,),
                              Container(
                                child: Text("Profile",
                                  style: TextStyle(
                                    color: Color(0xFF787878),
                                      fontSize: 12,
                                      fontFamily: 'narrowmedium',
                                  ),),
                              )
                            ],
                          ),
                        ),
                      ),
                      //Change Password
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                          Navigator.of(context).push(_changePasswordScreenRoute());
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Container(
                          height: 50,
                          child:  Row(
                            children: <Widget>[
                              Container(
                                child: Image.asset("assets/Icons/ic_lock.png",width: 22,),
                              ),
                              SizedBox(width: 16,),
                              Container(
                                child: Text("Change Password",
                                  style: TextStyle(
                                    color: Color(0xFF787878),
                                      fontSize: 12,
                                      fontFamily: 'narrowmedium',
                                  ),),
                              )
                            ],
                          ),
                        ),
                      ),
                      //Setting
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                          Navigator.of(context).push(_SettingScreenRoute());
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Container(
                          height: 50,
                          child:  Row(
                            children: <Widget>[
                              Container(
                                child: Image.asset("assets/Icons/ic_setting.png",width: 22,),
                              ),
                              SizedBox(width: 16,),
                              Container(
                                child: Text("Settings",
                                  style: TextStyle(
                                    color: Color(0xFF787878),
                                    fontSize: 12,
                                    fontFamily: 'narrowmedium',
                                  ),),
                              )
                            ],
                          ),
                        ),
                      ),
                      //Logout
                      InkWell(
                        onTap: (){
                          logOutPopup();
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Container(
                          height: 50,
                          child:  Row(
                            children: <Widget>[
                              Container(
                                child: Image.asset("assets/Icons/ic_logout.png",width: 22,),
                              ),
                              SizedBox(width: 16,),
                              Container(
                                child: Text("Logout",
                                  style: TextStyle(
                                    color: Color(0xFF787878),
                                      fontSize: 12,
                                      fontFamily: 'narrowmedium',
                                  ),),
                              )
                            ],
                          ),
                        ),
                      ),

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 100,
                              alignment: Alignment.center,
                              child: Text("v3.39.0",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 11,
                                  fontFamily: 'narrowmedium',
                              ),),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //_historyScreenRoute
  Route _historyScreenRoute() {
    return  PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => OrderHistoryScreen(),
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

  //_paymentMethidScreenRoute
  Route _paymentMethidScreenRoute() {
    return  PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PaymentMethodScreen(),
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

  //_profileScreenRoute
  Route _profileScreenRoute() {
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

  //_changePasswordScreenRoute
  Route _changePasswordScreenRoute() {
    return  PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ChangePasswordDrawerScreen(),
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

  //_SettingScreenRoute
  Route _SettingScreenRoute() {
    return  PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SettingsScreen(),
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

  void logOutPopup() {
    showDialog(
        context: context,
        builder: (context){
          return StatefulBuilder(builder: (context,setState){
            return  Dialog(
              child: Container(
                height: 152,
                padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 0),
                          alignment: Alignment.centerLeft,
                          child: Text("Logout Status",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: 'narrowmedium',
                            ),),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 8),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Are you sure to want logout ?",
                            style: TextStyle(
                              color: Color(0xFF787878),
                              fontSize: 13,
                              fontFamily: "narrowmedium",
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                              child: Text(
                                "NO",
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 15,
                                  fontFamily: "narrowmedium",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          InkWell(
                            onTap: (){
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                  builder: (context)=>HomePage()
                              ), (route) => false);
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                              child: Text(
                                "YES",
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 15,
                                  fontFamily: "narrowmedium",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        }
    );
  }
}
