import 'package:http/http.dart' as http;
import 'dart:convert';

class Content {
  List? data;
  Content(this.data);

  static Future<Content> connectAPI(String page) async {
    var apiURL =
        Uri.parse("https://the-lazy-media-api.vercel.app/api/games?page=$page");

    var result = await http.get(apiURL);
    var jsonObj = json.decode(result.body);
    var data = (jsonObj as List<dynamic>);

    return Content(data);
  }
}
