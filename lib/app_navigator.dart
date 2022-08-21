import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_d22_sosial_media/auth/auth_cubit.dart';
import 'package:flutter_d22_sosial_media/auth/auth_navigator.dart';
import 'package:flutter_d22_sosial_media/loading_view.dart';
import 'package:flutter_d22_sosial_media/session_cubit.dart';
import 'package:flutter_d22_sosial_media/session_state.dart';
import 'package:flutter_d22_sosial_media/session_view.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          ///Show loading screen
          if (state is UnknownSessionState)
            const MaterialPage(
              child: LoadingView(),
            ),

          ///Show auth flow
          if (state is Unauthenticated)
            MaterialPage(
              child: BlocProvider<AuthCubit>(
                create: (context) => AuthCubit(sessionCubit: context.read<SessionCubit>()),
                child: const AuthNavigator(),
              ),
            ),

          ///Show session flow
          if (state is Authenticated)
            const MaterialPage(
              child: SessionView(),
            )
        ],
        onPopPage: (route, result) {
          return route.didPop(result);
        },
      );
    });
  }
}
