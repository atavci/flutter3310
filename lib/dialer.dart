import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dialer_model.dart';

class Dialer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 500,
      width: 400,
      height: 300,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  DialerButton('1'),
                  DialerButton('2'),
                  DialerButton('3'),
                ]),
          ),
          Expanded(
            child: Row(children: <Widget>[
              DialerButton('4'),
              DialerButton('5'),
              DialerButton('6'),
            ]),
          ),
          Expanded(
            child: Row(children: <Widget>[
              DialerButton('7'),
              DialerButton('8'),
              DialerButton('9'),
            ]),
          ),
          Expanded(
            child: Row(children: <Widget>[
              DialerButton('*'),
              DialerButton('0'),
              DialerButton('#'),
            ]),
          ),
        ],
      ),
    );
  }
}

class DialerButton extends StatelessWidget {
  final String number;

  DialerButton(
    this.number,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        child: Text(''),
        onPressed: () {
          Provider.of<DialerModel>(context, listen: false).append(number);
        },
      ),
    );
  }
}
