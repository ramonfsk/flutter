import 'package:flutter/material.dart';
import 'package:newbytebank/database/dao/contact_dao.dart';
import 'package:newbytebank/http/webclients/transaction_webclient.dart';
import 'package:newbytebank/screens/dashboard.dart';
import 'package:newbytebank/widgets/app_dependencies.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(BytebankApp(
    contactDao: ContactDao(),
    transactionWebClient: TransactionWebClient(),
  ));
}
    
class BytebankApp extends StatelessWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;
  BytebankApp({
    @required this.contactDao,
    @required this.transactionWebClient
  });

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDao: contactDao,
      transactionWebClient: transactionWebClient,
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.green[900],
            accentColor: Colors.blueAccent[700],
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.blueAccent[700],
              textTheme: ButtonTextTheme.primary,
          )
        ),
        home: Dashboard()
      ),
    );
  }
}

