class myUser {
  String login, password, email;
  int color, points, id;
  myUser() {
    login = '';
    password = '';
    email = '';
    color = 2;
    points = 0;
    id = -1;
  }
  myUser.fromJson(Map map, int i) {
    id = i;
    login = map['Login'];
    password = map['Pass'];
    email = map['Email'];
    color = int.parse(map['Color'].toString());
    points = int.parse(map['Points']);
  }
}
