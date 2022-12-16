import 'package:http/http.dart' as http;

class HttpUtils {
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  static Future<http.Response> get(String url) async {
    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode > 299) {
      throw Exception(response.reasonPhrase);
    }
    return response;
  }

  static Future<http.Response> post(String url, dynamic body) async {
    var response =
        await http.post(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode > 299) {
      throw Exception(response.reasonPhrase);
    }
    return response;
  }

  static Future<http.Response> put(String url, dynamic body) async {
    var response = await http.put(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode > 299) {
      throw Exception(response.reasonPhrase);
    }
    return response;
  }

  static Future<http.Response> delete(String url, dynamic body) async {
    var response =
        await http.delete(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode > 299) {
      throw Exception(response.reasonPhrase);
    }
    return response;
  }
}
