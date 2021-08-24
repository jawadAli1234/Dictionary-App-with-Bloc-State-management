import 'package:bloc_dictionary/model/word_response.dart';
import 'package:bloc_dictionary/services/http_service.dart';

class WordRepository {
  Future<List<WordResponse>?> getWordsFromDictionary(String query) async {
    try {
      final response = await HttpService.getResponse('en/$query');
      if (response.statusCode == 200) {
        final result = wordResponseFromJson(response.body);
        return result;
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }
}
