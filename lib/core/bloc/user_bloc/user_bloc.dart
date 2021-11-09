import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterbasic/core/api/shared_prefs.dart';
import 'package:flutterbasic/core/models/user_prof.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {
  UserBloc() : super(UserBlocInitial());
  final SharedPref _sharedPref = SharedPref();

  @override
  void onTransition(Transition<UserBlocEvent, UserBlocState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<UserBlocState> mapEventToState(UserBlocEvent event) async* {
    UserBlocState currentState = state;

    try {
      if (event is InitialUserEvent) {
      
        User? userDeets;
        String? userDetails = await _sharedPref.getProfDetails();
     

        if (userDetails != null) {
          Map<String, dynamic> userMap = jsonDecode(userDetails);
          userDeets = User.fromJson(userMap);
        }

        yield UserBlocLoaded(user: userDeets);
      } else if (event is UpdateUserDetailsEvent) {
        bool updated =
            await _sharedPref.saveProfDetails(jsonEncode(event.userDetails));
        if (updated) {
        User? userDeets;
        String? userDetails = await _sharedPref.getProfDetails();
  

        if (userDetails != null) {
          Map<String, dynamic> userMap = jsonDecode(userDetails);
          userDeets = User.fromJson(userMap);
        }
          yield UserBlocLoaded(
            updated: true,
              user: userDeets,
              message: 'User Profile updated successfully');
        } else {
        User? userDeets;
        String? userDetails = await _sharedPref.getProfDetails();
  

        if (userDetails != null) {
          Map<String, dynamic> userMap = jsonDecode(userDetails);
          userDeets = User.fromJson(userMap);
        }
          yield UserBlocLoaded(
            updated: false,
             user: userDeets,
              message: 'User profile updated failed, please try again');
        }
      }
    } catch (ex) {
      yield UserBlocError(message: ex.toString());
    }
  }
}
