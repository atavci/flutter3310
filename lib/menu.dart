import 'package:flutter/material.dart';

class MenuItem {
  String name;
  IconData icon;
  MenuItem({this.name, this.icon});


  static List<MenuItem> menuItems = [
    MenuItem(
      name: 'Phone book',
      icon: (Icons.phone),
    ),
    MenuItem(
      name: 'Messages',
      icon: (Icons.message),
    ),
//    MenuItem(
//      name: 'Chat',
//      icon: (Icons.chat),
//    ),
//    MenuItem(
//      name: 'Call register',
//      icon: (Icons.phone),
//    ),
//    MenuItem(
//      name: 'Tones',
//      icon: (Icons.phonelink_ring),
//    ),
//    MenuItem(
//      name: 'Settings',
//      icon: (Icons.settings),
//    ),
//    MenuItem(
//      name: 'Call divert',
//      icon: (Icons.dialer_sip),
//    ),
    MenuItem(
      name: 'Games',
      icon: (Icons.games),
    ),
    MenuItem(
      name: 'Calculator',
      icon: (Icons.calendar_today),
    ),
//    MenuItem(
//      name: 'Reminders',
//      icon: (Icons.receipt),
//    ),
    MenuItem(
      name: 'Clock',
      icon: (Icons.watch_later),
    ),
//    MenuItem(
//      name: 'Profiles',
//      icon: (Icons.person_outline),
//    ),
//    MenuItem(
//      name: 'SIM services',
//      icon: (Icons.sim_card),
//    ),
  ];
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List menuItems = MenuItem.menuItems;
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 150,
                width: 200,
                color: Color.fromRGBO(115, 122, 106, 1),
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                menuItems[i].name,
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                           SizedBox(
                            height: 10,
                          ),
                          Icon(
                            menuItems[i].icon,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${i + 1}',
                            style: TextStyle(fontSize: 15),
                          ),
                        )),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Select',
                          style: TextStyle(fontSize: 18),
                        ))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        if (i == 0) {
                          setState(() {
                            i = menuItems.length - 1;
                          });
                        } else
                          setState(() {
                            i--;
                          });
                      }),
                  IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        if (i == menuItems.length - 1) {
                          setState(() {
                            i = 0;
                          });
                        } else
                          setState(() {
                            i++;
                          });
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
