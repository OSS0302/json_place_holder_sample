import 'package:flutter/material.dart';
import 'package:json_place_holder_sample/data/02_http_api.dart';

class StatefulFutureBuilderScreen extends StatefulWidget {
  const StatefulFutureBuilderScreen({super.key});

  @override
  State<StatefulFutureBuilderScreen> createState() =>
      _StatefulFutureBuilderScreenState();
}

class _StatefulFutureBuilderScreenState
    extends State<StatefulFutureBuilderScreen> {


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
              body = snapshot.data!;
            }
            return Text(body);
          }
        ),
      ),
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
