import 'dart:convert';

List<QuestionModel> questionFromJson(String str) => List<QuestionModel>.from(
    json.decode(str).map((x) => QuestionModel.fromJson(x)));

String questionToJson(List<QuestionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionModel {
  final int faqId;
  final String question;
  final String answer;
  final String creationTime;
  //final bool? favorite;

  const QuestionModel({
    required this.faqId,
    required this.question,
    required this.answer,
    required this.creationTime,
    // this.favorite,
  });

  static QuestionModel fromJson(json) => QuestionModel(
        faqId: json['faqid'],
        question: json['question'],
        answer: json['answer'],
        creationTime: json['creationTime'],
        //favorite: json['favorite'],
      );

  factory QuestionModel.fromJson2(Map<String, dynamic> json) => QuestionModel(
        faqId: json['faqid'],
        question: json['question'],
        answer: json['answer'],
        creationTime: json['creationTime'],
      );

  Map<String, dynamic> toJson() => {
        "faqid": faqId,
        "question": question,
        "answer": answer,
        "creationTime": creationTime,
        //  "favorite": favorite,
      };
}
