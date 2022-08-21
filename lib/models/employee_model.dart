import 'dart:convert';

//https://jsonplaceholder.typicode.com/users
List<Employee> employeeFromJson(String str) =>
    List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employee {
  int id;
  String name;
  String username;
  String email;

  Employee({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["email"],
        username: json["firstName"],
        email: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": name,
        "firstName": username,
        "lastName": email,
      };
}
