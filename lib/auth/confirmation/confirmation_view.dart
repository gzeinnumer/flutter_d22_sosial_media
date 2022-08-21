import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_d22_sosial_media/auth/auth_cubit.dart';
import 'package:flutter_d22_sosial_media/auth/confirmation/confirmation_bloc.dart';
import 'package:flutter_d22_sosial_media/auth/confirmation/confirmation_event.dart';
import 'package:flutter_d22_sosial_media/auth/confirmation/confirmation_state.dart';
import 'package:flutter_d22_sosial_media/auth/form_submission_status.dart';
import 'package:flutter_d22_sosial_media/auth_repository.dart';

class ConfirmationView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ConfirmationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ConfirmationBloc(
          authRepo: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: _confirmationForm(),
      ),
    );
  }

  Widget _confirmationForm() {
    return BlocListener<ConfirmationBloc, ConfirmationState>(
        listener: (context, state) {
          final formStatus = state.status;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _codeField(),
                _confirmButton(),
              ],
            ),
          ),
        ));
  }

  Widget _codeField() {
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(
        builder: (context, state) {
          return TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Confirmation Code',
            ),
            validator: (value) =>
            state.isValidCode ? null : 'Invalid confirmation code',
            onChanged: (value) => context.read<ConfirmationBloc>().add(
              ConfirmationCodeChangedEvent(code: value),
            ),
          );
        });
  }

  Widget _confirmButton() {
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(
        builder: (context, state) {
          return state.status is FormSubmitting
              ? CircularProgressIndicator()
              : ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<ConfirmationBloc>().add(ConfirmationSubmittedEvent());
              }
            },
            child: Text('Confirm'),
          );
        });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
