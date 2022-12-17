import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stisla_flutter/Service/auth_service.dart';
import 'package:stisla_flutter/Service/globals.dart';

import 'package:http/http.dart' as http;
import 'package:stisla_flutter/page/homepage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:stisla_flutter/page/listpage.dart';
import 'package:stisla_flutter/page/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController __email =
      TextEditingController(text: "superadmin@gmail.com");
  TextEditingController __password = TextEditingController(text: "password");
  String? email_registered = '';
  String? pass_registered = '';

  shared() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    email_registered = sp.getString('email');
    pass_registered = sp.getString('password');

    __email.text =
        email_registered == '' ? "superadmin@gmail.com" : email_registered!;
    __password.text = pass_registered == '' ? "password" : pass_registered!;

    sp.remove('email');
    sp.remove('password');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shared();

    print(email_registered);
    print(pass_registered);
  }

  @override
  loginPressed() async {
    String email = __email.text;
    String password = __password.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      http.Response response =
          await AuthServices.login(__email.text, __password.text);
      Map responseMap = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomePage(),
          ),
          (route) => false,
        );
      } else {
        errorSnackBar(context, 'wrong email or password');
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
            Container(
              margin: EdgeInsets.all(15.0),
              width: double.infinity,
              height: 40,
              // convert button
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                  );
                },
                child: Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
