import 'package:flutter/material.dart';
import 'package:nokiapro/styles/app_colors.dart';
import 'package:nokiapro/styles/app_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nokia Pro',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
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
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 50,
            right: 50,
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 3,
              color: AppColors.greenScreenColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment:  MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 30,),
                      Container(margin:const EdgeInsets.all(2.0),child: AppSVG.getSVG(AppSVG.barLargest,height:40),),
                      Container(margin:const EdgeInsets.all(2.0),child: AppSVG.getSVG(AppSVG.barLarge,height:30),),
                      Container(margin:const EdgeInsets.all(2.0),child: AppSVG.getSVG(AppSVG.barSmall),),
                      Container(margin:const EdgeInsets.all(2.0),child: AppSVG.getSVG(AppSVG.barMedium),),
                      Container(margin:const EdgeInsets.all(2.0),padding:const EdgeInsets.only(left: 5.0),child: AppSVG.getSVG(AppSVG.signal),),
                    ],
                  ),
                  SizedBox(width: 50,),
                  Text(
                    'test',
                    style: TextStyle(color: Colors.black,fontSize: 25),
                  ),
                  SizedBox(width: 50,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 30,),
                      Container(margin:const EdgeInsets.all(2.0),child: AppSVG.getSVG(AppSVG.barLargest,height:40),),
                      Container(margin:const EdgeInsets.all(2.0),child: AppSVG.getSVG(AppSVG.barLarge,height:30),),
                      Container(margin:const EdgeInsets.all(2.0),child: AppSVG.getSVG(AppSVG.barSmall),),
                      Container(margin:const EdgeInsets.all(2.0),child: AppSVG.getSVG(AppSVG.barMedium),),
                      Container(margin:const EdgeInsets.all(2.0),padding:const EdgeInsets.only(right: 5.0),child: AppSVG.getSVG(AppSVG.battery),),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/nokiabig.png'),
                    fit: BoxFit.contain)),
          ),
        ],
      ),
    );
  }
}
