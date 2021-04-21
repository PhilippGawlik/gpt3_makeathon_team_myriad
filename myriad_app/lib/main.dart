import 'package:flutter/material.dart';
import 'screens/main_screen.dart';


void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Color.fromRGBO(247, 254, 128, 1.0),
        fontFamily: 'Georgia',
        textTheme:  TextTheme(
          bodyText1: TextStyle(fontSize: 24)
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
      },
    );
  }
}
