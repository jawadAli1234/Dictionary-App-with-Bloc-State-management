import 'package:bloc_dictionary/bloc/dictionary_cubit.dart';
import 'package:bloc_dictionary/screens/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();
    return BlocListener(listener: (context, state) {
      // ignore: unnecessary_null_comparison
      if (state is SearchedWordState && state.words != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WordsList(state.words),
          ),
        );
      }
    },
    bloc: cubit,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: cubit.state is SearchingWordState
            ? getLoadingWidget()
            : cubit.state is ErrorState
                ? getErrorWidget('Some Error')
                : cubit.state is NoWordSearchedState
                    ? _searchScreenWidget(context)
                    : Container(),
      ),
    );
  }
}

_searchScreenWidget(BuildContext context) {
  final cubit = context.watch<DictionaryCubit>();
  return Container(
    padding: EdgeInsets.all(10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Text(
          'Dictionary App',
          style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontSize: 34.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Search Any Word you want',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            //fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: cubit.queryController,
          decoration: InputDecoration(
              hintText: 'Search a word',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              fillColor: Colors.grey[100],
              filled: true,
              prefixIcon: Icon(Icons.search),
              hintStyle: TextStyle(color: Colors.white)),
        ),
        Spacer(),
        Container(
          width: double.infinity,
          child: ElevatedButton(
            child: Text('Search'),
            onPressed: () {
              cubit.getWordSearch();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrangeAccent,
              padding: EdgeInsets.all(16.0),
            ),
          ),
        ),
      ],
    ),
  );
}

getLoadingWidget() {
  return Center(child: CircularProgressIndicator());
}

getErrorWidget(message) {
  return Text(message);
}
