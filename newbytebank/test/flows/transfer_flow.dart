import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:newbytebank/component/response_dialog.dart';
import 'package:newbytebank/component/transaction_auth_dialog.dart';
import 'package:newbytebank/main.dart';
import 'package:newbytebank/models/Contact.dart';
import 'package:newbytebank/models/Transaction.dart';
import 'package:newbytebank/screens/contacts_list.dart';
import 'package:newbytebank/screens/dashboard.dart';
import 'package:newbytebank/screens/transaction_form.dart';
import '../macthers/matchers.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  testWidgets('Should transfer to a contact', (tester) async {
    final mockContactDao = MockContactDao();
    final mockTransactionWebClient = MockTransactionWebClient();
    await tester.pumpWidget(BytebankApp(
        contactDao: mockContactDao,
      transactionWebClient: mockTransactionWebClient,
    ));
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final amanda = Contact(0, 'Amanda', 1000);
    when(mockContactDao.findAll()).thenAnswer((invocation) async => [amanda]);

    await clickOnTheTransferFeatureItem(tester);
    await tester.pumpAndSettle();

    final contactList = find.byType(ContactsList);
    expect(contactList, findsOneWidget);

//    when(mockContactDao.findAll()).thenAnswer((invocation) async {
//      debugPrint('name invocation ${invocation.memberName}');
//      return [Contact(0, 'Amanda', 1000)];
//    });

    verify(mockContactDao.findAll()).called(1);

    final contactItem = find.byWidgetPredicate((widget) {
      if(widget is ContactItem)
        return widget.contact.name == 'Amanda' && widget.contact.accountNumber == 1000;
      return false;
    });
    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

    final contactName = find.text('Amanda');
    expect(contactName, findsOneWidget);
    final contactAccountNumber = find.text('1000');
    expect(contactAccountNumber, findsOneWidget);

    final textFieldValue = find.byWidgetPredicate((widget){
      return textFieldByLabelText(widget, 'Value');
    });
    expect(textFieldValue, findsOneWidget);
    await tester.enterText(textFieldValue, '200');

    final transferButton = find.widgetWithText(RaisedButton, 'Transfer');
    expect(transferButton, findsOneWidget);
    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final transactionAuthDialog = find.byType(TransactionAuthDialog);
    expect(transactionAuthDialog, findsOneWidget);

    final textFieldPassword = find.byKey(transactionAuthDialogTextFieldPasswordKey);
    expect(textFieldPassword, findsOneWidget);
    await tester.enterText(textFieldPassword, '1000');

    final cancelButton = find.widgetWithText(FlatButton, 'Cancel');
    expect(cancelButton, findsOneWidget);
    final confirmButton = find.widgetWithText(FlatButton, 'Confirm');
    expect(confirmButton, findsOneWidget);

    when(mockTransactionWebClient.save(Transaction(null, 200, amanda), '1000'))
        .thenAnswer((_) async => Transaction(null, 200, amanda));

    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    final okButton = find.widgetWithText(FlatButton, 'Ok');
    expect(okButton, findsOneWidget);
    await tester.tap(okButton);
    await tester.pumpAndSettle();

    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);
  });
}