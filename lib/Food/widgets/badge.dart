import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Food/providers/app_provider.dart';

class IconBadge extends StatefulWidget {

  final IconData icon;
  final double size;

  IconBadge({Key? key, required this.icon, required this.size})
      : super(key: key);


  @override
  _IconBadgeState createState() => _IconBadgeState();
}

class _IconBadgeState extends State<IconBadge> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (BuildContext context, HistoryProvider history, Widget? child){
        return Stack(
          children: <Widget>[
            Icon(
              widget.icon,
              size: widget.size,
            ),
            if(history.carts.length>0) Positioned(
              right: 0.0,
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 13,
                  minHeight: 13,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 1),
                  child:Text(
                    history.carts.length.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


class CartIconBadge extends StatefulWidget {

  final IconData icon;
  final double size;

  CartIconBadge({Key? key, required this.icon, required this.size})
      : super(key: key);


  @override
  _CartIconBadgeState createState() => _CartIconBadgeState();
}

class _CartIconBadgeState extends State<CartIconBadge> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (BuildContext context, CartProvider cartProvider, Widget? child){
        return Stack(
          children: <Widget>[
            Icon(
              widget.icon,
              size: widget.size,
            ),
            if(cartProvider.foods.length>0) Positioned(
              right: 0.0,
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 13,
                  minHeight: 13,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 1),
                  child:Text(
                    cartProvider.foods.length.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
