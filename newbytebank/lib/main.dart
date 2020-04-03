import 'package:flutter/material.dart';
import 'package:newbytebank/database/app_database.dart';
import 'package:newbytebank/models/Contact.dart';
import 'package:newbytebank/screens/contact_form.dart';
import 'package:newbytebank/screens/contacts_list.dart';
import 'package:newbytebank/screens/dashboard.dart';

void main() {
  runApp(BytebankApp());
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

