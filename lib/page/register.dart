// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stisla_flutter/Service/auth_service.dart';
import 'package:stisla_flutter/Service/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:stisla_flutter/page/login.dart';

import '../Service/register_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController __name =
      TextEditingController(text: "Ahmad Rafif Alaudin");
  TextEditingController __email =
      TextEditingController(text: "superadmin@gmail.com");
  TextEditingController __password = TextEditingController(text: "password");
  TextEditingController __confirm = TextEditingController(text: "password");
  TextEditingController __device_name = TextEditingController(text: "Desktop");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  registerPressed() async {
    http.Response response = await RegisterService.CreateUser(
      __name.text,
      __email.text,
      __password.text,
      __confirm.text,
      __device_name.text,
    );

    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginPage(),
        ),
        (route) => false,
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const RegisterPage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "REGISTER FORM",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: __name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter your name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: __email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter  ',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: __password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter a secure password',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: __confirm,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                  hintText: 'confirm the password',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: __device_name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Device Name',
                  hintText: 'Enter device name',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15.0),
              width: 300,
              height: 40,
              // convert button
              child: ElevatedButton(
                onPressed: () {
                  registerPressed();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Background color
                ),
                child: Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
