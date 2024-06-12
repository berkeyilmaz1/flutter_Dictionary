import 'dart:io';

import 'package:dictionary_app/product/model/model.dart';
import 'package:dio/dio.dart';

class DictionaryService {
  final String word;

  DictionaryService(this.word);

  Future<List<DictionaryModel>?> fetchItems() async {
    final response = await Dio().get("https://api.dictionaryapi.dev/api/v2/entries/en/$word");
  
    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data;
      if (datas is List) {
        return datas
            .map(
              (e) => DictionaryModel.fromJson(e),
            )
            .toList();
      }
    }
    return null;
  }
}
