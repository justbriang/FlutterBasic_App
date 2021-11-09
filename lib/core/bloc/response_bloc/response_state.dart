part of 'response_bloc.dart';

abstract class ResponseState extends Equatable {
  const ResponseState();

  // @override
  // List<Object> get props => [];
}

class ResponseInitial extends ResponseState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ResponseLoaded extends ResponseState {
  final List<Response>? response;
  final bool? hasReachedMax;

  ResponseLoaded({this.hasReachedMax, this.response});

  @override
  List<Object?> get props => [response];
}

class ResponseError extends ResponseState {
  final String? message;

  ResponseError({this.message});
  @override
  List<Object?> get props => [message];
}
