import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Food/providers/app_provider.dart';
import '../widgets/cart_item.dart';
import 'checkout.dart';


class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with AutomaticKeepAliveClientMixin<CartScreen >{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<CartProvider>(
      builder: (BuildContext context, CartProvider cartProvider, Widget? child){
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
            child: cartProvider.foods.length == 0 ? Center(child: Text("No meals have been added to cart.")) :
            ListView.builder(
              itemCount: cartProvider.foods.length,
              itemBuilder: (BuildContext context, int index) {
                Map food = cartProvider.foods[index];
                return CartItem(
                  img: food['img'],
                  isFav: false,
                  name: food['name'],
                  rating: 5.0,
                  raters: 23,
                  food: food,
                );
              },
            ),
          ),

          floatingActionButton: (cartProvider.foods.length == 0) ? null : FloatingActionButton(
            tooltip: "Checkout",
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context){
                    return Checkout();
                  },
                ),
              );
            },
            child: Icon(
              Icons.arrow_forward,
            ),
            heroTag: Object(),
          ),
        );
      }
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HistoryCartScreen extends StatefulWidget {
  late List<Map> foods;

  HistoryCartScreen(List<Map> foods){this.foods = foods;}

  @override
  _HistoryCartScreenState createState() => _HistoryCartScreenState();
}

class _HistoryCartScreenState extends State<HistoryCartScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: widget.foods.length == 0 ? Center(child: Text("No delivery has been made yet.")) :
        ListView.builder(
          itemCount: widget.foods.length,
          itemBuilder: (BuildContext context, int index) {
            Map food = widget.foods[index];
            return CartItem(
              img: food['img'],
              isFav: false,
              name: food['name'],
              rating: 5.0,
              raters: 23,
              food: food,
            );
          },
        ),
      ),

    );
  }

}
