import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location  name for the UI
  String time; // the time in that location
  String flag; //url to an asset flag icon
  String url; // location url fro api endpoint
  bool isDayTime; // true or false if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      //make the request
      Response response =
          await get("http://worldtimeapi.org/api/timezone/$url");
      Map data = jsonDecode(response.body);

      String dateTime = data['utc_datetime'];
      String offset = data["utc_offset"].toString().substring(0, 3);
      int hours = int.parse(offset);

      //Create DateTime object
      DateTime now = DateTime.parse(dateTime);

      now = now.add(Duration(hours: hours));

      //Set the time propery
      isDayTime = now.hour > 6 && now.hour < 20;

      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = 'Could not get time data';
    }
  }
}
