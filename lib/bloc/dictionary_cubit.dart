import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_dictionary/model/word_response.dart';
import 'package:bloc_dictionary/repo/word_repo.dart';


class DictionaryCubit extends Cubit<DictionaryState> {
  final WordRepository _repository;
  DictionaryCubit(this._repository) : super(NoWordSearchedState());

  final queryController = TextEditingController();

  Future getWordSearch() async {
    emit(SearchingWordState());
    try {
      final words =
          await _repository.getWordsFromDictionary(queryController.text);
      if (words == null) {
        emit(ErrorState('There is an issue'));
      } else {
        print(words.toString());
        emit(SearchedWordState(words));
        emit(NoWordSearchedState());
      }
    } on Exception catch (e) {
      print(e);
      emit(ErrorState(e.toString()));
    }
  }
}

abstract class DictionaryState {}

class NoWordSearchedState extends DictionaryState {
  
}

class SearchingWordState extends DictionaryState {
 
}

class SearchedWordState extends DictionaryState {
  final List<WordResponse> words;
  SearchedWordState(this.words);
 
}

class ErrorState extends DictionaryState {
 final String message;
 ErrorState(this.message);
}
