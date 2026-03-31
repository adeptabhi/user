import 'dart:convert';
import 'package:adept_log/view/adept_log.dart';
import 'package:http/http.dart' as http;
import 'package:user/api/api_manager.dart';
import 'package:user/util/enum/request_type.dart';
import 'package:user/util/model/response_mdl.dart';

class ApiClient {
  http.Client? _client;
  http.Client get client => _client ??= http.Client();
  final Map<String, String> _headers = {'content-type': 'application/json'};
  void close() {
    try {
      _client?.close();
      _client = null;
    } catch (ex, st) {
      AdeptLog.e(ex, stackTrace: st);
    }
  }

  Future<ResponseMdl> request({
    required String endPoint,
    required RequestType type,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? queryParameters,
  }) async {
    late http.Response response;
    payload = payload ?? {};
    Uri uri = Uri.parse('${ApiManager.baseUrl}$endPoint').replace(
      queryParameters: queryParameters?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );
    AdeptLog.i({
      type.name.toUpperCase(): uri.toString(),
      "Payload": payload,
    }, tag: endPoint);
    try {
      switch (type) {
        case RequestType.get:
          response = await client.get(uri, headers: _headers);
          break;
        case RequestType.post:
          response = await client.post(
            uri,
            headers: _headers,
            body: jsonEncode(payload),
          );
          break;
        case RequestType.put:
          response = await client.put(
            uri,
            headers: _headers,
            body: jsonEncode(payload),
          );
          break;
        case RequestType.delete:
          response = await client.delete(
            uri,
            headers: _headers,
            body: jsonEncode(payload),
          );
          break;
        case RequestType.patch:
          response = await client.patch(
            uri,
            headers: _headers,
            body: jsonEncode(payload),
          );
          break;
      }
      final decoded = jsonDecode(response.body);
      AdeptLog.s({
        "StatusCode": "${response.statusCode}",
        "Response": decoded,
      }, tag: endPoint);
      if (response.statusCode == 200) {
        return ResponseMdl(isSuccess: true, data: decoded);
      }
    } catch (ex, st) {
      AdeptLog.e(ex, stackTrace: st);
    }
    return ResponseMdl(isSuccess: false);
  }
}
