import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thedogapi/core/network/app_urls.dart';

abstract class AbstractPawNetworkService {
  Future<Map<String, dynamic>> getRequest(String url);
}

class PawNetworkService implements AbstractPawNetworkService {
  @override
  Future<Map<String, dynamic>> getRequest(String url) async {
    final requestUri = Uri.parse(AppUrls.baseUrl + url);
    final response = await http.get(requestUri);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error while making this request. Please try again');
    }
  }
}
