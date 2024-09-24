
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_place_holder_sample/data/02_http_api.dart';
import 'package:json_place_holder_sample/http_sample_state.dart';

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
              return Text('title ${httpSampleModel.state.title} : body : ${httpSampleModel.state.body}');
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

// Model (상태 & 로직)
class HttpSampleModel with ChangeNotifier {
  // State (Value)
  HttpSampleState _state = HttpSampleState();

  HttpSampleState get state => _state;

  HttpSampleModel() {
    fetchData();
  }



  void fetchData() async {
    final jsonString = await getData();

    final jsonMap = jsonDecode(jsonString) as Map;

    // 상태 변경
    _state = state.copyWith(
      title: jsonMap['title'],
      body: jsonMap['body'],
    );

    // 외부에 알려주자
    notifyListeners();
  }
}

