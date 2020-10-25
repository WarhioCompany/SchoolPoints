import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:o4ki/models/User.dart';
import 'package:o4ki/widgets/ProfilePage.dart';

class IHateDartForThis {
  List<myUser> users;
  IHateDartForThis(this.users);
}

class MainPage extends StatefulWidget {
  final myUser me;
  MainPage(this.me);
  @override
  _MainPageState createState() =>
      _MainPageState(new IHateDartForThis(new List<myUser>()), me);
}

IHateDartForThis usersMainPage = new IHateDartForThis(new List<myUser>());

class _MainPageState extends State<MainPage> {
  final myUser iAm;
  double userPointsFromSummary;
  _MainPageState(this.users, this.iAm) {
    initUsers();
  }

  // return CircularProgressIndicator();
  initUsers() {
    FirebaseDatabase.instance.reference().child('Users').once().then((onValue) {
      List data = onValue.value;
      int length = 0;
      if (data != null) {
        length = data.length;
      }

      users.users.clear();

      double pointSummary = 0;
      for (int i = 0; i < length; i++) {
        setState(() {
          users.users.add(myUser.fromJson(data[i], i));
          pointSummary += int.parse(data[i]['Points']);
          if (i == iAm.id) {
            iAm.login = data[i]['Login'];
            iAm.password = data[i]['Pass'];
            iAm.email = data[i]['Email'];
            iAm.color = int.parse(data[i]['Color'].toString());
            iAm.points = int.parse(data[i]['Points']);
          }
        });
      }
      userPointsFromSummary = iAm.points / pointSummary;
    });
  }

  final IHateDartForThis users;
  //_MainPageState()
  @override
  Widget build(BuildContext context) {
    initUsers();
    String pathToMyImage = 'images/greencar.png';
    Color circleColor = Colors.black;
    if (iAm.color == 0) {
      pathToMyImage = 'images/orangecar.png';
      circleColor = Colors.orange[600];
    } else if (iAm.color == 1) {
      pathToMyImage = 'images/bluecar.png';
      circleColor = Colors.indigo;
    } else if (iAm.color == 2) {
      pathToMyImage = 'images/greencar.png';
      circleColor = Colors.green;
    } else if (iAm.color == 3) {
      pathToMyImage = 'images/blue-greencar.png';
      circleColor = Colors.blue[300];
    } else if (iAm.color == 4) {
      pathToMyImage = 'images/pinkcar.png';
      circleColor = Colors.pink;
    } else if (iAm.color == 5) {
      pathToMyImage = 'images/yellowcar.png';
      circleColor = Colors.yellow;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Рейтинг"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      user: iAm,
                    ),
                  ),
                );
              },
              child: Icon(Icons.person),
            ),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.blueGrey[100],
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.025),
                        child: Container(
                          child: Center(child: Text(iAm.login)),
                        ),
                        height: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: circleColor, width: 1)),
                      ),
                      Image.asset(
                        pathToMyImage,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.025),
                        child: Container(
                          child: Center(child: Text(iAm.points.toString())),
                        ),
                        height: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: circleColor, width: 1)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: users.users.length,
                itemBuilder: (context, index) {
                  users.users.sort((a, b) => b.points.compareTo(a.points));
                  List<myUser> filteredUsers;
                  filteredUsers = users.users;

                  int c = filteredUsers[index].color;

                  String pathtoImage;

                  if (c == 0) {
                    pathtoImage = 'images/orangecar.png';
                  } else if (c == 1) {
                    pathtoImage = 'images/bluecar.png';
                  } else if (c == 2) {
                    pathtoImage = 'images/greencar.png';
                  } else if (c == 3) {
                    pathtoImage = 'images/blue-greencar.png';
                  } else if (c == 4) {
                    pathtoImage = 'images/pinkcar.png';
                  } else if (c == 5) {
                    pathtoImage = 'images/yellowcar.png';
                  }

                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey[300]),
                    ),
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          Column(
                            children: [
                              Text(
                                filteredUsers[index].login,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                filteredUsers[index].points.toString(),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                              ),
                              Image.asset(
                                pathtoImage,
                                width: MediaQuery.of(context).size.width * 0.3,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      //     ),
      //   ],
      // ),

      //   ),

      //Card(),
      //),
    );
  }
}
