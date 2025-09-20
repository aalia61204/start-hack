import 'dart:convert';

import 'package:ai_finance_manager/model/bank_model.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class Apis {
  static String baseUrl = "https://firebasestorage.googleapis.com/v0/b/portfolio-6b6fb.appspot.com/o/finance%2Ffinancedata.json?alt=media&token=da02baaa-0959-4c93-b280-46e6594ae435";


  fetchBankData() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => BankModel.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

}