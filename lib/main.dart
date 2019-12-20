import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';


import 'views/home_page.dart';

void main() => runApp(
    MaterialApp(
        home: MyApp(),
        debugShowCheckedModeBanner: false,
    )
);

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consulta Cep',
      home: SplashHomePage(title: 'Consulta de Cep'),
      theme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.yellow),
      darkTheme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.limeAccent),
      //darkTheme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.lime),
    );
  }
}

class SplashHomePage extends StatefulWidget{
  SplashHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SplashHomePageState createState() => _SplashHomePageState();
}

class _SplashHomePageState extends State<SplashHomePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _intoScreen();
  }

  Widget _intoScreen() {
    return Stack(
      children: <Widget>[
        SplashScreen(
          seconds: 4,
          gradientBackground: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.yellow, Colors.lime
            ],
          ),
        backgroundColor: Colors.lime,
        loadingText: new Text('Consulta de Cep',
          style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
          textAlign: TextAlign.end, ),
          navigateAfterSeconds: HomePage(),
          loaderColor: Colors.transparent,
        ),

        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/ic_logo.png"),
              fit: BoxFit.none,
            )
          ),
        )
      ],
    );
  }
}


