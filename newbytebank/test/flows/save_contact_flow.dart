import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:newbytebank/main.dart';
import 'package:newbytebank/models/Contact.dart';
import 'package:newbytebank/screens/contact_form.dart';
import 'package:newbytebank/screens/contacts_list.dart';
import 'package:newbytebank/screens/dashboard.dart';
import '../macthers/matchers.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  testWidgets('Should save a contact', (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp(contactDao: mockContactDao));
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);
    
    await clickOnTheTransferFeatureItem(tester);
    await tester.pumpAndSettle();

    final contactList = find.byType(ContactsList);
    expect(contactList, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    await tester.tap(fabNewContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    final nameTextField = find.byWidgetPredicate((widget) =>
        _textFieldMatcher(widget, 'Full name'));
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, 'Amanda');

    final accountNumberTextField = find.byWidgetPredicate((widget) =>
        _textFieldMatcher(widget, 'Account number'));
    expect(accountNumberTextField, findsOneWidget);
    await tester.enterText(accountNumberTextField, '1000');

    final createButton = find.widgetWithText(RaisedButton, 'Create');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();
    
    //verify(mockContactDao.save(Contact(0, 'Amanda', 1000)));

    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);

    verify(mockContactDao.findAll());
  });
}

bool _textFieldMatcher(Widget widget, String labelText) {
  if(widget is TextField)
    return widget.decoration.labelText == 'Full name';
  return false;
}