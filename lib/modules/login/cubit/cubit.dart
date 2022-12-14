import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/login_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  late LoginModel? loginModel;

  void userLogin({
    required String? email,
    required String? password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      debugPrint(loginModel!.data!.token);
      if (loginModel!.status!) {
        emit(LoginSuccessState(loginModel!));
      } else {
        emit(LoginErrorState(loginModel!.message!));
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisiability() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisiabilityState());
  }
}
