import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

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

  static Future<Response> CreateCategory(
    String name,
  ) async {
    var url = Uri.parse(baseUrl + 'categories');

    SharedPreferences sp = await SharedPreferences.getInstance();

    String? token = await sp.getString("token");

    if (token == null) {
      throw new Exception('ERROR TOKEN NULL');
    }

    Map data = {
      'name': name,
    };

    http.Response response = await http.post(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Accept": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: data,
    );

    // var jsonObject = json.decode(response.body);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to Create Category.');
    }
  }

  Future<Response> deleteCategory(Category category) async {
    var url = Uri.parse(baseUrl + 'categories/${category.id}');

    SharedPreferences sp = await SharedPreferences.getInstance();

    String? token = await sp.getString("token");

    if (token == null) {
      throw new Exception('ERROR TOKEN NULL');
    }

    final headers = {
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    final response = await delete(
      url,
      headers: headers,
    );

    print(response.statusCode);

    return response;
  }
}
