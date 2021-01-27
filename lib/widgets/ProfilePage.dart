import 'package:flutter/material.dart';
import 'package:o4ki/models/User.dart';
import 'package:o4ki/widgets/InputField.dart';
import 'package:o4ki/widgets/ProgressBar.dart';

class ProfilePage extends StatefulWidget {
  final myUser user;
  final double summary;

  const ProfilePage({Key key, this.user, this.summary}) : super(key: key);

  @override
  _ProfilePageState createState() =>
      _ProfilePageState(user, new TextEditingController(), summary);
}

class _ProfilePageState extends State<ProfilePage> {
  final myUser iAm;
  final TextEditingController loginEdit;
  final double pointSummary;
  _ProfilePageState(this.iAm, this.loginEdit, this.pointSummary);

  @override
  Widget build(BuildContext context) {
    String pathToMyImage;
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
        title: Text("Профиль"),
        automaticallyImplyLeading: false,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
