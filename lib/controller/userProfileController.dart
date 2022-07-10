
import 'dart:async';
import 'dart:html';
import '../model/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future<void> checkIfUserIsLoggedIn()async{
  if (FirebaseAuth.instance.currentUser != null) {
    print(FirebaseAuth.instance.currentUser?.uid);

  }
  else{

  }
}

