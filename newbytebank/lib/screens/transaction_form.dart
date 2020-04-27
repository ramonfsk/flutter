import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newbytebank/component/progress.dart';
import 'package:newbytebank/component/response_dialog.dart';
import 'package:newbytebank/component/transaction_auth_dialog.dart';
import 'package:newbytebank/http/webclients/transaction_webclient.dart';
import 'package:newbytebank/models/Contact.dart';
import 'package:newbytebank/models/Transaction.dart';
import 'package:newbytebank/widgets/app_dependencies.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final String transactionId = Uuid().v4();
  final TextEditingController _valueController = TextEditingController();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    print('transaction form id $transactionId');
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress(message: 'Sending...',),
                ),
                visible: _sending,
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'), onPressed: () {
                      final double value = double.tryParse(_valueController.text);
                      final transactionCreated = Transaction(transactionId, value, widget.contact);
                      showDialog(context: context, builder: (contextDialog) {
                        return TransactionAuthDialog(onConfirm: (String password) {
                          _save(dependencies.transactionWebClient, transactionCreated, password, context);
                        },);
                      });

                  },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(TransactionWebClient webClient, Transaction transactionCreated, String password, BuildContext context) async {
    Transaction transaction = await _send(
        webClient,
        transactionCreated,
        password,
        context
    );

    _showSuccessfulMessage(transaction, context);
  }

  Future _showSuccessfulMessage(Transaction transaction, BuildContext context) async {
    if(transaction != null) {
      await showDialog(
        context: context,
        builder: (contextDialog) {
          return SuccessDialog('successful transaction');
      });
      Navigator.pop(context);
    }
  }

  Future<Transaction> _send(TransactionWebClient webClient, Transaction transactionCreated, String password, BuildContext context) async {
    setState(() {_sending = true;});
    final Transaction transaction = await webClient.save(transactionCreated, password)
      .catchError((e) {
        _showFailureMessage(context, message: e.message);
      }, test: (e) => e is HttpException)
      .catchError((e) {
        _showFailureMessage(context, message: 'timeout submitting the transaction');
      }, test: (e) => e is TimeoutException)
      .catchError((e) {
        _showFailureMessage(context);
      })
      .whenComplete(() {
        setState(() {_sending = false;});
      });
    return transaction;
  }

  void _showFailureMessage(BuildContext context, {String message = 'Unknown error'}) {
    showDialog(
      context: context,
      builder: (contextDialog) {
        return FailureDialog(message);
      });
  }
}
