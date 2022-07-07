import 'package:flutter/material.dart';

Padding copyrightBanner(){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Text(
      "SEND★ME LLC ©2022",
      style: TextStyle(
        color: Color(0xFF787878),
        fontSize: 15,
        fontFamily: 'narrowmedium',
      ),
      textAlign: TextAlign.center,
    ),
  );
}