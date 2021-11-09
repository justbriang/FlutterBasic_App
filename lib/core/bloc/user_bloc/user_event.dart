part of 'user_bloc.dart';

@immutable
abstract class UserBlocEvent extends Equatable{

}
class InitialUserEvent extends UserBlocEvent {
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}

class UpdateUserDetailsEvent extends UserBlocEvent {
  final Map<String, dynamic>? userDetails;

  UpdateUserDetailsEvent({this.userDetails});

  @override
  List<Object?> get props => [userDetails];
}
