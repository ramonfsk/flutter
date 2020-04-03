import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _titleAppBar = 'Criando Transferência';

const _labelInputNumBalance = 'Número da conta';
const _tipInputNumBalance = '0000';
const _labelInputValue = 'Valor';
const _tipInputValue = '0.00';

const _txtButtonOk = 'Confirmar';

class FormOfTransfer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormOfTransferState();
  }
}

class FormOfTransferState extends State<FormOfTransfer> {
  final TextEditingController _numBalanceInputController = TextEditingController();
  final TextEditingController _valueInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titleAppBar),),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
                controller: _numBalanceInputController,
                label: _labelInputNumBalance,
                tip: _tipInputNumBalance
            ),
            Editor(
                controller: _valueInputController,
                label: _labelInputValue,
                tip: _tipInputValue,
                icon: Icons.monetization_on
            ),
            RaisedButton(
              onPressed: () => _createTransfer(context),
              child: Text(_txtButtonOk),
            )
          ],
        ),
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final int numBalance = int.tryParse(_numBalanceInputController.text);
    final double value = double.tryParse( _valueInputController.text);
    if(numBalance != null && value != null) {
      final newTransfer = Transfer(value, numBalance);
      Navigator.pop(context, newTransfer);
    }
  }
}