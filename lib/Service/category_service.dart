import 'dart:convert';
import 'dart:io';

import '../models/category.dart';
import 'globals.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryService {
  static Future<List<Category>> categoryList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    String? token = sp.getString("token");

    var url = Uri.parse(baseUrl + 'categories');

    final header = {
      'Authorization': 'Bearer $token',
    };

    var apiResult = await http.get(
      url,
      headers: header,
    );

    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listCategory = (jsonObject as Map<String, dynamic>)['data'];

    List<Category> categories = [];
    for (int i = 0; i < listCategory.length; i++) {
      categories.add(Category.createCategory(listCategory[i]));
    }

    return categories;
  }
}
