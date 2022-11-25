import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stisla_flutter/Service/auth_service.dart';
import 'package:stisla_flutter/Service/globals.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:stisla_flutter/page/listpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController __email = new TextEditingController();
TextEditingController __password = new TextEditingController();

class _LoginPageState extends State<LoginPage> {
  void initState() {
    // TODO: implement initState
    super.initState();
    __email.text = "superadmin@gmail.com";
    __password.text = "password";
  }

  @override
  String _email = 'superadmin@gmail.com';
  String _password = 'password';

  loginPressed() async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      http.Response response = await AuthServices.login(_email, _password);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const ListPage(),
            ));
      } else {
        errorSnackBar(context, responseMap.values.first);
      }
    } else {
      errorSnackBar(context, 'enter all required fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "LOGIN FORM",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: __email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter valid email id as abc@gmail.com',
                ),
                onChanged: (value) {
                  _email = value;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: __password,
                // obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter secure password',
                ),
                onChanged: (value) {
                  _password = value;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(15.0),
              width: double.infinity,
              height: 40,
              // convert button
              child: ElevatedButton(
                onPressed: loginPressed,
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
