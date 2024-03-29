import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:sendmeClient/Database/models.dart';
import 'dart:convert' as JSON;
import 'ForgotPasswordScreen.dart';
import 'MapScreen.dart';
import 'SignUpScreen.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  bool _isLoggedIn = false;



  bool _toggleText = true;
  void _toggle() {
    setState(() {
      _toggleText = !_toggleText;
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }
  TextEditingController _passcontroller;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.red,
      resizeToAvoidBottomInset: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              // SizedBox(
              //   height: 28,
              // ),
              // AppBar
              Container(
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    //back bt
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 7.5,
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: new Image.asset("assets/Icons/ic_back.png",width: 22,),
                        ),
                      ),
                    ),
                    //Center Widget
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text("Log In",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'narrowmedium',
                          ),),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: MediaQuery.of(context).size.height*1.0-82,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //Welcome Back Text Widget
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Welcome Back,",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 23,
                                  fontFamily: "narrowmedium",
                                ),
                              ),
                            ),
                            //Sign in Text Widget
                            Container(
                              padding: EdgeInsets.only(top: 2),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Sign in to continue",
                                style: TextStyle(
                                  color: Color(0xFFC2C2C2),
                                  fontSize: 12,
                                  fontFamily: 'narrowmedium',
                                ),
                              ),
                            ),
                            SizedBox(height: 18,),
                            //Email Text Field
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
                                        keyboardType: TextInputType.emailAddress,
                                        cursorColor: Colors.pink,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(top: 15),
                                          border: InputBorder.none,
                                          hintText: "haomaamoah@gmail.com",
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
                            //Password Text Field
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
                                        "Password",
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
                                        obscureText: _toggleText,
                                        cursorColor: Colors.pink,
                                        controller: _passcontroller,
                                        keyboardType: TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(top: 20),
                                          border: InputBorder.none,
                                          hintText: "********",
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
                                    right: -8,
                                    bottom:2,
                                    child:  InkWell(
                                      onTap: (){
                                        _toggle();
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: _toggleText? Image.asset("assets/Icons/ic_hide.png",
                                            scale: 3,
                                          ):Image.asset("assets/Icons/ic_show.png",
                                            scale: 3,
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //Forgot password button
                            InkWell(
                              onTap: (){
                                FocusScope.of(context).requestFocus(FocusNode());
                                Navigator.of(context).push(_forgotPasswordRoute());
                              },
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              child: Container(
                                padding: EdgeInsets.only(top: 6,bottom: 4),
                                alignment: Alignment.centerRight,
                                child: Text("Forgot Password ?",
                                  style: TextStyle(
                                    color: Color(0xFF787878),
                                    fontSize: 12,
                                    fontFamily: 'narrowmedium',
                                  ),),
                              ),
                            ),
                            //Log in button
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: MaterialButton(
                                      height: 44,
                                      onPressed: (){
                                        Users user; Errand errand;
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context)=>MapScreen(errand)
                                        ));
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(2)
                                      ),
                                      color: Colors.pink,
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      elevation: 0,
                                      highlightElevation: 0,
                                      child: Text("Log in",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontFamily: 'narrowmedium'
                                        ),),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //Or Continue
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.center,
                              child: Text("Or continue with",
                                style: TextStyle(
                                  color: Color(0xFF787878),
                                  fontSize: 12,
                                  fontFamily: 'narrowmedium',
                                ),),
                            ),
                            //Login with Google
                            // Container(
                            //     padding: EdgeInsets.symmetric(vertical: 13),
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.stretch,
                            //       children: [
                            //         MaterialButton(
                            //             height: 44,
                            //             onPressed: signInWithGoogle,
                            //             shape: RoundedRectangleBorder(
                            //                 borderRadius: BorderRadius.circular(2)
                            //             ),
                            //             color:Color(0xFFdb4437),
                            //             elevation: 0,
                            //             highlightElevation: 0,
                            //             splashColor: Colors.transparent,
                            //             highlightColor: Colors.transparent,
                            //             child: Container(
                            //               height: 44,
                            //               child: Stack(
                            //                 fit: StackFit.expand,
                            //                 overflow: Overflow.visible,
                            //                 children: [
                            //                   Positioned(
                            //                       left:23,
                            //                       bottom: 0,
                            //                       top: 0,
                            //                       child: SvgPicture.asset("assets/svgIcons/ic_google.svg",
                            //                         width: 22,color: Colors.white,)
                            //                   ),
                            //                   Positioned(
                            //                     left: 0,
                            //                     right: 0,
                            //                     top: 0,
                            //                     bottom: 0,
                            //                     child: Container(
                            //                       alignment: Alignment.center,
                            //                       child: Text("Connect with Google",
                            //                         style: TextStyle(
                            //                             color: Colors.white,
                            //                             fontSize: 13,
                            //                             fontFamily: 'narrowmedium'
                            //                         ),),
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             )
                            //         )
                            //       ],
                            //     )
                            // ),
                            //Login with fb
                            Container(
                                padding: EdgeInsets.only(top: 4),
                                child: Row(
                                  children: [
                                    // Expanded(
                                    //   child: MaterialButton(
                                    //       height: 44,
                                    //       onPressed: _loginWithFB,
                                    //       shape: RoundedRectangleBorder(
                                    //           borderRadius: BorderRadius.circular(2)
                                    //       ),
                                    //       color: Color(0xFF3b5998),
                                    //       elevation: 0,
                                    //       highlightElevation: 0,
                                    //       splashColor: Colors.transparent,
                                    //       highlightColor: Colors.transparent,
                                    //       child: Container(
                                    //         height: 44,
                                    //         child: Stack(
                                    //           fit: StackFit.expand,
                                    //           overflow: Overflow.visible,
                                    //           children: [
                                    //             Positioned(
                                    //                 left: 18,
                                    //                 bottom: 0,
                                    //                 top: 0,
                                    //                 child: SvgPicture.asset("assets/svgIcons/ic_facebook.svg",
                                    //                   width: 22,color: Colors.white,)
                                    //             ),
                                    //             Positioned(
                                    //               left: 0,
                                    //               right: 0,
                                    //               top: 0,
                                    //               bottom: 0,
                                    //               child: Container(
                                    //                 alignment: Alignment.center,
                                    //                 child: Text("Connect with Facebook",
                                    //                   style: TextStyle(
                                    //                       color: Colors.white,
                                    //                       fontSize: 13,
                                    //                       fontFamily: 'narrowmedium'
                                    //                   ),),
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       )
                                    //   ),
                                    // )
                                  ],
                                )
                            ),
                            //Don't have account? Signup
                            InkWell(
                              onTap: (){
                                FocusScope.of(context).requestFocus(FocusNode());
                                Navigator.of(context).push(_signUpScreenRoute());
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text("Don't have account? ",
                                        style: TextStyle(
                                          color: Color(0xFF787878),
                                          fontSize: 12,
                                          fontFamily: 'narrowmedium',
                                        ),),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text("Signup",
                                        style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: 12,
                                          fontFamily: 'narrowmedium',
                                        ),),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
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

  //ForgotPassword Route
  Route _forgotPasswordRoute() {
    return  PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ForgotPasswordScreen(),
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

 // _signUpScreenRoute
  Route _signUpScreenRoute() {
    return  PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignUpScreen(),
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
