// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:clean_architecture_template/features/chats/presentation/blocs/users/UsersUtils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('sorting test', () {
    var usersUtils = new UsersUtils();

    List<User> mockUsers = [
      User(username: "Bob"),
      User(username: "Charlie"),
      User(username: "Alice"),
    ];

    List<User> errorMockUsers = [
      User(username: null),
      User(username: "Charlie"),
      User(username: "Alice"),
    ];
    test(
        'Test case 1: All fields present. Sorting successful',
        () =>
            expect(usersUtils.getSortedUsers(mockUsers)[0].username, 'Alice'));
    test(
        'Test case 2: Username is null. Sorting failed',
        () => expect(() => usersUtils.getSortedUsers(errorMockUsers),
            throwsA(isArgumentError)));
  });
}
