import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:o4ki/models/User.dart';
import 'package:o4ki/widgets/InputField.dart';
import 'RegPage.dart';
import 'mainPage.dart';

class EntPage extends StatefulWidget {
  @override
  _EntPageState createState() => _EntPageState();
}

class _EntPageState extends State<EntPage> {
  final myControllerForUser = TextEditingController();
  final myControllerForPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: new AppBar(
        title: Text(
          'Вход',
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(size.height * 0.07),
            ),
            InputField("Введите имя", size, myControllerForUser),
            InputField("Введите пароль", size, myControllerForPass),
            Container(
              margin: EdgeInsets.all(size.height * 0.07),
            ),
            FlatButton(
              onPressed: () async {
                FirebaseDatabase.instance
                    .reference()
                    .child('Users')
                    .once()
                    .then((onValue) {
                  List data = onValue.value;
                  int length = 0;
                  if (data != null) {
                    length = data.length;
                  }
                  for (int i = 0; i < length; i++) {
                    myUser m = myUser.fromJson(data[i], i);
                    print("итерация");
                    if (m.login.toLowerCase() ==
                        myControllerForUser.text.toLowerCase()) {
                      if (m.password == myControllerForPass.text) {
                        print("enter");

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(m),
                          ),
                        );
                      }
                      return;
                    }
                  }
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Неверный логин или пароль!"),
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
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: BorderSide(color: Colors.blueGrey[300]),
              ),
              color: Colors.white,
              child: Text("Войти"),
            ),
            Container(
              height: size.height * 0.15,
            ),
            FlatButton(
              child: Text(
                "Нет аккаунта? Зарегистрируйтесь!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.indigo[400],
                ),
              ),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegPage(),
                  ),
                ),
              },
              //textColor: Colors.blue[300],
            )
          ],
        ),
      ),
    );
  }
}
