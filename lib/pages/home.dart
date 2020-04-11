import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

//set background
    bool isDayTime = data['isDayTime'];
    String bgImage = isDayTime ? 'day.jpg' : 'night.jpg';
    Color bgColor = isDayTime ? new Color(0Xff14557b) : new Color(0xFF14142b);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: () async {
                      dynamic result =
                          await Navigator.pushNamed(context, "/location");
                      if (result != null)
                        this.setState(() {
                          data = result;
                        });
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],
                    ),
                    label: Text(
                      "Edit location",
                      style: TextStyle(
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['location'],
                        style: TextStyle(
                          fontSize: 28,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 66,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
