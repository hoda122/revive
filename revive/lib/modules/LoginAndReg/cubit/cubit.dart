import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revive/models/loginModel/login_model.dart';
import 'package:revive/modules/LoginAndReg/cubit/state.dart';
import 'package:revive/shared/network/end_point.dart';
import 'package:revive/shared/network/remote/dioHelper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(loginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;

  void userLogin({
    @required String? email,
    @required String? password,
  }) {
    emit(loginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      // print(loginModel?.status);
      // print(loginModel?.message);
      // print(loginModel?.data!.token);
      emit(loginSuccessState(loginModel!));
    }).catchError(
      (error) {
        emit(loginErrorState(error.toString()));
      },
    );
  }

  bool ispassword = true;
  void changeShowPass() {
    ispassword = !ispassword;
    emit(loginChangeShowPassState());
  }
}
