import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data/02_http_api.dart';
import 'http_sample_state.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(HttpSampleModel());

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HttpSampleScreen(),
    );
  }
}

// Screen (UI)
class HttpSampleScreen extends StatelessWidget {
  final HttpSampleModel model = Get.find();

  HttpSampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HttpSampleScreen'),
      ),
      body: Center(
        child: Obx(() => Text('${model.state.value.title} : ${model.state.value.body}')),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        model.fetchData();
      }),
    );
  }
}

class HttpSampleModel extends GetxController {
  Rx<HttpSampleState> state = HttpSampleState().obs;

  HttpSampleModel() {
    fetchData();
  }



  void fetchData() async {
    final jsonString = await getData();

    final jsonMap = jsonDecode(jsonString) as Map;

    // 상태 변경
    state.value = state.value.copyWith(
      title: jsonMap['title'],
      body: jsonMap['body'],
    );
  }
}

