// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stisla_flutter/Service/auth_service.dart';
import 'package:stisla_flutter/Service/globals.dart';

import 'package:http/http.dart' as http;
import 'package:stisla_flutter/page/add_category.dart';
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
            Container(
              margin: EdgeInsets.all(15.0),
              width: 300,
              height: 40,
              // convert button
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateCategory(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Background color
                ),
                child: Text('Add Category'),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: cs.categoryList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<Category>? listCategories = snapshot.data;
                    print(listCategories);
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        var category = listCategories![index];
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                            } else {}
                            ;
                          },
                          background: Container(
                            color: Colors.green,
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: Colors.white),
                                Text('Edit Task',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          secondaryBackground: Container(
                            color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.delete, color: Colors.white),
                                Text('Delete Task',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          child: ListTile(
                            title: Container(
                              color: Colors.blueGrey[50],
                              padding: const EdgeInsets.all(20.0),
                              width: double.infinity,
                              child: Text(
                                category.name,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                    );

                    // return ListView();
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
