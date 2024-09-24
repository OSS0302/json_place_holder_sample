import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'data/02_http_api.dart';
import 'http_sample_state.dart';

// 17-Provider
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider<HttpSampleModel>(
        create: (_) => HttpSampleModel(),
        child: const HttpSampleScreen(),
      ),
    );
  }
}

// Screen (UI)
class HttpSampleScreen extends StatelessWidget {
  const HttpSampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HttpSampleModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('HttpSampleScreen'),
      ),
      body: Center(
        child: Text('${model.value.title} : ${model.value.body}'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        // model.fetchData();
        context.read<HttpSampleModel>().fetchData();
      }),
    );
  }
}

// Model (상태 & 로직)
class HttpSampleModel extends ValueNotifier<HttpSampleState> {
  HttpSampleModel() : super(HttpSampleState()) {
    fetchData();
  }

  // 로직


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
