import 'package:flutter/material.dart';
import 'package:nokiapro/dialer.dart';
import 'package:nokiapro/styles/app_colors.dart';
import 'package:nokiapro/styles/app_svg.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Provider.of<DialerModel>(context, listen: false).clear(),child: Text('C',style: TextStyle(fontSize: 20),),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 140,
            left: 80,
            right: 80,
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 4,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              color: AppColors.greenScreenColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: const EdgeInsets.all(2.0),
                        child: AppSVG.getSVG(AppSVG.barLargest, height: 24),
                      ),
                      Container(
                        margin: const EdgeInsets.all(2.0),
                        child: AppSVG.getSVG(AppSVG.barLarge, height: 20),
                      ),
                      Container(
                        margin: const EdgeInsets.all(2.0),
                        child: AppSVG.getSVG(AppSVG.barSmall, height: 16),
                      ),
                      Container(
                        margin: const EdgeInsets.all(2.0),
                        child: AppSVG.getSVG(AppSVG.barMedium, height: 16),
                      ),
                      Container(
                        margin: const EdgeInsets.all(2.0),
                        padding: const EdgeInsets.only(left: 5.0),
                        child: AppSVG.getSVG(AppSVG.signal),
                      ),
                    ],
                  ),
//                  SizedBox(width: 50,),
                  Container(
                    height: 400,
                    width: 150,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Positioned(
                          top: 30,
                          child: Container(
                            height: 110,
                            width: 150,
                            child: Consumer<DialerModel>(
                              builder: (context, value, child) => Text(
                                value.number,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                        Container(
                            height: 30,
                            child: FlatButton(
                              onPressed: () {},
                              child: Text('Menu'),
                            ))
                      ],
                    ),
                  ),
//                  SizedBox(width: 50,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: const EdgeInsets.all(2.0),
                        child: AppSVG.getSVG(AppSVG.barLargest, height: 24),
                      ),
                      Container(
                        margin: const EdgeInsets.all(2.0),
                        child: AppSVG.getSVG(AppSVG.barLarge, height: 20),
                      ),
                      Container(
                        margin: const EdgeInsets.all(2.0),
                        child: AppSVG.getSVG(AppSVG.barSmall, height: 16),
                      ),
                      Container(
                        margin: const EdgeInsets.all(2.0),
                        child: AppSVG.getSVG(AppSVG.barMedium, height: 16),
                      ),
                      Container(
                        margin: const EdgeInsets.all(2.0),
                        padding: const EdgeInsets.only(right: 5.0),
                        child: AppSVG.getSVG(AppSVG.battery),
                      ),
                    ],
                  ),
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
        ],
      ),
    );
  }
}
