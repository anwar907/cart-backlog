import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todos/data/models/todo_models.dart';
import 'package:todos/data/repository/url_list.dart';

Future<List<TodoModels>> getListDataTodo() async {
  List<TodoModels> list = [];
  var response = await http.get(Uri.parse(UrlList.baseUrl + UrlList.todo));

  var result = json.decode(response.body);

  if (result == '') {
    return null;
  } else {
    for (Map<String, dynamic> data in result) {
      list.add(TodoModels.fromJson(data));
    }
    return list;
  }
}
