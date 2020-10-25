import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final double value, width, height;
  final Color color;
  ProgressBar(this.value, this.width, this.height, this.color);
  @override
  _ProgressBarState createState() =>
      _ProgressBarState(value, color, width, height);
}

class _ProgressBarState extends State<ProgressBar> {
  final double value, width, height;
  final Color color;
  _ProgressBarState(this.value, this.color, this.width, this.height);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: height,
          width: width,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5)),
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              value: value,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: height / 4, left: width / 2),
          child: Text(
            (value * 100).toString() + "%",
          ),
        ),
      ],
    );
  }
}
