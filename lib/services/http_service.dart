import 'package:http/http.dart';

import 'package:http/http.dart' as http;


class HttpService{
  static final String baseUrl = 'https://api.dictionaryapi.dev/api/v2/entries/';

  static Future<http.Response> getResponse(endPoint) async{
    http.Response response;

    final url = Uri.parse('$baseUrl$endPoint');
    try{
    response = await http.get(url);
    } catch(e){
      throw e;
    }
    return response;
  }
}