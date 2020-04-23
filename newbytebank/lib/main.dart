import 'package:flutter/material.dart';
import 'package:newbytebank/http/webclient.dart';
import 'package:newbytebank/models/Contact.dart';
import 'package:newbytebank/models/Transaction.dart';
import 'package:newbytebank/screens/dashboard.dart';

void main() {
  runApp(BytebankApp());
  //save(Transaction(200.0, Contact(0, 'Gui', 2000))).then((transaction) => print(transaction));
  //findAll().then((transactions) => print('new transactions: ${transactions}'));
}
    
class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
        )
      ),
      home: Dashboard()
    );
  }
}

