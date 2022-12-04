// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stisla_flutter/Service/auth_service.dart';
import 'package:stisla_flutter/Service/globals.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:stisla_flutter/page/login.dart';

import '../Service/category_service.dart';
import '../models/category.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  List<Category> listCategories = [];
  final cs = CategoryService();

  getData() async {
    listCategories = await cs.categoryList();
  }

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Category"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(),
            Expanded(
              child: FutureBuilder(
                future: cs.categoryList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView(
                      children: (snapshot.data ?? [])
                          .map(
                            (e) => Card(
                              margin: EdgeInsets.all(4.0),
                              color: Colors.blueGrey[50],
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(e.name),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
