import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stisla_flutter/page/add_category.dart';
import 'package:stisla_flutter/page/listpage.dart';
import 'package:stisla_flutter/page/login.dart';
import 'package:stisla_flutter/page/homepage.dart';
import 'package:stisla_flutter/page/register.dart';

void main() {
  runApp(MyApp());
  // runApp(
  //   MultiProvider(
  //     providers: [],
  //     child: const MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const LoginPage(),
        "/listpage": (context) => const ListPage(),
        "/homepage": (context) => const HomePage(),
        "/register": (context) => const RegisterPage(),
        "/addCategory": (context) => const CreateCategory(),
      },
      initialRoute: "/",
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
