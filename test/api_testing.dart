import 'package:flutter/material.dart';
import 'package:flutter_ioc_container/flutter_ioc_container.dart';
import 'package:flutter_test/flutter_test.dart';

///Gets data from an external API. We can't call this in our widget tests
///because it makes a HTTP call
class ApiService {
  double getForecast() => 50;
}

///Mock implementation of the [ApiService]. This is safe to call in widget tests
class MockApiService implements ApiService {
  @override
  double getForecast() => 86;
}

void main() {
  testWidgets('Fetch the forecast and display it on the screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      CompositionRoot(
        compose: (builder) =>
            //Use the mock implementation of the [ApiService] instead of the real one
            builder.addSingletonService<ApiService>(MockApiService()),
        child: Builder(
          builder: (context) => MaterialApp(
            home: Scaffold(
              //Grab the dependency from the widget tree and get forecast
              body: Text('Forecast ${context<ApiService>().getForecast()} °F'),
            ),
          ),
        ),
      ),
    );

    //Verify that we see the mock textt
    expect(find.text('Forecast 86.0 °F'), findsOneWidget);

    //And that we don't see the text from the real API call
    expect(find.text('Forecast 50.0 °F'), findsNothing);
  });
}
