import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterbasic/core/api/baseapi.dart';
import 'package:flutterbasic/core/api/exception_handler.dart';
import 'package:flutterbasic/core/api/shared_prefs.dart';
import 'package:flutterbasic/core/models/response.dart';
part 'response_event.dart';
part 'response_state.dart';

class ResponseBloc extends Bloc<ResponseEvent, ResponseState> {
  ResponseBloc() : super(ResponseInitial());
  final SharedPref _sharedPref = SharedPref();
  final BaseApi _baseApi = BaseApi();

  // @override
  // void onTransition(Transition<ResponseEvent, ResponseState> transition) {
  //   print(transition);
  //   super.onTransition(transition);
  // }

  @override
  Stream<ResponseState> mapEventToState(ResponseEvent event) async* {
    try {
      if (event is FetchResponses) {
        List<Response> response = await _baseApi.getResponses();
        print('its is ${response[0].title}');
        yield ResponseLoaded(response: response, hasReachedMax: true);
      }
    } catch (ex) {
      if (ex is ExceptionHandler) {
        yield ResponseError(message: ex.error);
      } else if (ex is SocketException) {
        yield ResponseError(message: ex.message);
      } else {
        yield ResponseError(
            message: "An error occurred. Unable to load responses.");
      }
    }
  }
}
