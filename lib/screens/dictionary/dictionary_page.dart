import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutterbasic/core/bloc/dictionary_bloc/dictionary_bloc.dart';
import 'package:flutterbasic/screens/dictionary/widgets/list_item_tile.dart';
import 'package:flutterbasic/screens/dictionary/widgets/loading_progress_indicator.dart';

import '../../utils.dart';

class DictionaryPage extends StatefulWidget {
  static const name = 'DictionaryPage';
  DictionaryPage({Key? key}) : super(key: key);

  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final _scrollController = ScrollController();

  final DictionaryBloc _dictionaryBloc = DictionaryBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(child:Text(
          'Dictionary',
          style: TextStyle(color: Colors.blue),
        ),),
     
      ),
        body: BlocProvider(
            create: (context) => DictionaryBloc(),
            child: BlocConsumer(
              bloc: _dictionaryBloc,
              listener: (context, state) {},
              builder: (context, state) {
                if (state is DictionaryInitial) {
                  _dictionaryBloc.add(FetchDictionary());

                return const CircularProgressIndicator();
                }else if (state is DictionaryLoaded) {
                if (state.dictionary.isEmpty) {
                  return const Center(
                    child: Text('No response received. Yet!'),
                  );
                }
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: index >= state.dictionary.length
                              ? const LoadingProgressIndicator()
                              : ListItemTile(dictionary:state.dictionary.elementAt(index)),
                        ),
                      ),
                    );
                  },
                  itemCount: state.hasReachedMax!
                      ? state.dictionary.length
                      : state.dictionary.length + 1,
                  controller: _scrollController,
                );
              } else {
                return  SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                );
              }
              
              },
            )));
  }
}
