import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/number_model.dart';

const String LIST_OF_INT_KEY = 'LIST_OF_INT_KEY';

class NumbersStorageController {
  Future<void> saveNumberList(List<NumberModel> listOfNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final dataToBeSaved = jsonEncode(
        listOfNumber.map((itemNumber) => itemNumber.toMap()).toList());
    await prefs.setString(LIST_OF_INT_KEY, dataToBeSaved);
  }

  Future<List<NumberModel>> loadNumbersList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? listString = prefs.getString(LIST_OF_INT_KEY);
    if (listString != null) {
      final dataFromStorage = (jsonDecode(listString) as List)
          .map<NumberModel>((numberMap) => NumberModel.fromMap(numberMap))
          .toList();
      return dataFromStorage;
    }
    return [];
  }

  Future<void> clearNumberList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
