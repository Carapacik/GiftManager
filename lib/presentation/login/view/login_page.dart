import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/data/model/request_error.dart';
import 'package:gift_manager/di/service_locator.dart';
import 'package:gift_manager/extensions/theme_extensions.dart';
import 'package:gift_manager/navigation/route_name.dart';
import 'package:gift_manager/presentation/login/bloc/login_bloc.dart';
import 'package:gift_manager/presentation/login/model/email_error.dart';
import 'package:gift_manager/presentation/login/model/password_error.dart';
import 'package:gift_manager/resources/app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<LoginBloc>(),
      child: const Scaffold(
        body: _LoginPageWidget(),
      ),
    );
  }
}

class _LoginPageWidget extends StatefulWidget {
  const _LoginPageWidget({super.key});

  @override
  State<_LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<_LoginPageWidget> {
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.authenticated) {
              unawaited(
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteName.home.route,
                  (route) => false,
                ),
              );
            }
          },
        ),
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.requestError != RequestError.noError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'ПРОИЗОШЛА ОШИБКА',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red[900],
                ),
              );
              context.read<LoginBloc>().add(const LoginRequestErrorShowed());
            }
          },
        ),
      ],
      child: Column(
        children: [
          const SizedBox(height: 64),
          Center(
            child: Text(
              'Вход',
              style: context.theme.h2,
            ),
          ),
          const Spacer(flex: 88),
          _EmailTextField(
            emailFocusNode: _emailFocusNode,
            passwordFocusNode: _passwordFocusNode,
          ),
          const SizedBox(height: 8),
          _PasswordTextField(passwordFocusNode: _passwordFocusNode),
          const SizedBox(height: 40),
          const _LoginButton(),
          const SizedBox(height: 24),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Ещё нет аккаунта?',
                style: context.theme.h4.dynamicColor(
                  context: context,
                  lightThemeColor: AppColors.lightGrey60,
                  darkThemeColor: AppColors.darkWhite60,
                ),
              ),
              TextButton(
                onPressed: () => unawaited(Navigator.of(context).pushNamed(RouteName.registration.route)),
                child: const Text('Создать'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => debugPrint('Нажали на кнопку Не помню пароль'),
            child: const Text('Не помню пароль'),
          ),
          const Spacer(flex: 284),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: SizedBox(
        width: double.infinity,
        child: BlocSelector<LoginBloc, LoginState, bool>(
          selector: (state) => state.allFieldsValid,
          builder: (context, fieldsValid) {
            return ElevatedButton(
              onPressed: fieldsValid ? () => context.read<LoginBloc>().add(const LoginLoginButtonClicked()) : null,
              child: const Text('Войти'),
            );
          },
        ),
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({
    required FocusNode emailFocusNode,
    required FocusNode passwordFocusNode,
    super.key,
  })  : _emailFocusNode = emailFocusNode,
        _passwordFocusNode = passwordFocusNode;

  final FocusNode _emailFocusNode;
  final FocusNode _passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: BlocSelector<LoginBloc, LoginState, EmailError>(
        selector: (state) => state.emailError,
        builder: (context, emailError) {
          return TextField(
            focusNode: _emailFocusNode,
            onChanged: (text) => context.read<LoginBloc>().add(LoginEmailChanged(text)),
            onSubmitted: (_) => _passwordFocusNode.requestFocus(),
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Почта',
              errorText: emailError == EmailError.noError ? null : emailError.toString(),
            ),
          );
        },
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({required FocusNode passwordFocusNode, super.key}) : _passwordFocusNode = passwordFocusNode;

  final FocusNode _passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: BlocSelector<LoginBloc, LoginState, PasswordError>(
        selector: (state) => state.passwordError,
        builder: (context, passwordError) {
          return TextField(
            focusNode: _passwordFocusNode,
            autocorrect: false,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            onChanged: (text) => context.read<LoginBloc>().add(LoginPasswordChanged(text)),
            onSubmitted: (_) => context.read<LoginBloc>().add(const LoginLoginButtonClicked()),
            decoration: InputDecoration(
              labelText: 'Пароль',
              errorText: passwordError == PasswordError.noError ? null : passwordError.toString(),
            ),
          );
        },
      ),
    );
  }
}
