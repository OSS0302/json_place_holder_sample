import 'package:flutter/material.dart';
import 'package:json_place_holder_sample/02_http_sample_screen.dart';

import '03_stateful_future.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StatefulFutureScreen(),
    );
  }
}


