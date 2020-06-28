import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dialer_model.dart';

class Dialer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (MediaQuery.of(context).size.height / 1.55),
      width: 250,
      height: 200,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          columnSpace(),
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  DialerButton('1'),
                  DialerButton('2'),
                  DialerButton('3'),
                ]),
          ),
          columnSpace(),
          Expanded(
            child: Row(children: <Widget>[
              DialerButton('4'),
              DialerButton('5'),
              DialerButton('6'),
            ]),
          ),
          columnSpace(),
          Expanded(
            child: Row(children: <Widget>[
              DialerButton('7'),
              DialerButton('8'),
              DialerButton('9'),
            ]),
          ),
          columnSpace(),
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

  Widget columnSpace() => SizedBox(height: 10);
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
