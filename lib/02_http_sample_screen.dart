import 'package:flutter/material.dart';
import 'package:json_place_holder_sample/data/02_http_api.dart';

class HttpSampleScreen extends StatefulWidget {

  const HttpSampleScreen({super.key});

  @override
  State<HttpSampleScreen> createState() => _HttpSampleScreenState();
}

class _HttpSampleScreenState extends State<HttpSampleScreen> {
  String body = 'Loading';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HttpSampleScreen'),
      ),
      body: Center(child: Text(body)),
      floatingActionButton: FloatingActionButton(onPressed: () {
        // getData().then((value){
        //   print(value);
        // });

         getData().then((value){
           setState(() {
           body = value;
         });
        });

      }),
    );
  }
}
