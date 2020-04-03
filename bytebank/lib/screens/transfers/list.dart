import 'package:bytebank/models/transfer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'form.dart';

const _titleAppBar = 'Transferências';

class ListOfTransfers extends StatefulWidget {
  final List<Transfer> _transfers = List();

  @override
  State<StatefulWidget> createState() {
    return ListTransfersState();
  }
}

class ListTransfersState extends State<ListOfTransfers> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),
      body: ListView.builder(
        itemCount: widget._transfers.length,
        itemBuilder: (context, index) {
          return ItemOfTransfer(widget._transfers[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormOfTransfer();
          })).then((receivedTransfer) => _refresh(receivedTransfer));
        },
      ),
    );
  }

  void _refresh(Transfer receivedTransfer) {
    if(receivedTransfer != null) {
      setState(() {
        widget._transfers.add(receivedTransfer);
      });
    }
  }
}

class ItemOfTransfer extends StatelessWidget {
  final Transfer _transfer;

  ItemOfTransfer(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transfer.value.toString()),
        subtitle: Text(_transfer.numBalance.toString()),
      ),
    );
  }
}