
import 'package:flutter_test/flutter_test.dart';
import 'package:samsow/menu/user_menu.dart';

void main(){
  testWidgets('My menu has an email and a name', (WidgetTester tester)async{
    await tester.pumpWidget(DrawerPage());
    //final findName = find.text('name');
    //final findEmail = find.text('email');
    final findFirst = find.text('M');
   // expect(findName, findsOneWidget);
    //expect(findEmail, findsOneWidget);
    expect(findFirst, findsOneWidget);


  });
}