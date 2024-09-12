import 'package:flutter/material.dart';
import 'package:json_place_holder_sample/data/02_http_api.dart';

class StatefulFutureScreen extends StatefulWidget {
  const StatefulFutureScreen({super.key});

  @override
  State<StatefulFutureScreen> createState() => _StatefulFutureScreenState();
}

class _StatefulFutureScreenState extends State<StatefulFutureScreen> {

  // 화면 최초로 그려질때 사용 한다
  @override
  void initState() {
    super.initState();
    getData().then((data) {
      setState(() {
        body = data;
      });

    });
  }

  String body = 'Loading';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HttpSampleScreen'),
      ),
      body: Center(child: Text(body)),
      floatingActionButton: FloatingActionButton(onPressed: () {
        getData().then((value) {
          setState(() {
            body = value;
          });
        });
      }),
    );
  }
}
