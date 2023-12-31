import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter REST API Example',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter REST API Example'),
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: post,
            builder: (context, abc) {
              if (abc.hasData) {
                return Text(abc.data!.title);
              } else if (abc.hasError) {
                return Text("${abc.error}");
              }

              // By default, it show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

Future<Post> fetchPost() async {
  final uri = Uri.parse('https://randomuser.me/api/?results=5000');
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    // If the call to the server was successful (returns OK), parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String description;

  Post({this.userId = 0, this.id = 0, this.title = '', this.description = ''});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      // userId: json['email'],
      // id: json['id'],
      // title: json['name']('first'),
      description: json[' email'],
    );
  }
}
