
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_place_holder_sample/data/02_http_api.dart';

class ModelSetState extends StatefulWidget {
  const ModelSetState({super.key});

  @override
  State<ModelSetState> createState() =>
      _ModelSetStateState();
}

class _ModelSetStateState
    extends State<ModelSetState> {
  final httpSampleModel =  HttpSampleModel();

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

              }
              return Text('title ${httpSampleModel.title} : body : ${httpSampleModel.body}');
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        getData().then((value) {
          setState(() {


           httpSampleModel.fetchData();
          });
        });
      }),
    );
  }
}

class HttpSampleModel with ChangeNotifier {
  // State
  String _title = '';
  String _body = 'Loading';

  String get title => _title;
  String get body => _body;

  HttpSampleModel() {
    fetchData();
  }


  void fetchData() async {
    final jsonString = await getData();

    final jsonMap = jsonDecode(jsonString) as Map;

    // 상태 변경
    _title = jsonMap['title'];
    _body = jsonMap['body'];


    notifyListeners();
  }
}
