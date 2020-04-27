import 'package:mockito/mockito.dart';
import 'package:newbytebank/database/dao/contact_dao.dart';
import 'package:newbytebank/http/webclients/transaction_webclient.dart';

class MockContactDao extends Mock implements ContactDao {}

class MockTransactionWebClient extends Mock implements TransactionWebClient {}