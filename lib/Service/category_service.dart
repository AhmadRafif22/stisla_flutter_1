import 'dart:convert';
import 'dart:io';

import '../models/category.dart';
import 'globals.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryService {
  Future<List<Category>> categoryList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    String? token = await sp.getString("token");

    if (token == null) {
      throw new Exception('ERROR TOKEN NULL');
    }

    var url = Uri.parse(baseUrl + 'categories');

    final apiResult = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    final payload = (jsonDecode(apiResult.body)['data'] as List);

    return payload.map((e) => Category.fromJson(e)).toList();
  }
}
