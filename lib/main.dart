import 'package:flutter/material.dart';
import 'package:nokiapro/dialer.dart';
import 'package:nokiapro/styles/app_colors.dart';
import 'package:nokiapro/styles/button_design.dart';
import 'package:provider/provider.dart';

import 'dialer_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DialerModel>(
      create: (context) => DialerModel(),
      child: MaterialApp(
        title: 'Nokia Pro',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 150,
            left: 100,
            right: 100,
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 4,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              color: AppColors.greenScreenColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Consumer<DialerModel>(
                    builder: (context, value, child) => Text(
                      value.number,
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/nokiacutscreenv2.png'),
                    fit: BoxFit.contain)),
          ),
          Dialer(),
          Positioned(
            top: 410,
            left: 150,
            right: 150,
            child: FlatButton(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(''),
              onPressed: () {},
            ),
          ),
          Positioned(
            top: 444,
            left: 90,
            right: 260,
            child: FlatButton(
              onPressed: () { },
              child: Text(""),
            ),
          ),
          Positioned(
            top: 435,
            left: 275,
            right: 85,
            child: FlatButton(
              onPressed: () {},
              child: Text(""),
            ),
          ),
          Positioned(
            top: 460,
            left: 230,
            right: 130,
            child: FlatButton(
              onPressed: () { },
              child: Text(""),
            ),
          ),
        ],
      ),
    );
  }
}
