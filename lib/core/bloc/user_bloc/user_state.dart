part of 'user_bloc.dart';

@immutable
abstract class UserBlocState extends Equatable {}

class UserBlocInitial extends UserBlocState {
  @override
  List<Object?> get props => [];
}

class UserBlocLoaded extends UserBlocState {
  final User? user;
  final String? message;
  final bool? updated;
  UserBlocLoaded({this.user, this.message,this.updated});
  @override
  List<Object?> get props => [user, message,updated];
}

class UserBlocError extends UserBlocState {
  final String? message;

  UserBlocError({this.message});

  @override
  List<Object?> get props => [message];
}

class UserBlocUpdated extends UserBlocState {
  @override
  List<Object?> get props => [];
}

class UserBlocUpdateSuccess extends UserBlocState {
  final String? message;

  UserBlocUpdateSuccess({this.message});

  @override
  List<Object?> get props => [message];
}

class UserBlocUpdateFailed extends UserBlocState {
  final String? message;

  UserBlocUpdateFailed({this.message});

  @override
  List<Object?> get props => [message];
}
