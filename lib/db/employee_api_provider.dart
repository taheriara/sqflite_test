import 'dart:convert';

import 'package:sql_test/db/db_provider.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import 'package:sql_test/models/question_model.dart';

class EmployeeApiProvider {
  Future<List<QuestionModel?>> getAllQuestion2() async {
    const url = "https://almiqat.com/api/faq/GetFAQsBetweenTwoID?LastFAQId=5";
    Response response = await Dio().get(url);
    // print('=*=*=*=*==*=*: ${response.data["data"]}');

    return (response.data["data"] as List).map((employee) {
      print('Inserting%%%% $employee');
      DBProvider.db.createQuestion(employee);
    }).toList();

    List<QuestionModel> ques = [];

    return ques;
  }

  Future<List<QuestionModel>> getAllQuestion() async {
    const url = "https://almiqat.com/api/faq/GetFAQsBetweenTwoID?LastFAQId=10";
    // final response = await http.get(Uri.parse(url));

    // var url = "https://jsonplaceholder.typicode.com/users";
    //Response response = await Dio().get(url);

    final response = await http.get(Uri.parse(url));

    print('one---');

    List<QuestionModel> ques = [];
    if (response.statusCode == 200) {
      print('statue is 200');
      final Map newData = jsonDecode(response.body);
      ques =
          newData["data"].map<QuestionModel>(QuestionModel.fromJson).toList();
      // print('ooooooo: ${newData["data"].toString()}');

      // return (newData["data"]).map((question) {
      //   print('Inserting**-------**');
      //   DBProvider.db.createQuestion(QuestionModel.fromJson(question));
      // }).toList();
      for (var element in ques) {
        DBProvider.db.createQuestion(element);
      }
    }
    print('llllllll: ${ques.length}');
    return ques;
  }
}
