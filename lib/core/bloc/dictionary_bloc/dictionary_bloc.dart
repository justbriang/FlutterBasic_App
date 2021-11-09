import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterbasic/core/api/baseapi.dart';

part 'dictionary_event.dart';
part 'dictionary_state.dart';

class DictionaryBloc extends Bloc<DictionaryEvent, DictionaryState> {
  DictionaryBloc() : super(DictionaryInitial());
  BaseApi _baseApi = BaseApi();
  @override
  Stream<DictionaryState> mapEventToState(DictionaryEvent event) async* {
    if (event is DictionaryEvent) {
      Map<String, dynamic> dictionary = _baseApi.getDictionary();
      print('at bloc level dictionary is ${dictionary.entries.toList()[0]}');
      yield DictionaryLoaded(dictionary.entries.toList(), true);
    }
  }
}
