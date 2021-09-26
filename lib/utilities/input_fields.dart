import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;
import 'package:startup_funding_prediction/utilities/object_converter.dart';

Future<Map<String, dynamic>> loadJsonFile(String name) async {
  var jsonString = await rootBundle.loadString(name);
  return ObjectToContainer.toJson(json.decode(jsonString));
}

List<String> textSuggestion(String pattern, List<String> options) {
  if (pattern == '') {
    return options;
  }
  List<String> suggestions = [];
  for (var str in options) {
    if (str.length >= pattern.length &&
        pattern.toLowerCase() ==
            str.substring(0, pattern.length).toLowerCase()) {
      suggestions.add(str);
    }
  }
  return suggestions.sublist(0, min(suggestions.length, 5));
}
