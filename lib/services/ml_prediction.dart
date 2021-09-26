import 'dart:convert';
import 'package:http/http.dart' as http;

class XgboostRegressor {
  static Future<String> getPrediction(Map<String, String> data) async {
    var url =
        'http://46c8b230-5262-4b29-af8f-65f112b82121.centralindia.azurecontainer.io/score';
    var r = await http.post(Uri.parse(url), body: json.encode(data));
    if (r.statusCode == 200) {
      var jsonResponse = json.decode(json.decode(r.body));
      var preds = jsonResponse['xgr'];
      print(preds.toString());
      return preds.toString();
    } else {
      print(r.statusCode);
      return Future.error('Invalid Response');
    }
  }
}
