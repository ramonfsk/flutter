import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'interceptors/loggin-interceptor.dart';

final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
    requestTimeout: Duration(seconds: 5)
);

const String baseUrl = 'http://192.168.0.161:8081/transactions';