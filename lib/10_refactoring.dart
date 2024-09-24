import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data/02_http_api.dart';
import 'http_sample_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final model = HttpSampleModel();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ListenableBuilder(
        listenable: model,
        builder: (BuildContext context, Widget? child) {
          return HttpSampleScreen(
            model: model,
          );
        },
      ),
    );
  }
}

// Screen (UI)
class HttpSampleScreen extends StatelessWidget {
  final HttpSampleModel model;

  const HttpSampleScreen({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HttpSampleScreen'),
      ),
      body: Center(
        child: Text('${model.value.title} : ${model.value.body}'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        model.fetchData();
      }),
    );
  }
}

// Model (상태 & 로직)
class HttpSampleModel extends ValueNotifier<HttpSampleState> {
  HttpSampleModel() : super(HttpSampleState()) {
    fetchData();
  }



  void fetchData() async {
    final jsonString = await getData();

    final jsonMap = jsonDecode(jsonString) as Map;

    // 상태 변경
    value = value.copyWith(
      title: jsonMap['title'],
      body: jsonMap['body'],
    );
  }
}

