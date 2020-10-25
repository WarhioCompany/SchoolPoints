import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  String text;
  Size size;
  TextEditingController cont;

  InputField(String _t, Size _s, TextEditingController con) {
    text = _t;
    size = _s;
    cont = con;
  }
  @override
  _InputFieldState createState() => _InputFieldState(text, size, cont);
}

class _InputFieldState extends State<InputField> {
  String text;
  Size size;
  TextEditingController cont;
  _InputFieldState(String _t, Size _s, TextEditingController con) {
    text = _t;
    size = _s;
    cont = con;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 12,
        ),
        width: double.infinity,
        height: size.height * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          //color: Colors.blueGrey[100],
        ),
        child: TextFormField(
          controller: cont,
          decoration: new InputDecoration(
            labelText: text,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
            //fillColor: Colors.green
          ),
        ));
    // child: TextField(
    //  controller: cont,
    //   cursorWidth: 1,
    //   cursorColor: Colors.cyan,
    //   textAlign: TextAlign.center,
    //   decoration:
    //       InputDecoration(border: InputBorder.none, prefixText: text),
    // ));
  }
}
