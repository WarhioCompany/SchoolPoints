import 'dart:developer';

class myUser {
  String login, password, email;
  int color, points, id;
  bool admin;
  myUser() {
    login = '';
    password = '';
    email = '';
    color = 2;
    points = 0;
    id = -1;
    admin = false;
  }
  myUser.fromJson(Map map, int i) {
    id = i;
    login = map['Login'];
    password = map['Pass'];
    email = map['Email'];
    admin = map['Admin'] == 'true';
    color = int.parse(map['Color'].toString());
    points = int.parse(map['Points']);
  }
}
