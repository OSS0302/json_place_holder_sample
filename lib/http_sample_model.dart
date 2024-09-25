import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_place_holder_sample/http_sample_state.dart';

import 'data/02_http_api.dart';

class HttpSampleModel extends Notifier<HttpSampleState> {
  HttpSampleModel() {
    fetchData();
  }

  @override
  HttpSampleState build() => HttpSampleState();

  // 로직
  void fetchData() async {
    final jsonString = await getData();

    final jsonMap = jsonDecode(jsonString) as Map;

    // 상태 변경
    state = state.copyWith(
      title: jsonMap['title'],
      body: jsonMap['body'],
    );
  }
}

final modelNotifierProvider =
NotifierProvider<HttpSampleModel, HttpSampleState>(HttpSampleModel.new);