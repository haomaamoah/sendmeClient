import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

import '../../../Food/providers/app_provider.dart';

import 'package:flutter_google_places/flutter_google_places.dart';

import '../widgets/cart_item.dart';
import '../widgets/dialogs.dart';
import 'main_screen.dart';
const ApiKey = "AIzaSyCBixfmCsQFRxD1yG5NvCQ2v3XUGAf6A34";

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

  final TextEditingController _couponlControl = new TextEditingController();
  TextEditingController deliveryAddress = TextEditingController();


  @override
  void initState() {
    super.initState();
    deliveryAddress.text = "Enter Delivery Address details here...";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (BuildContext context, CartProvider cartProvider, Widget? child){
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Checkout",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                tooltip: "Back",
                icon: Icon(
                  Icons.clear,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: ()=>Navigator.pop(context),
              ),
            ],
          ),

          body: Padding(
            padding: EdgeInsets.fromLTRB(10.0,0,10.0,130),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Delivery Address",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    // IconButton(
                    //   onPressed: (){},
                    //   icon: Icon(
                    //     Icons.edit,
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () async {
                      Prediction? prediction = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: ApiKey,
                          mode: Mode.fullscreen,
                          language: "en",
                          //radius: 10000000,
                          strictbounds: false,types: [],
                          components: [Component(Component.country, "gh")]);
                      setState(() {
                        deliveryAddress.text = prediction?.description as String;
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: Text(
                        deliveryAddress.text,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        //controller: _couponlControl,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10.0),

                Text(
                  "Payment Method",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                Card(
                  elevation: 4.0,
                  child: ListTile(
                    title: Text("If you will pay CASH leave the space blank."),
                    subtitle: TextField(
                      decoration: InputDecoration(
                        hintText:"Enter Mobile Money Number",
                      ),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    leading: Icon(
                      FontAwesomeIcons.moneyBillAlt,
                      size: 20.0,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),

                SizedBox(height: 20.0),

                Text(
                  "Items",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                ...cartProvider.foods.map(
                        (food) => CartItem(
                          img: food['img'],
                          isFav: false,
                          name: food['name'],
                          rating: 5.0,
                          raters: 23,
                          food: food,
                        )
                ).toList(),

              ],
            ),
          ),

          bottomSheet: Card(
            elevation: 4.0,
            child: Container(

              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(

                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(color: Colors.grey,),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey,),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          hintText: "Coupon Code",
                          prefixIcon: Icon(
                            Icons.redeem,
                            color: Theme.of(context).accentColor,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        maxLines: 1,
                        controller: _couponlControl,
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.fromLTRB(10,5,5,5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            Text(
                              r"GH₵ "+cartProvider.totalPrice.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).accentColor,
                              ),
                            ),

                            Text(
                              "Delivery charges included",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.fromLTRB(5,5,10,5),
                        width: 150.0,
                        height: 50.0,
                        child: FlatButton(
                          color: Theme.of(context).accentColor,
                          child: Text(
                            "Place Order".toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: (){
                            void callHistoryProvider(context,cart) {
                              //Access the SecondProvider
                              final history= Provider.of<HistoryProvider>(
                                context,
                                listen: false,
                              );
                              history.addCart(cart);
                              history.addRecommendation(cart);
                            }

                            callHistoryProvider(context, cartProvider.getFoods());
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context)=>MainScreen())
                            );
                            cartProvider.removeAll();
                            orderDialog(context);

                          },
                        ),
                      ),

                    ],
                  ),



                ],
              ),

              height: 130,
            ),
          ),
        );
      },
    );
  }
}
