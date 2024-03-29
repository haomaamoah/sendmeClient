
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:sendmeClient/Database/models.dart';
import 'package:location/location.dart' as l;
import 'DeliveryDetailsScreen.dart';
import 'MyDrawer.dart';
class MapScreen extends StatefulWidget {
  Errand errand;
  MapScreen(Errand errand){this.errand=errand;}

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  final GlobalKey<ScaffoldState> mainDrawerKey = GlobalKey<ScaffoldState>();

  ////////////////////////

  String pickUpLoc, dropOffLoc, currentLoc, price, distance;
  LatLng pickupLatLng, dropOffLatLng, currentLatLng;


  void getLocation(String location)async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    if (location == 'pickup') {
      pickUpLoc ='${placemark.subThoroughfare} ${placemark.thoroughfare}\n${placemark.subAdministrativeArea}\n${placemark.locality}\n${placemark.administrativeArea}';
      pickupLatLng = LatLng(position.latitude,position.longitude);
    }else if (location == 'dropoff') {
      dropOffLoc ='${placemark.subThoroughfare} ${placemark.thoroughfare}\n${placemark.subAdministrativeArea}\n${placemark.locality}\n${placemark.administrativeArea}';
      dropOffLatLng = LatLng(position.latitude,position.longitude);
    }else if (location == 'current'){
      currentLoc ='${placemark.subThoroughfare} ${placemark.thoroughfare}\n${placemark.subAdministrativeArea}\n${placemark.locality}\n${placemark.administrativeArea}';
      currentLatLng = LatLng(position.latitude,position.longitude);
    }
  }







  ///////////////////////

  CameraPosition _initialCameraPosition;

  GoogleMapController mapCtrl;

  Marker _origin, _destination;
  Set<Polyline> polyline = {};
  List<LatLng> routePoints;
  GoogleMapPolyline googleMapPolyline = GoogleMapPolyline(apiKey: "AIzaSyBPZjaCzSByUHJuKRW4uXrsB2pQV9uoKvg");
  var locationOptions = LocationOptions();

  void _onMapCreated(GoogleMapController controller) async{
    mapCtrl = controller;
    if(dropOffLatLng!=null){
      routePoints = await googleMapPolyline.getCoordinatesWithLocation(
          origin: pickupLatLng,
          destination: dropOffLatLng,
          mode: RouteMode.driving);
      polyline.add(Polyline(
          polylineId: PolylineId('route1'),
          visible: true, color: Colors.green, width: 5,
          points: routePoints,
          startCap: Cap.roundCap, endCap: Cap.roundCap));
      _addMarker(pickupLatLng);_addMarker(dropOffLatLng);
    }


    print("Map");
  }

  void _onCameraMove(CameraPosition position) {
    currentLatLng = position.target;
  }


  Widget googleMap(BuildContext context){
    return   GoogleMap(
      initialCameraPosition: _initialCameraPosition,
      mapType: MapType.terrain,
      polylines: (widget.errand != null) ? polyline : {},
      onMapCreated: _onMapCreated,
      markers: {
        if (_origin != null) _origin,if (_destination != null) _destination,
      },
      // onCameraMove: _onCameraMove,
      // myLocationEnabled: true,
      // zoomControlsEnabled: true,
    );
  }

  void _addMarker(LatLng pos){
    if (_origin == null || (_origin != null && _destination != null)){
      setState(() {
        _origin = Marker(
          markerId: MarkerId('pickup'),
          infoWindow: InfoWindow(title: "PICK UP"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos
        );
        _destination = null;polyline = {};
      });
    } else {
      setState(() {
        _destination = Marker(
            markerId: MarkerId('dropoff'),
            infoWindow: InfoWindow(title: "DROP OFF"),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            position: pos
        );
      });
    }
  }

  bool pickupIcon = true;
  //PickUp
  Widget pickupScreen(){
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //Top Widgets
              Container(
                child: Column(
                  children: <Widget>[
                    //Menu Button
                    Container(
                      height: 55,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 10,
                            top: 0,
                            bottom: 0,
                            child: InkWell(
                              onTap: (){
                                mainDrawerKey.currentState.openDrawer();
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Image.asset("assets/Icons/ic_menu.png",
                                  color: Colors.black,
                                  width: 25,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Location Indicator
                    Container(
                      padding: EdgeInsets.only(left: 16.0,right: 20,top: 5),
                      child: GestureDetector(
                        onTap: () async {
                          Prediction prediction = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: "AIzaSyDqfynrB0edtzp6d1bOXkLqAPhNaxqs0bE",
                              mode: Mode.fullscreen,
                              language: "en",
                              components: [Component(Component.country, "gh")]);
                          GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyDqfynrB0edtzp6d1bOXkLqAPhNaxqs0bE");
                          PlacesDetailsResponse locationInfo = await _places.getDetailsByPlaceId(prediction.placeId);
                          setState(() {
                            pickUpLoc = prediction.description;
                            pickupLatLng = LatLng(locationInfo.result.geometry.location.lat,locationInfo.result.geometry.location.lng);
                            _addMarker(pickupLatLng);
                          });
                        },
                        child: Card(
                            elevation: 5,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              height: 60,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                    child: Image.asset("assets/Icons/ic_circle.png",
                                      color: Colors.pink,height: 18,),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text((pickUpLoc != null) ? pickUpLoc.split(",")[0] : "Click to Enter Pickup Location",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(
                                              color: Color(0xFF787878),
                                              fontSize: 12,
                                              fontFamily: 'narrowmedium',
                                            ),),
                                        ),
                                        SizedBox(height: 3,),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text((pickUpLoc != null) ? "${pickUpLoc.split(",")[1]}, ${pickUpLoc.split(",")[2]}" : "Pickup Location",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(
                                              color: Color(0xFFC2C2C2),
                                              fontSize: 12,
                                              fontFamily: 'narrowmedium',
                                            ),),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Bottom Section
              Container(
                padding: EdgeInsets.symmetric(vertical: 22,horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    //Car Delivery button
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 1),
                      child: Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                                height: 52,
                                color: Colors.white,
                                elevation: 0,
                                highlightElevation: 0,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.0)
                                ),
                                onPressed: (){
                                  //   cardeliverPopup();
                                  deliveryPopup();
                                },
                                child:Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            child: Image.asset("assets/Icons/ic_delivery.png",
                                              width: 35,
                                            ),
                                          ),
                                          SizedBox(width: 15,),
                                          Container(
                                            child: Text(value==null?"Delivery":"$value",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontFamily: 'narrowmedium',
                                              ),),
                                          )
                                        ],
                                      ),
                                      Container(
                                        child: Image.asset("assets/Icons/ic_drop_arrow.png",
                                          scale: 5.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    //Confirm Pickup button
                    Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                              height: 48,
                              elevation: 0,
                              highlightElevation: 0,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              color: Colors.pink,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0)
                              ),
                              onPressed: (){
                                confirmPickupPopup(context);
                              },
                              child:Text("Confirm Pickup",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  fontFamily: 'narrowmedium',
                                ),)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          //Map pickupIcon
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: pickupIcon,
                  child: Icon(Icons.center_focus_strong,size: 40,color: Colors.redAccent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool dropoffIcon = true;
//dropOff
  Widget dropOff(){
    return  Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //Top Widgets
              Container(
                child: Column(
                  children: <Widget>[
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
                            left: 11,
                            child: InkWell(
                              onTap: (){
                               // Navigator.pop(context);
                                setState(() {
                                  dropoff=false;
                                  pickup=true;
                                });
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
                              child: Text("Select Dropoff Location",
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
                    //    Location Indicator
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                      child: Card(
                          elevation: 5,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            height: 100,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/Icons/ic_circle.png",
                                        color: Colors.pink,height: 15,),
                                      Container(
                                        height: 35,
                                        width: 1,
                                        margin: EdgeInsets.only(top:2,bottom: 3),
                                        decoration: BoxDecoration(
                                            color: Colors.pink,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                      ),
                                      Container(
                                        width: 13,
                                        height: 13,
                                        decoration: BoxDecoration(
                                            color: Colors.pink,
                                            shape: BoxShape.circle
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 4,bottom: 5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(pickUpLoc==null?"":pickUpLoc.split(",")[0],
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                    color: Color(0xFF787878),
                                                    fontSize: 12,
                                                    fontFamily: 'narrowmedium',
                                                  ),),
                                              ),
                                              SizedBox(height: 3,),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(pickUpLoc==null?"":"${pickUpLoc.split(",")[1]}, ${pickUpLoc.split(",")[2]}",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                    color: Color(0xFFC2C2C2),
                                                    fontSize: 12,
                                                    fontFamily: 'narrowmedium',
                                                  ),),
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(height: 1, color: Color(0x80C2C2C2),thickness: 1,),
                                        SizedBox(height:5),
                                        Container(
                                          height: 40,
                                          child: Stack(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(right: 23),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    Prediction prediction = await PlacesAutocomplete.show(
                                                        context: context,
                                                        apiKey: "AIzaSyDqfynrB0edtzp6d1bOXkLqAPhNaxqs0bE",
                                                        mode: Mode.fullscreen,
                                                        language: "en",
                                                        components: [Component(Component.country, "gh")]);
                                                    GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyDqfynrB0edtzp6d1bOXkLqAPhNaxqs0bE");
                                                    PlacesDetailsResponse locationInfo = await _places.getDetailsByPlaceId(prediction.placeId);
                                                    setState(() {
                                                      dropOffLoc = prediction.description;
                                                      dropOffLatLng = LatLng(locationInfo.result.geometry.location.lat,locationInfo.result.geometry.location.lng);
                                                      _addMarker(dropOffLatLng);
                                                    });
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(left: 4,bottom: 5),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Container(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text((dropOffLoc != null) ? dropOffLoc.split(",")[0] : "Click to Enter Drop Off Location",
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            softWrap: false,
                                                            style: TextStyle(
                                                              color: Color(0xFF787878),
                                                              fontSize: 12,
                                                              fontFamily: 'narrowmedium',
                                                            ),),
                                                        ),
                                                        SizedBox(height: 3,),
                                                        Container(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text((dropOffLoc != null) ? "${dropOffLoc.split(",")[1]}, ${dropOffLoc.split(",")[2]}" : "Drop Off Location",
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            softWrap: false,
                                                            style: TextStyle(
                                                              color: Color(0xFFC2C2C2),
                                                              fontSize: 12,
                                                              fontFamily: 'narrowmedium',
                                                            ),),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 8,
                                                right: 0,
                                                child: InkWell(
                                                  onTap: (){
                                                  },
                                                  splashColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  child: Image.asset("assets/Icons/ic_search.png",scale: 4.3,),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),


              //Confirm Dropoff button
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                          height: 48,
                          elevation: 0,
                          highlightElevation: 0,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          color: Colors.pink,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0)
                          ),
                          onPressed: (){
                            confirmDropoffPopup(context);
                          },
                          child:Text("Confirm Dropoff",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: 'narrowmedium'
                            ),)
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          //Map dropoffIcon
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Visibility(
          //         visible: dropoffIcon,
          //         child: Image.asset("assets/Icons/ic_location_dropoff.png",scale: 4.5,),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  //Get Started
   Widget getStarted(){
    return  Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //Top Widgets
          Container(
            child: Column(
              children: <Widget>[
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
                        left: 11,
                        child: InkWell(
                          onTap: (){
                          //  Navigator.pop(context);
                            setState(() {
                              dropoff=true;
                              getStart=false;
                            });
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
                          child: Text("Get Started",
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
                //    Location Indicator
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                  child: Card(
                      elevation: 5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        height: 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/Icons/ic_circle.png",
                                    color: Colors.pink,height: 15,),
                                  Container(
                                    height: 35,
                                    width: 1,
                                    margin: EdgeInsets.only(top:2,bottom: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.pink,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                  ),
                                  Container(
                                    width: 13,
                                    height: 13,
                                    decoration: BoxDecoration(
                                        color: Colors.pink,
                                        shape: BoxShape.circle
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(top: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 4,bottom: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(pickUpLoc==null?"":pickUpLoc.split(",")[0],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: TextStyle(
                                                color: Color(0xFF787878),
                                                fontSize: 12,
                                                fontFamily: 'narrowmedium',
                                              ),),
                                          ),
                                          SizedBox(height: 3,),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(pickUpLoc==null?"":"${pickUpLoc.split(",")[1]}, ${pickUpLoc.split(",")[2]}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: TextStyle(
                                                color: Color(0xFFC2C2C2),
                                                fontSize: 12,
                                                fontFamily: 'narrowmedium',
                                              ),),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(height: 1, color: Color(0x80C2C2C2),thickness: 1,),
                                    Container(
                                      height: 40,
                                      child: Stack(
                                        children: [
                                          Column(children:[
                                            SizedBox(height:5),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(dropOffLoc==null?"":dropOffLoc.split(",")[0],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                  color: Color(0xFF787878),
                                                  fontSize: 12,
                                                  fontFamily: 'narrowmedium',
                                                ),),
                                            ),
                                            SizedBox(height: 3,),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(dropOffLoc==null?"":"${dropOffLoc.split(",")[1]}, ${dropOffLoc.split(",")[2]}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                  color: Color(0xFFC2C2C2),
                                                  fontSize: 12,
                                                  fontFamily: 'narrowmedium',
                                                ),),
                                            )
                                          ]),
                                          Positioned(
                                            bottom: 8,
                                            right: 0,
                                            child: InkWell(
                                              onTap: (){
                                              },
                                              splashColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              child: Image.asset("assets/Icons/ic_search.png",scale: 4.3,),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),


          //Confirm Started button
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: MaterialButton(
                      height: 48,
                      elevation: 0,
                      highlightElevation: 0,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      color: Colors.pink,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0)
                      ),
                      onPressed: (){
                        Errand errand = Errand(null, null, null, null, null, null, pickupLatLng, dropOffLatLng, pickUpLoc, dropOffLoc);
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.of(context).push(_DeliveryDetailsScreenRoute(errand));
                      },
                      child:Text("Started",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: 'narrowmedium'
                        ),)
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
   }
  String value;

  bool pickup  = true;
  bool dropoff  = false;
  bool getStart  = false;
  Position position;
  l.Location location = new l.Location();

  // GET AND SET CURRENT GPS LOCATION
  getCurrentLocation()async{
    bool _serviceEnabled;
    l.PermissionStatus _permissionGranted;
    l.LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == l.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != l.PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();



    currentLatLng = LatLng(_locationData.latitude,_locationData.longitude);
    _initialCameraPosition = CameraPosition(
      target: LatLng(currentLatLng.latitude,currentLatLng.longitude),
      zoom: 15,
    );

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }



  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(child: Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      key: mainDrawerKey,
      drawer: MyDrawer(),

      body: StreamBuilder(
        stream: location.onLocationChanged,
        builder: (context, snapshot) {

          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              SizedBox(
                height: 28,
              ),
              //Map
              (snapshot.data == null) ? Center(child: CircularProgressIndicator()):googleMap(context),
              Visibility(
                  visible: pickup,
                  child: pickupScreen()
              ),
              Visibility(
                  visible: dropoff,
                  child: dropOff()
              ),
              Visibility(
                  visible: getStart,
                  child: getStarted()
              ),

            ],
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: "Current Location",
        foregroundColor: Colors.black,mini: true,
        onPressed: ()=>mapCtrl.animateCamera(
          CameraUpdate.newCameraPosition(_initialCameraPosition)
        ),
        child: const Icon(Icons.center_focus_strong),
      ),

    ));


  }
  //deliveryPopup

  List<MyConstClass> myList=[
    MyConstClass(img: "assets/Icons/ic_delivery_car.png",title: "Car Delivery",subtitle: "Pickup and Delivery Package in a Car"),
    MyConstClass(img: "assets/Icons/ic_delivery_bike.png",title: "Delivery",subtitle: "Pickup and Delivery through bike"),
    MyConstClass(img: "assets/Icons/ic_delivery_cargo.png",title: "Pickup",subtitle: "Order pickup and deliver big luggage"),
  ];
  void deliveryPopup() async{
    final result= await  showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context){
          return  Container(
            constraints: BoxConstraints(
                minHeight: 50,
                maxHeight: 235
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)
                )
            ),
            child: Column(
              children: <Widget>[
                //Top
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 45,
                      height: 3,
                      decoration: BoxDecoration(
                          color: Color(0x80C2C2C2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  height: 180,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: myList.length,
                    itemBuilder: (BuildContext context,index){
                      return InkWell(
                        onTap: (){
                          String textToSendBack = myList[index].title;
                          Navigator.pop(context, textToSendBack);
                        },
                        child:  Container(
                          height: 60,
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                  myList[index].img,
                                  width: 35,
                                ),
                              ),
                              SizedBox(width: 15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text(myList[index].title,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: 'narrowmedium',
                                      ),),
                                  ),
                                  SizedBox(height: 4,),
                                  Container(
                                    child: Text(myList[index].subtitle,
                                      style: TextStyle(
                                        color: Color(0xFFC2C2C2),
                                        fontSize: 11,
                                        fontFamily: 'narrowmedium',
                                      ),),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        });
    setState(() {
      value=result;
    });
  }


  FocusNode _focusNode = FocusNode();
  //Confirm Pickup Popup
  void confirmPickupPopup(BuildContext context){
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context){
          return Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body:   Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height*1.0,
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 220,
                      margin: EdgeInsets.only(bottom: bottom),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(13),
                              topRight: Radius.circular(13)
                          )
                      ),
                      child:  ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: [
                          Column(
                            children: [
                              //Top
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 45,
                                    height: 3,
                                    decoration: BoxDecoration(
                                        color: Color(0x80C2C2C2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                              //Any More Text Widget
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text("Any More Address details?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'narrowmedium',
                                  ),),
                              ),
                            ],
                          ),
                          SizedBox(height: 30,),
                          Container(
                            child: Column(
                              children: [
                                //TextField
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Color(0x80C2C2C2)
                                          )
                                      )
                                  ),
                                  child: TextFormField(
                                    cursorColor: Colors.pink,
                                    focusNode: _focusNode,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Apartment #, Building Name",
                                        hintStyle: TextStyle(
                                          color: Color(0xFFC2C2C2),
                                            fontSize: 14,
                                            fontFamily: 'narrownews',
                                        )
                                    ),
                                  ),
                                ),
                                //Skip And Continue button
                                Container(
                                  padding: EdgeInsets.only(top: 30,bottom: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: ButtonTheme(
                                          height: 42,
                                          child: OutlineButton(
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                              setState(() {
                                                dropoff=true;
                                                pickup=false;
                                              });
                                            },
                                            borderSide: BorderSide(
                                                color: Colors.pink,
                                                width: 1
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(2)
                                            ),
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            child: Text("Skip",
                                              style: TextStyle(
                                                  color: Colors.pink,
                                                  fontSize: 13,
                                                  fontFamily: "narrowmedium",
                                              ),),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 13,),
                                      Expanded(
                                        child: MaterialButton(
                                          height: 42,
                                          onPressed: (){
                                            Navigator.of(context).pop();
                                            //Navigator.of(context).push(_selectDropOffLocationScreenRoute());
                                            setState(() {
                                              dropoff=true;
                                              pickup=false;
                                            });
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(2)
                                          ),
                                          elevation: 0,
                                          highlightElevation: 0,
                                          color: Colors.pink,
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          child: Text("Continue",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontFamily: 'narrowmedium',
                                            ),),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                   Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom))
                  ],
                ),
              ),
            ),
          );
        });
  }

  ///SelectDropOff
//confirmDropoffPopup
  void confirmDropoffPopup(BuildContext context){
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context){
          return Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body:   Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height*1.0,
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 220,
                      margin: EdgeInsets.only(bottom: bottom),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(13),
                              topRight: Radius.circular(13)
                          )
                      ),
                      child:  ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              //Top
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 45,
                                    height: 3,
                                    decoration: BoxDecoration(
                                        color: Color(0x80C2C2C2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                              //Any More Text Widget
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text("Any More Address details?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'narrowmedium',
                                  ),),
                              ),
                            ],
                          ),
                          SizedBox(height: 30,),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //TextField
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Color(0x80C2C2C2)
                                          )
                                      )
                                  ),
                                  child: TextFormField(
                                    cursorColor: Colors.pink,
                                    focusNode: _focusNode,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Apartment #, Building Name",
                                        hintStyle: TextStyle(
                                          color: Color(0xFFC2C2C2),
                                          fontSize: 14,
                                          fontFamily: 'narrownews',
                                        )
                                    ),
                                  ),
                                ),
                                //Skip And Continue button
                                Container(
                                  padding: EdgeInsets.only(top: 30,bottom: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: ButtonTheme(
                                          height: 42,
                                          child: OutlineButton(
                                            onPressed: (){
                                              // Errand errand = Errand(null,null,null,null,null,null, pickupLatLng, dropOffLatLng, pickUpLoc,dropOffLoc);
                                              // Navigator.of(context).push(_PolyMapRoute(errand));

                                              // Navigator.of(context).push(_gerStartedScreenRoute());
                                              setState(() {
                                                dropoff=false;
                                                getStart=true;
                                              });
                                            },
                                            borderSide: BorderSide(
                                                color: Colors.pink,
                                                width: 1
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(2)
                                            ),
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            child: Text("Skip",
                                              style: TextStyle(
                                                color: Colors.pink,
                                                fontSize: 13,
                                                fontFamily: "narrowmedium",
                                              ),),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 13,),
                                      Expanded(
                                        child: MaterialButton(
                                          height: 42,
                                          onPressed: (){
                                            Navigator.of(context).pop();
                                            //  Navigator.of(context).push(_gerStartedScreenRoute());
                                            setState(() {
                                              dropoff=false;
                                              getStart=true;
                                            });
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(2)
                                          ),
                                          elevation: 0,
                                          highlightElevation: 0,
                                          color: Colors.pink,
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          child: Text("Continue",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'narrowmedium',
                                            ),),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom))
                  ],
                ),
              ),
            ),
          );
        });
  }

//GetStarted
  //_DeliveryDetailsScreenRoute
  Route _DeliveryDetailsScreenRoute(Errand errand) {
    return  PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => DeliveryDetailsScreen(errand),
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

  Route _PolyMapRoute(Errand errand) {
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

class MyConstClass{
  String img;
  String title;
  String subtitle;

  MyConstClass({this.img,this.title,this.subtitle});
}