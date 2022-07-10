import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/cloud_utils.dart';
import '../model/models.dart';

final clientProvider = StateProvider<Users>((ref){
  Map<String, dynamic> user = UsersDB.getUser(FirebaseAuth.instance.currentUser!.uid);
  return Users.fromMap(user);
});


