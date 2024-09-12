
import 'package:http/http.dart' as http;

Future<String> getData() async{
  final url = (Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  final response = await http.get(url);
  return response.body;

}