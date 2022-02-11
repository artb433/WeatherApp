import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;

      var temp = jsonDecode(data)['main']['temp'];

      var condition = jsonDecode(data)['weather'][0]['id'];
      return jsonDecode;
    } else if (response.statusCode >= 400) {
    } else {}
  }
}
