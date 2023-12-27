import 'package:clean_architecture_template/features/testing_users/full_widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Button text changes when pressed', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(builder: (BuildContext context) {
            return ToggleButton(
              onPressed: () {
                // This will not actually update the button's text because it is not connected to the state.
              },
              text: 'Show Details',
            );
          }),
        ),
      ),
    );

    expect(find.text('Show Details'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Hide Details'), findsNothing);
  });
}
