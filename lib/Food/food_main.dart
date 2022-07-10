import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sendmeClient/Food/screens/main_screen.dart';
import 'providers/app_provider.dart';
import 'util/const.dart';


class SubFoodMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: (BuildContext context, AppProvider appProvider, Widget? child) {
          return MaterialApp(
            key: appProvider.key,
            debugShowCheckedModeBanner: false,
            navigatorKey: appProvider.navigatorKey,
            title: Constants.appName,
            theme: appProvider.theme,
            darkTheme: Constants.darkTheme,
            home: MainScreen(),
          );
        },
      ),
    );
  }
}

class foodMain extends StatefulWidget {
  const foodMain({Key? key}) : super(key: key);

  @override
  State<foodMain> createState() => _foodMainState();
}

class _foodMainState extends State<foodMain> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
