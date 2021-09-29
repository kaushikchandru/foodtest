import 'package:foodtest/Model/FoodListModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
Future<FoodListModel> getAllFoodItems() async{
  var url = Uri.parse('https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad');
  var response = await http.get(url);
  var convert = json.decode(response.body);

  FoodListModel returnVal = FoodListModel.fromJson(convert[0]);

  return returnVal;
}