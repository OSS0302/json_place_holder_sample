
void main() async {
  print(getData().toString());
  getData().then((value) => print(value));

  final result = await getData();

  print('end : $result');
}
 // 비동기 에서는 async를 사용 하고 살행할 비지니스 로직 에 await 사용
Future<String> getData() async {
  // 2초 대기 한 후 보여주기
  await Future.delayed(Duration(seconds: 2));
  return 'hello';
}