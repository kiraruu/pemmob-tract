import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tract/models/activity.dart';

class API {
  static Future<Activity> fetchRandomActivity() async {
    final response = await http.get(
      Uri.parse(
          'https://cors-anywhere.herokuapp.com/https://bored-api.appbrewery.com/random'),
      headers: {
        'Origin': 'your-origin',
      },
    );
    if (response.statusCode == 200) {
      return Activity.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load random activity');
    }
  }
}
