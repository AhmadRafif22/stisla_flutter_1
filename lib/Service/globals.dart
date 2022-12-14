import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String baseUrl = "http://localhost:8000/api/";
// const String baseUrl = "http://192.168.72.205:8000/api/";
const Map<String, String> headers = {"Content-Type": "application/json"};

errorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
    content: Text(text),
    duration: const Duration(seconds: 1),
  ));
}
