part of 'response_bloc.dart';

abstract class ResponseEvent extends Equatable {
  const ResponseEvent();

  @override
  List<Object> get props => [];
}
class FetchResponses extends ResponseEvent{}
