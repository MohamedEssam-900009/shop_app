import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN ,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      debugPrint(value.data);
      emit(LoginSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
}
