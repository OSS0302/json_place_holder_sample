import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'data/02_http_api.dart';

// 19-Bloc
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
      home: BlocProvider<HttpSampleModel>(
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('HttpSampleScreen'),
      ),
      body: Center(
        child: BlocBuilder<HttpSampleModel, HttpSampleState>(
          builder: (context, state) {
            return Text('${state.title} : ${state.body}');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        // model.fetchData();
        context.read<HttpSampleModel>().fetchData();
      }),
    );
  }
}

// Model (상태 & 로직)
class HttpSampleModel extends Cubit<HttpSampleState> {
  HttpSampleModel() : super(HttpSampleState()) {
    fetchData();
  }

  // 로직

  void fetchData() async {
    final jsonString = await getData();

    final jsonMap = jsonDecode(jsonString) as Map;

    // 상태 변경
    emit(state.copyWith(
      title: jsonMap['title'],
      body: jsonMap['body'],
    ));
  }
}

// State
class HttpSampleState {
  final String title;
  final String body;

  HttpSampleState({
    this.title = '',
    this.body = 'Loading',
  });

  HttpSampleState copyWith({
    String? title,
    String? body,
  }) {
    return HttpSampleState(
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}