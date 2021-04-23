import 'package:google_maps_flutter/google_maps_flutter.dart';

class Users {
  String fname,lname,uname,country,email,bday;

  Users(this.fname,this.lname,this.uname,this.email,this.country,this.bday);

  Map<String,dynamic> toMap(){
    var map = <String, dynamic>{
      'fname': fname,'lname': lname, 'uname': uname,
      'email': email, 'country': country, 'bday': bday
    }; return map;
  }

  Users.fromMap(Map<String, dynamic> map){
    fname = map['fname']; lname = map['lname']; uname = map['uname'];
    email = map['email']; country = map['country']; bday = map['bday'];
  }
}

class Errand {
  String s_name,s_num,s_email,r_name,r_num,r_email,pickUpLoc,dropOffLoc;
  LatLng pickUpLatLng,dropOffLatLng;

  Errand(this.s_name,this.s_num,this.s_email,this.r_name,this.r_num,this.r_email,this.pickUpLatLng,this.dropOffLatLng,[this.pickUpLoc,this.dropOffLoc]);

  Map<String,dynamic> toMap(){
    var map = <String, dynamic>{
      's_name': s_name,'s_num': s_num, 's_email': s_email,'pickUpLatLng': pickUpLatLng,'pickUpLoc': pickUpLoc,
      'r_name': r_name,'r_num': r_num, 'r_email': r_email,'dropOffLatLng': dropOffLatLng, 'dropOffLoc': dropOffLoc
    }; return map;
  }

  Errand.fromMap(Map<String, dynamic> map){
    s_name = map['s_name']; s_num = map['s_num']; s_email = map['s_email']; pickUpLatLng = map['pickUpLatLng']; pickUpLoc = map['pickUpLoc'];
    r_name = map['r_name']; r_num = map['r_num']; r_email = map['r_email']; dropOffLatLng = map['dropOffLatLng']; dropOffLoc = map['dropOffLoc'];
  }
}