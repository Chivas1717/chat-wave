// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing fromJson', () {
    // contains all valid fields - will get parsed
    String input1 = '{"id": 0, "first_name": "Chahat", "last_name": "Gupta"}';
    User expected1 = User(id: 0, firstName: 'Chahat', lastName: 'Gupta');

    // contains all valid fields - will get parsed
    String input2 = '{"id": 0, "first_name": "Chahat", "last_name": null}';
    User expected2 = User(id: 0, firstName: 'Chahat', lastName: null);

    // missing [last_name] which is nullable - will get parsed
    String input3 = '{"id": 0, "first_name": "Chahat"}';
    User expected3 = User(id: 0, firstName: 'Chahat', lastName: null);

    // wrong [id] datatype - will not be parsed
    String input4 = '{"id": "0", "first_name": "Chahat", "last_name": "Gupta"}';

    // invalid JSON string - will not be parsed
    String input5 = '{"id": 0, "first_name": "Chahat", "last_name": Gupta}';

    test('Test case 1: All fields present',
        () => expect(User.fromJson(jsonDecode(input1)), expected1));

    test('Test case 2: last_name field null',
        () => expect(User.fromJson(jsonDecode(input2)), expected2));

    test('Test case 3: last_name field missing',
        () => expect(User.fromJson(jsonDecode(input3)), expected3));

    test(
        'Test case 4: id field has wrong datatype',
        () => expect(() => User.fromJson(jsonDecode(input4)),
            throwsA(isA<TypeError>())));

    test(
        'Test case 5: invalid JSON string',
        () => expect(() => User.fromJson(jsonDecode(input5)),
            throwsA(isA<FormatException>())));
  });
}

class User {
  final int id;
  final String firstName;
  final String? lastName;

  const User(
      {required this.id, required this.firstName, required this.lastName});

  factory User.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    String firstName = json['first_name'];
    String? lastName = json['last_name'];

    return User(id: id, firstName: firstName, lastName: lastName);
  }

  @override
  bool operator ==(Object other) =>
      other is User &&
      other.runtimeType == runtimeType &&
      other.id == id &&
      other.firstName == firstName &&
      other.lastName == lastName;
}
