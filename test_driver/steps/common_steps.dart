import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric whenFieldFill() {
  return when2<String, String, FlutterWorld>(
    'I fill the {word} field with the content {string}',
    (key, value, context) async {
      final input = find.byValueKey('$key-input');

      await FlutterDriverUtils.enterText(context.world.driver, input, value);
    },
  );
}

StepDefinitionGeneric whenButtonClick() {
  return when1<String, FlutterWorld>(
    'I click the button {word}',
    (key, context) async {
      final button = find.byValueKey('$key-button');

      await FlutterDriverUtils.tap(context.world.driver, button);
    },
  );
}

StepDefinitionGeneric thenFieldErrorDisplayed() {
  return then1<String, FlutterWorld>(
    'I should see the {word} field error message',
    (key, context) async {
      final input = find.byValueKey('$key-input');
      final error = find.descendant(of: input, matching: find.byType('_HelperError'));

      context.expect(await FlutterDriverUtils.isPresent(context.world.driver, error), true);
    },
  );
}

StepDefinitionGeneric thenErrorAlertDisplayed() {
  return then<FlutterWorld>(
    'I should see a error alert',
    (context) async {
      await FlutterDriverUtils.waitUntil(
        context.world.driver,
        () {
          return FlutterDriverUtils.isPresent(
            context.world.driver,
            find.byValueKey('alert-dialog'),
          );
        },
      );
    },
  );
}
