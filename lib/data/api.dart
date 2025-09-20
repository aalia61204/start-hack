import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import '../constants/keys.dart';

class Apis {

  fetchBankData() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> geminiApiPost(String prompt, List<Map<String, dynamic>> content) async {
    try {
      final res = await http.post(
        Uri.parse(geminibaseurl),
        body: jsonEncode(
          {
            "contents": content
          },
        ) 
      );
      if (res.statusCode == 200) {
        var data =  json.decode(res.body);
        return data['candidates'][0]['content']['parts'][0]['text'].toString();
      } else {
        debugPrint("API request failed with status: ${res.statusCode}, body: ${res.body}");
        return "Error: API request failed (${res.statusCode}).";
      }
    } on Exception catch (e) {
      return e.toString();
    }
  }


  Future<String> cohereApiPost(String prompt, List<Map<String, dynamic>> content) async {
    try {
      final res = await http.post(
        Uri.parse(coherebaseurl),
        body: jsonEncode(
          {
            "messages": content,
            "temperature": 0.3,
            "model": "command-a-03-2025"
          }
        ),
        headers: {
          "Authorization": "Bearer $cohereKey",
          "Content-Type": "application/json"
        }
      );
      if (res.statusCode == 200) {
        var data =  json.decode(res.body);
        return data['message']['content'][0]['text'].toString();
      } else {
        debugPrint("API request failed with status: ${res.statusCode}, body: ${res.body}");
        return "Error: API request failed (${res.statusCode}).";
      }
    } on Exception catch (e) {
      return e.toString();
    }
  }
}