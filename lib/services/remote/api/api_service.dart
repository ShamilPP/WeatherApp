import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/result.dart';

class ApiService {
  Future<Result> get(String url) async {
    http.Response response;
    response =
        await http.get(Uri.parse(url)).timeout(const Duration(seconds: 30), onTimeout: () => http.Response(jsonEncode({'message': 'Timeout exception'}), 500));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Result.success(data);
    } else {
      return Result.error('${response.body}');
    }
  }
}
