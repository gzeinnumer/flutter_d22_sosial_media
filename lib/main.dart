import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_d22_sosial_media/app_navigator.dart';
import 'package:flutter_d22_sosial_media/auth/auth_cubit.dart';
import 'package:flutter_d22_sosial_media/auth/auth_navigator.dart';
import 'package:flutter_d22_sosial_media/auth_repository.dart';
import 'package:flutter_d22_sosial_media/login_view.dart';
import 'package:flutter_d22_sosial_media/session_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => AuthRepository()),
        ],
        child: BlocProvider<SessionCubit>(
          create: (context) => SessionCubit(
            authRepo: context.read<AuthRepository>(),
          ),
          child: const AppNavigator(),
        ),
      ),
    );
  }
}
