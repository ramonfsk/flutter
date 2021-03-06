import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newbytebank/database/dao/contact_dao.dart';
import 'package:newbytebank/screens/contacts_list.dart';
import 'package:newbytebank/screens/transactions_list.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('images/bytebank_logo.png'),
                ),
                Row(
                  children: <Widget>[
                    FeatureItem(
                      'Transfer',
                      Icons.monetization_on,
                      onClick: () => _showConctactList(context)
                    ),
                    FeatureItem(
                      'Transaction Feed',
                      Icons.description,
                      onClick: () => _showTransactionsList(context)
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showConctactList(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => ContactsList()
        )
    );
  }

  void _showTransactionsList(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => TransactionsList()
        )
    );
  }
}



class FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  FeatureItem(this.name, this.icon, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
              padding: EdgeInsets.all(8.0),
              height: 100,
              width: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 32.0,
                  ),
                  Text(
                      name,
                      style: TextStyle(
                          color: Colors.white
                      )
                  )
                ],
              )),
        ),
      ),
    );
  }
}
