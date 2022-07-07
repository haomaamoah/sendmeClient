import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../util/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier{
  AppProvider(){
    checkTheme();
  }


  ThemeData theme = Constants.lightTheme;
  Key key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void setKey(value) {
    key = value;
    notifyListeners();
  }

  void setNavigatorKey(value) {
    navigatorKey = value;
    notifyListeners();
  }

  void setTheme(value, c) {
    theme = value;
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("theme", c).then((val){
        SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: c == "dark" ? Constants.darkPrimary : Constants.lightPrimary,
          statusBarIconBrightness: c == "dark" ? Brightness.light:Brightness.dark,
        ));
      });
    });
    notifyListeners();
  }

  ThemeData getTheme(value) {
    return theme;
  }

  Future<ThemeData> checkTheme() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeData t;
    String? r = prefs.getString("theme") == null ? "light" : prefs.getString(
        "theme");

    if(r == "light"){
      t = Constants.lightTheme;
      setTheme(Constants.lightTheme, "light");
    }else{
      t = Constants.darkTheme;
      setTheme(Constants.darkTheme, "dark");
    }

    return t;
  }
}


class CartProvider extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Map> foods = [];

  List<Map> getFoods() {
    return foods;
  }

  int get totalPrice => foods.length * 10;

  void add(Map food) {
    foods.add(food);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeAll() {
    foods.clear();
    notifyListeners();
  }
}


class HistoryProvider extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<List<Map>> carts = [];

  List<List<Map>> getCarts() {
    return carts;
  }


  void addCart(List<Map> cart) {
    carts.add(cart);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  final Set<Map> _recommendations = Set();
  final List<Map> recommendations_ = [];
  final Set<Map> recommendations = Set();

  Set<Map> getRecommendations() {
    return recommendations;
  }


  void addRecommendation(List<Map> food) {
    _recommendations.addAll(food);
    recommendations_.addAll(_recommendations);
    for (int x = 0; x < _recommendations.length;x++){
      int count = recommendations_.where((_)=> _ == _recommendations.elementAt(x)).length;
      print(count);
      if (count==3)recommendations.add(_recommendations.elementAt(x));
    }
    _recommendations.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

}


