import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_d22_sosial_media/auth/auth_cubit.dart';
import 'package:flutter_d22_sosial_media/auth/confirmation/confirmation_view.dart';
import 'package:flutter_d22_sosial_media/auth/sign_up/sign_up_view.dart';
import 'package:flutter_d22_sosial_media/login_view.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        pages: [
          ///Show login
          if (state == AuthState.login) MaterialPage(child: LoginView()),

          ///Allow push animation
          if (state == AuthState.signUp ||
              state == AuthState.confirmSignUp) ...[
            ///Show Sign Up
            MaterialPage(child: SignUpView()),

            ///Show confirm sign up
            if (state == AuthState.confirmSignUp)
              MaterialPage(child: ConfirmationView()),
          ]
        ],
        onPopPage: (route, result) {
          return route.didPop(result);
        },
      );
    });
  }
}
