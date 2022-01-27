import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:todos/data/repository/url_list.dart';

void main() {
  test('test response API', () async {
    var response = await http.get(Uri.parse(UrlList.baseUrl + UrlList.todo));
    print(response.body);
  });
}
