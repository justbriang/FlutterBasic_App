import 'dart:convert';

import 'package:flutterbasic/config.dart';
import 'package:flutterbasic/core/api/exception_handler.dart';
import 'package:flutterbasic/core/models/response.dart';
import 'package:http/http.dart' as http;

class BaseApi {
  Future<List<Response>> getResponses() async {
    try {
      var response =
          await http.get(Uri.parse("${Config.baseUrl}/todos?_limit=10"));

      var responseMap = jsonDecode(response.body);

      List<Response> responseList = (responseMap as List)
          .map((itemWord) => Response.fromJson(itemWord))
          .toList();

      return responseList;
    } catch (ex) {
      throw ExceptionHandler(ex);
    }
  }

  bool isNumeric(String? string) {
    int intValue;

    if (string == null || string.isEmpty) {
      return false;
    }

    try {
      intValue = int.parse(string);
      return true;
    } catch (e) {
      print("Input String cannot be parsed to Integer.");
    }
    return false;
  }

  Map<String,dynamic> getDictionary() {
    List<int> num = [];
    List<String> notNum = [];
    Config.dictionary.forEach((key, value) {
      isNumeric(key) ? num.add(int.parse(key)) : notNum.add(key);
    });
    // Function to sort the strings based
// on their ASCII values
    notNum = sortString(notNum);

// Function to sort the numeric values
    num.sort();

//List to  combine the two sorted lists
    List<String> combined = [];
//combining the two lists
    num.forEach((element) {
      combined.add(element.toString());
    });
    combined.addAll(notNum);

//using the sorted list to get key value of dictionary in a sorted manner

    Map<String, dynamic> sortedMap = {};
    combined.forEach((element) {
      sortedMap[element] = Config.dictionary[element];
    });

    return sortedMap;
  }



// Function to sort the string based
// on their ASCII values
  List<String> sortString(List<String> s) {
    for (int j = 0; j < s.length - 1; j++) {
      // Checking the condition for two
      // simultaneous elements of the array
      if (s[j].codeUnitAt(0) > s[j + 1].codeUnitAt(0)) {
        // Swapping the elements.
        String temp = s[j];
        s[j] = s[j + 1];
        s[j + 1] = temp;

        j = -1;
      }
    }

    return s;
  }
}
