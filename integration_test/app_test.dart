import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:samsow/main.dart' as app;

void main(){
  group('App test ', (){
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('full app test', (WidgetTester tester) async{
      app.main();
      await tester.pumpAndSettle();

    });
  });
}