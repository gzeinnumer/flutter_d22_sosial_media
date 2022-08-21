import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_d22_sosial_media/auth/auth_cubit.dart';
import 'package:flutter_d22_sosial_media/auth_repository.dart';
import 'package:flutter_d22_sosial_media/auth/login/login_bloc.dart';
import 'package:flutter_d22_sosial_media/auth/login/login_event.dart';
import 'package:flutter_d22_sosial_media/auth/login/login_state.dart';
import 'package:flutter_d22_sosial_media/auth/login/login_status.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              authRepository: context.read<AuthRepository>(),
              authCubit: context.read<AuthCubit>(),
            ),
          ),
        ],
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [_loginForm(), _showSignUpButton(context)],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final status = state.status;
          if (status is SubmissionFailed) {
            _showSnackbar(context, status.exception.toString());
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _usernameField(),
                  _passwordField(),
                  _loginBtn(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: "Username",
        ),
        validator: (value) => state.isValidUsername ? null : "To short",
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginUsernameChangedEvent(username: value)),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          icon: Icon(Icons.security),
          hintText: "Password",
        ),
        validator: (value) => state.isValidPassword ? null : "To short",
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginPasswordChangedEvent(password: value)),
      );
    });
  }

  Widget _loginBtn() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.status is FormSubmitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginSubmittedEvent());
                }
              },
              child: const Text('Login'),
            );
    });
  }

  Widget _showSignUpButton(BuildContext context) {
    return SafeArea(
      child: TextButton(
        child: const Text('Don\'t have an account? Sign up.'),
        onPressed: () {
          return context.read<AuthCubit>().showSignUp();
        },
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
