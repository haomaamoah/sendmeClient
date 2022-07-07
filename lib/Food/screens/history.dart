import '../../../Food/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart.dart';


class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with AutomaticKeepAliveClientMixin<HistoryScreen >{
  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
        builder: (BuildContext context, HistoryProvider history, Widget? child){
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
              child: history.carts.length == 0 ? Center(child: Text("No orders have been made.")) :
              ListView.builder(
                itemCount: history.carts.length,
                itemBuilder: (BuildContext context, int index) {
                  List<Map> cart = history.getCarts()[index];
                  print(cart);print(history.getCarts());
                  return ListTile(
                    leading: Icon(
                      Icons.fastfood,
                      size: 35.0,
                    ),
                    title: Text("ORDER "+"${index+1}"),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HistoryCartScreen(cart)));
                    },
                  );
                },
              ),
            ),
          );
        }
    );
  }

  @override
  bool get wantKeepAlive => true;
}
