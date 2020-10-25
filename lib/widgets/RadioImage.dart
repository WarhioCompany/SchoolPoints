import 'package:flutter/material.dart';
import 'package:o4ki/models/CarEnum.dart';
import 'package:o4ki/widgets/RegPage.dart' as rP;

class RadioImage extends StatefulWidget {
  RadioImage(CarEnum group, CarEnum value, String path, double width) {
    g = group;
    v = value;
    p = path;
    w = width;
  }
  CarEnum g, v;
  String p;
  double w;
  @override
  _RadioImageState createState() => _RadioImageState(g, v, p, w);
}

class _RadioImageState extends State<RadioImage> {
  CarEnum group, value;
  String path;
  double width;
  _RadioImageState(CarEnum g, CarEnum v, String p, double w) {
    group = g;
    value = v;
    path = p;
    width = w;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(
          path,
          width: width,
        ),
        Radio(
          value: CarEnum.orange,
          groupValue: rP.group,
          onChanged: (CarEnum v) {
            setState(() {
              rP.group = v;
            });
          },
        ),
      ],
    );
  }
}
