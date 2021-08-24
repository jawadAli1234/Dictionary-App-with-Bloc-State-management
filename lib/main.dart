import 'package:bloc_dictionary/bloc/dictionary_cubit.dart';
import 'package:bloc_dictionary/repo/word_repo.dart';
import 'package:bloc_dictionary/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        child: HomeScreen(),
        create: (context) => DictionaryCubit(WordRepository()),
      ),
    );
  }
}

//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:http/http.dart';