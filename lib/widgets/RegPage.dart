import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:o4ki/models/CarEnum.dart';

import 'package:o4ki/models/User.dart';
import 'package:o4ki/widgets/mainPage.dart';

class RegPage extends StatefulWidget {
  RegPage({this.app});
  final FirebaseApp app;

  @override
  _RegPageState createState() => _RegPageState();
}

CarEnum group = CarEnum.green;
CarEnum orange = CarEnum.orange,
    blue = CarEnum.blue,
    green = CarEnum.green,
    pink = CarEnum.pink,
    yellow = CarEnum.yellow,
    bluegreen = CarEnum.bluegreen;

class _RegPageState extends State<RegPage> {
  final referenceDatabase = FirebaseDatabase.instance;
  TextEditingController login = new TextEditingController(),
      password = new TextEditingController(),
      email = new TextEditingController(),
      repeat = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();

    Size size = MediaQuery.of(context).size;

    double width = MediaQuery.of(context).size.width * 0.25;

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Регистрация"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: size.height * 0.05,
            ),
            Container(
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
                  controller: email,
                  decoration: new InputDecoration(
                    labelText: "Введите свою почту",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                )),
            Container(
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
                  controller: login,
                  decoration: new InputDecoration(
                    labelText: "Введите свой логин",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                )),
            Container(
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
                  controller: password,
                  decoration: new InputDecoration(
                    labelText: "Введите свой пароль",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                )),
            Container(
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
                  controller: repeat,
                  decoration: new InputDecoration(
                    labelText: "Повторите пароль",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                )),

            //Кнопка
            Container(
              height: size.height * 0.07,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red),
              ),
              color: Colors.white,
              child: Text('Зарегестрироваться'),
              onPressed: () {
                String l = login.text,
                    p = password.text,
                    e = email.text.toLowerCase(),
                    r = repeat.text;
                print("Нажата кнопка зарегестрироваться");
                print("login: $l password: $p email: $e color: ${group.index}");

                if (p != r) {
                  print("Пароли не совпадают");
                  //Alert

                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Пароли не совпадают!"),
                          content: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red),
                            ),
                            color: Colors.white,
                            child: Text('Ок'),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                        );
                      });
                } else if (!RegExp(
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                    .hasMatch(e)) {
                  //Alert
                  print("Почта не валидна");
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Почта не валидна!"),
                          content: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red),
                            ),
                            color: Colors.white,
                            child: Text('Ок'),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                        );
                      });
                } else {
                  //Add
                  print("УРАРАРАА ОТЛАДКААА");
                  referenceDatabase
                      .reference()
                      .child('Users')
                      .once()
                      .then((onValue) {
                    int length;

                    var data = onValue.value;
                    print("Получили датуу!");
                    if (data != null) {
                      length = data.length;
                      print(data.length);
                    } else {
                      length = 0;
                    }

                    bool loginWas = false;
                    bool emailWas = false;
                    for (int i = 1; i < length; i++) {
                      myUser m = myUser.fromJson(data[i], i);
                      print(m.login.toString());
                      print(m.login + " == " + l);
                      print(m.email + " == " + e);
                      if (m.login.toLowerCase() == l.toLowerCase()) {
                        loginWas = true;
                        break;
                      } else if (m.email == e) {
                        emailWas = true;
                        break;
                      }
                    }

                    myUser newUser = new myUser();
                    if (loginWas) {
                      print("Этот логин ранее был использован");
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Этот логин ранее был использован!"),
                              content: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red),
                                ),
                                color: Colors.white,
                                child: Text('Ок'),
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                              ),
                            );
                          });
                    } else if (login.text.length > 12) {
                      print(
                          "Этот логин больше 12 символов (В случае ошибки к Захарову идите) ");
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  "Этот логин больше 12 символов (В случае ошибки к Захарову идите) !"),
                              content: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red),
                                ),
                                color: Colors.white,
                                child: Text('Ок'),
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                              ),
                            );
                          });
                    } else if (emailWas) {
                      print("Эта почта ранее была использована");
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Эта почта ранее была использована!"),
                              content: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red),
                                ),
                                color: Colors.white,
                                child: Text('Ок'),
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                              ),
                            );
                          });
                    } else {
                      ref.child('Users').child((length).toString()).set({
                        'Login': l,
                        'Pass': p,
                        'Admin': 'false',
                        'Email': e,
                        'Color': group.index,
                        'Points': '0'
                      });
                      newUser.login = l;
                      newUser.color = group.index;
                      newUser.password = p;
                      newUser.id = length;
                      newUser.email = e;
                      newUser.points = 0;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(newUser),
                        ),
                      );
                    }
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
