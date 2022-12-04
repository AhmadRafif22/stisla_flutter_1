// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stisla_flutter/Service/auth_service.dart';
import 'package:stisla_flutter/Service/globals.dart';

import 'package:http/http.dart' as http;
import 'package:stisla_flutter/page/listpage.dart';
import 'dart:convert';

import 'package:stisla_flutter/page/login.dart';

import '../Service/category_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<CategoryService>.categoryList();
  }

  logoutPressed() async {
    http.Response response = await AuthServices.logout();

    if (response.statusCode == 204) {
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
            builder: (BuildContext context) => const HomePage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "Stisla Flutter",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              margin: EdgeInsets.all(15.0),
              width: 300,
              height: 40,
              // convert button
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListPage()),
                  );
                },
                child: Text('Category List'),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15.0),
              width: 300,
              height: 40,
              // convert button
              child: ElevatedButton(
                onPressed: logoutPressed,
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Background color
                ),
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
