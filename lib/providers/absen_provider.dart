import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes/api_key.dart';

class AbsenProvider {
  static Future createAbsen(String id) async {
    Uri url = Uri.parse(ApiKey.absenCreate);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    final response = await http.post(
      url,
      headers: headers,
      body: {'student_id': id},
    );
    final data = json.decode(response.body);
    print(data);
    return data;
  }
}
