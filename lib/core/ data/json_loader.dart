import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class JsonLoader {
  Future<List<Map<String, dynamic>>> loadJson() async {
    final String response = await rootBundle.loadString('assets/adhkar.json');
    final data = json.decode(response);
    if (data is List) {
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception("The JSON structure is not as expected");
    }
  }
}
