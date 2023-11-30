import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;

  NetworkHelper({required this.url});

  Future getData() async {
    var parsedUrl = Uri.parse(
      url,
    );
    var response = await http.get(parsedUrl);
    if (response.statusCode == 200) {
      var res = response.body;
      var decodedData = jsonDecode(res);
      return decodedData;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
