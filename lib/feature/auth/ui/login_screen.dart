import 'package:client_it/app/ui/components/app_text_button.dart';
import 'package:client_it/app/ui/components/app_text_field.dart';
import 'package:client_it/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:client_it/feature/auth/ui/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey();
  final controllerPassword = TextEditingController();
  final controllerLogin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LoginScreen')),
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
                AppTextField(
                  controller: controllerPassword,
                  labelText: 'пароль',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        print('ok');
                        _onTapToSingIn(context.read<AuthCubit>());
                      }
                    },
                    text: 'войти'),
                const SizedBox(height: 16),
                AppTextButton(
                    backgroundColor: Colors.blueGrey,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                    },
                    text: 'регистрация'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapToSingIn(AuthCubit authCubit) => authCubit.signIn(
      password: controllerPassword.text, username: controllerLogin.text);
}
