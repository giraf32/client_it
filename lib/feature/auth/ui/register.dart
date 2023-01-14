import 'package:client_it/app/ui/components/app_text_button.dart';
import 'package:client_it/app/ui/components/app_text_field.dart';
import 'package:client_it/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey();
  final controllerPassword = TextEditingController();
  final controllerPassword2 = TextEditingController();
  final controllerLogin = TextEditingController();
  final controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RegisterScreen')),
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField(controller: controllerLogin, labelText: 'логин'),
                const SizedBox(height: 16),
                AppTextField(controller: controllerEmail, labelText: 'почта'),
                const SizedBox(height: 16),
                AppTextField(
                    controller: controllerPassword,
                    labelText: 'пароль',
                    obscureText: true),
                const SizedBox(height: 16),
                AppTextField(
                    controller: controllerPassword2,
                    labelText: 'повторите пароль',
                    obscureText: true),
                const SizedBox(height: 16),
                AppTextButton(
                    backgroundColor: Colors.blueGrey,
                    onPressed: () {
                      if (formKey.currentState?.validate() != true) return;
                      if (controllerPassword.text != controllerPassword2.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Пароли не совпадают')));
                      } else {
                        _onTapToSingUp(context.read<AuthCubit>());
                        Navigator.of(context).pop();
                      }
                    },
                    text: 'регистрация'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapToSingUp(AuthCubit authCubit) => authCubit.signUp(
      password: controllerPassword.text,
      username: controllerLogin.text,
      email: controllerEmail.text);
}
