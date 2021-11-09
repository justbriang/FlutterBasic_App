part of 'dictionary_bloc.dart';

abstract class DictionaryState extends Equatable {
  const DictionaryState();

  @override
  List<Object> get props => [];
}

class DictionaryInitial extends DictionaryState {}

class DictionaryLoaded extends DictionaryState {
  final Iterable<MapEntry<String, dynamic>> dictionary;
  final bool? hasReachedMax;
  DictionaryLoaded(this.dictionary, this.hasReachedMax);


  @override
  List<Object> get props => [dictionary,hasReachedMax!];

}
