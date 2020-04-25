import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:newbytebank/models/Contact.dart';
import 'package:newbytebank/models/Transaction.dart';

import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response res = await client.get(baseUrl);
    final List<dynamic> decodedJson = jsonDecode(res.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
    //print('decode JSON: ${decodedJson}');
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response res = await client.post(
        baseUrl,
        headers: {
          'Content-type': 'application/json',
          'password': password
        },
        body: transactionJson
    );

    if(res.statusCode == 200)
      return Transaction.fromJson(jsonDecode(res.body));

    throw HttpException(_getMessage(res.statusCode));
  }

  String _getMessage(int statusCode) {
    if(_statusCodeResponse.containsKey(statusCode))
      return _statusCodeResponse[statusCode];
    return 'Unknown error';
  }

  static final Map<int, String> _statusCodeResponse = {
    400 : 'there was an error submitting transaction',
    401 : 'authenticate failed',
    409 : 'transaction always exists'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}