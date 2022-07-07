import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../view/screens/LoginScreen.dart';

logoutDialog(BuildContext context){
  String alert =  'Are you sure you want to LOGOUT?';
  return showDialog(context: context,builder: (context){
    return AlertDialog(
      actionsPadding: const EdgeInsets.symmetric(vertical:5.0,horizontal:10.0),
      title: const Icon(Icons.login_outlined,size: 60,color: Colors.red,),
      content: SizedBox(width: 50,child: Text(alert,
        textAlign: TextAlign.center,style: const TextStyle(fontFamily: "Arial",fontSize: 30,fontWeight: FontWeight.w500),),),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(height: 50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.greenAccent
            ),
                child:MaterialButton(elevation: 5.0,child: const Text('CANCEL',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),
                ),
                    onPressed: () => Navigator.of(context).pop(false)
                )),
            const SizedBox(width: 10,),
            Container(height: 50, decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.redAccent
            ),
                child:MaterialButton(elevation: 5.0,child: const Text('LOGOUT',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),
                ),
                    onPressed: (){
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context)=>LoginScreen())
                      );
                    }
                ))
          ],
        )
      ],
    );
  });}

nonUserDialog(BuildContext context){
  return showDialog(context: context,builder: (context){
    return AlertDialog(
      title: const Center(child: Icon(Icons.lock,size: 60,color: Colors.red,)),
      content: const Text('Login was unsuccessful!'),
      actions: <Widget>[
        MaterialButton(
          elevation: 5.0,
          child: const Text('TRY AGAIN',
            style: TextStyle(color: Colors.green,fontSize: 30,fontWeight: FontWeight.w700),
          ),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  });}

statusDialog(BuildContext context,bool status,String label){
  return showDialog(context: context,builder: (context){
    return AlertDialog(
      title: Center(child: FaIcon((status)?FontAwesomeIcons.checkCircle:Icons.block,size: 60,color: (status)?Colors.green:Colors.red,)),
      content: Text(label,textAlign: TextAlign.center,),
      actions: <Widget>[
        MaterialButton(
          elevation: 5.0,
          child: Text((status)?'OK':'TRY AGAIN',
            style: TextStyle(color: Colors.green,fontSize: 30,fontWeight: FontWeight.w700),
          ),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  });
}

orderDialog(BuildContext context){
  String alert =  'YOUR ORDER HAS BEEN PLACED!';
  return showDialog(context: context,builder: (context){
    return AlertDialog(
      actionsPadding: const EdgeInsets.symmetric(vertical:5.0,horizontal:10.0),
      title: const Icon(Icons.check_circle,size: 60,color: Colors.green,),
      content: SizedBox(width: 50,child: Text(alert,
        textAlign: TextAlign.center,style: const TextStyle(fontFamily: "Arial",fontSize: 30,fontWeight: FontWeight.w500),),),
      actions: <Widget>[
        Container(height: 50, decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.redAccent
        ),
            child:MaterialButton(elevation: 5.0,child: const Text('OK, Thanks!',
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),
            ),
                onPressed: (){
                  Navigator.pop(context);
                }
            ))
      ],
    );
  });}
