import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/file_utils.dart';
import '../../model/models.dart';
import 'BirthdayScreen.dart';
import 'SplashScreen.dart';
import 'SelectCountryScreen.dart';
import 'HomeScreen.dart';

class EditAccountScreen extends StatefulWidget {
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  String? initlVal;
  bool isPicture= false;
  File? imageFile;
  openGallery() async{

   var picture = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
   setState(() {
     imageFile = picture as File?;
     isPicture =true;
   });
  }
 bool isEdit=false;
  edtbtn(){
     setState(() {
       isEdit = true;
     });
  }
  bool editUserName = false;
  bool editUserNameVisbility = true;

  TextEditingController fnameCtrl = TextEditingController();
  TextEditingController lnameCtrl = TextEditingController();
  TextEditingController unameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController bdayCtrl = TextEditingController();

  String countryCtrl = "Click to choose..";

  final GlobalKey<ScaffoldState> mainDrawerKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Users? user ;Errand? errand;
        FileUtils.readFromFile().then((data){
          if (data!=null){
            List<String> info = data.split('||');
            setState(() {
              user = Users(info[0], info[1], info[2], info[3], info[4], null);
            });
          }
        });
        return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context)=>HomePage(errand)
        ), (route) => false) as Future<bool>;
      },
      child: SafeArea(child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        // key: mainDrawerKey,
        // drawer: MyDrawer(),
        body: Container(
          child: Center(
            child: Column(
              children: [
                //AppBar
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: Color(0xFF555555)
                          )
                      )
                  ),
                  child: Material(
                    // elevation: 3,
                    color: Colors.white,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        //back bt
                        // Positioned(
                        //   top: 0,
                        //   bottom: 0,
                        //   left: 9,
                        //   child: InkWell(
                        //     onTap: (){
                        //       mainDrawerKey.currentState.openDrawer();
                        //     },
                        //     splashColor: Colors.transparent,
                        //     highlightColor: Colors.transparent,
                        //     child: Container(
                        //       padding: const EdgeInsets.all(10.0),
                        //       child: new Image.asset("assets/Icons/ic_menu.png",width: 25,),
                        //     ),
                        //   ),
                        // ),
                        //Center Widget
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Create Profile",//"Edit Profile",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'narrowmedium',
                                  fontWeight: FontWeight.w500
                              ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    height: MediaQuery.of(context).size.height*1.0-55,
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //Profile Pic
                            Container(
                              height: 160,
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: (){
                                  openGallery();
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Container(
                                  height: 105,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Container(
                                        height: 105,
                                        width: 110,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: (imageFile == null)?
                                        Image.asset("assets/Icons/ic_profile.png",fit: BoxFit.fill,):
                                        Image.file(imageFile!,fit: BoxFit.fill,),
                                      ),
                                      Positioned(
                                          bottom: -1,
                                          right: 2.5,
                                          child:isEdit?SizedBox(): GestureDetector(
                                              onTap: (){
                                                edtbtn();
                                              },
                                              child:  Container(
                                                padding: EdgeInsets.all(5.0),
                                                child: Image.asset("assets/Icons/ic_edit.png",width: 26,),
                                              )
                                          )
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //Sec2
                            //First & Last Name
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child:  Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Color(0x80C2C2C2)
                                              )
                                          )
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 10,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "First Name",
                                                style: TextStyle(
                                                  color: Color(0xFF787878),
                                                  fontSize: 12,
                                                  fontFamily: "narrowmedium",
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              TextFormField(
                                                enabled: true,
                                                controller: fnameCtrl,
                                                keyboardType: TextInputType.text,
                                                cursorColor: Colors.pink,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(top: 15),
                                                  border: InputBorder.none,
                                                  hintText: "Enter Info Here..",
                                                  hintStyle: TextStyle(
                                                    color: Color(0xFFC2C2C2),
                                                    fontSize: 12,
                                                    fontFamily: "narrownews",
                                                  ),

                                                ),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: "narrownews",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 25,),
                                  Expanded(
                                    child:  Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Color(0x80C2C2C2)
                                              )
                                          )
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 10,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Last Name",
                                                style: TextStyle(
                                                  color: Color(0xFF787878),
                                                  fontSize: 12,
                                                  fontFamily: "narrowmedium",
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              TextFormField(
                                                enabled: true,
                                                controller: lnameCtrl,
                                                keyboardType: TextInputType.text,
                                                cursorColor: Colors.pink,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(top: 15),
                                                  border: InputBorder.none,
                                                  hintText: "Enter Info Here..",
                                                  hintStyle: TextStyle(
                                                    color: Color(0xFFC2C2C2),
                                                    fontSize: 12,
                                                    fontFamily: "narrownews",
                                                  ),

                                                ),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: "narrownews",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Username
                            Container(
                              height: 60,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: Color(0x80C2C2C2)
                                      )
                                  )
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 10,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Username",
                                        style: TextStyle(
                                          color: Color(0xFF787878),
                                          fontSize: 12,
                                          fontFamily: "narrowmedium",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextFormField(
                                        enabled: editUserName,
                                        controller: unameCtrl,
                                        keyboardType: TextInputType.text,
                                        cursorColor: Colors.pink,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(top: 15),
                                          border: InputBorder.none,
                                          hintText: "Enter Info Here..",
                                          hintStyle: TextStyle(
                                            color: Color(0xFFC2C2C2),
                                            fontSize: 12,
                                            fontFamily: "narrownews",
                                          ),

                                        ),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: "narrownews",
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          editUserName=true;
                                          editUserNameVisbility=false;
                                        });
                                      },
                                      child: Visibility(
                                        visible: editUserNameVisbility,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Edit Username",
                                            style: TextStyle(
                                              color: Colors.pink,
                                              fontSize: 12,
                                              fontFamily: "narrowmedium",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Your Email
                            Container(
                              height: 60,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: Color(0x80C2C2C2)
                                      )
                                  )
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 10,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Email",
                                        style: TextStyle(
                                          color: Color(0xFF787878),
                                          fontSize: 12,
                                          fontFamily: "narrowmedium",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextFormField(
                                        enabled: true,
                                        controller: emailCtrl,
                                        keyboardType: TextInputType.emailAddress,
                                        cursorColor: Colors.pink,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(top: 15),
                                          border: InputBorder.none,
                                          hintText: "Enter Info Here..",
                                          hintStyle: TextStyle(
                                            color: Color(0xFFC2C2C2),
                                            fontSize: 12,
                                            fontFamily: "narrownews",
                                          ),

                                        ),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: "narrownews",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            //Country
                            InkWell(
                              onTap: (){
                                // Navigator.of(context).push(_selectCountryScreenRoute());
                                FocusScope.of(context).requestFocus(FocusNode());
                                _awaitReturnValueFromSelectCountryScreen(context);
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Container(
                                height: 60,
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: Color(0x80C2C2C2)
                                        )
                                    )
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 10,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Country",
                                          style: TextStyle(
                                            color: Color(0xFF787878),
                                            fontSize: 12,
                                            fontFamily: "narrowmedium",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      bottom: 10,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          countryCtrl,
                                          style: TextStyle(
                                            color: Color(0xFFC2C2C2),
                                            fontSize: 12,
                                            fontFamily: "narrownews",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //Date of birth
                            // InkWell(
                            //   onTap: (){
                            //     FocusScope.of(context).requestFocus(FocusNode());
                            //     Navigator.of(context).push(_birthdayScreenRoute());
                            //   },
                            //   splashColor: Colors.transparent,
                            //   highlightColor: Colors.transparent,
                            //   child: Container(
                            //     height: 60,
                            //     margin: EdgeInsets.symmetric(vertical: 10),
                            //     decoration: BoxDecoration(
                            //         border: Border(
                            //             bottom: BorderSide(
                            //                 width: 1,
                            //                 color: Color(0x80C2C2C2)
                            //             )
                            //         )
                            //     ),
                            //     child: Stack(
                            //       children: [
                            //         Positioned(
                            //           left: 0,
                            //           top: 10,
                            //           child: Container(
                            //             alignment: Alignment.centerLeft,
                            //             child: Text(
                            //               "Date of Birth",
                            //               style: TextStyle(
                            //                 color: Color(0xFF787878),
                            //                 fontSize: 12,
                            //                 fontFamily: "narrowmedium",
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //         Positioned(
                            //           left: 0,
                            //           bottom: 10,
                            //           child: Container(
                            //             alignment: Alignment.centerLeft,
                            //             child: Text(
                            //               "Enter Info Here..",
                            //               style: TextStyle(
                            //                 color: Color(0xFFC2C2C2),
                            //                 fontSize: 12,
                            //                 fontFamily: "narrownews",
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            //Edit Profile button
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: MaterialButton(
                                      height: 48,
                                      onPressed: () {
                                        Users user = Users(fnameCtrl.text, lnameCtrl.text, unameCtrl.text, emailCtrl.text, countryCtrl, null);
                                        Errand? errand;
                                        FileUtils.saveToFile('${user.fname}||${user.lname}||${user.uname}||${user.email}||${user.country}').then(
                                                (value) => Navigator.pushReplacement(context,
                                                    MaterialPageRoute(builder: (context) => HomePage(errand)))
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
                                        "LOGIN",//"Edit Profile",
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
  //_selectCountryScreenRoute
  Route _selectCountryScreenRoute() {
    return  PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SelectCountryScreen(),
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

  void _awaitReturnValueFromSelectCountryScreen(BuildContext context) async{
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.of(
      context,).push(_selectCountryScreenRoute());
    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      countryCtrl = result;
    });
  }

  //_birthdayScreenRoute
  Route _birthdayScreenRoute() {
    return  PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => BirthdayScreen(),
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
