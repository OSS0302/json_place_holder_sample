
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_place_holder_sample/data/02_http_api.dart';

class JsonStringScreen extends StatefulWidget {
  const JsonStringScreen({super.key});

  @override
  State<JsonStringScreen> createState() =>
      _JsonStringScreenState();
}

class _JsonStringScreenState
    extends State<JsonStringScreen> {

  String title = '';
  String body = 'Loading';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HttpSampleScreen'),
      ),
      body: Center(
        child: FutureBuilder<String>(
            future: getData(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                final jsonString = snapshot.data!;
                final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
                title = jsonMap['title'];
                body = jsonMap['body'];
              }
              return Text('title $title / body : $body');
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        getData().then((value) {
          setState(() {
            // final jsonMap = jsonDecode(value) as Map<String, dynamic>;;
            // title = jsonMap['title'];
            // body = jsonMap['body'];
            body =  value;
          });
        });
      }),
    );
  }
}
