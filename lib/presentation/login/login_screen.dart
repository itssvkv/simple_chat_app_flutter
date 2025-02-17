import 'package:chat_app/core/utils/common.dart';
import 'package:chat_app/core/utils/constants.dart';
import 'package:chat_app/presentation/home/home_screen.dart';
import 'package:chat_app/presentation/login/login_cubit/login_cubit.dart';
import 'package:chat_app/presentation/login/login_cubit/login_screen_state.dart';
import 'package:chat_app/presentation/signup/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static String route = 'login_screen';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: loginScreenBody(),
    );
  }

  Widget loginScreenBody() {
    return BlocBuilder<LoginCubit, LoginScreenState>(
      builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'assets/cr7.jpg',
                  width: 80,
                  height: 80,
                ),
                Center(
                  child: Text(
                    'Suuuuuuuuuuuuui chat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                customTextField(
                  hintText: 'Email',
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email must be not empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: cubit.onEmailChanged,
                ),
                SizedBox(
                  height: 8,
                ),
                customTextField(
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password must be not empty';
                    } else if (value.length < 8) {
                      return 'Password must not less than 8 litter';
                    } else {
                      return null;
                    }
                  },
                  onChanged: cubit.onPasswordChanged,
                  isPassword: true,
                  hintText: 'Password',
                  onSuffixIconPressed: cubit.onShowPasswordClick,
                  isShowPassword: cubit.isShowPassword,
                ),
                SizedBox(
                  height: 24,
                ),
                customButton(
                  title: 'Login',
                  isLoading: cubit.isButtonLoading,
                  onButtonPressed: () {
                    if (formKey.currentState!.validate()) {
                      cubit.isButtonLoading ? null : cubit.onButtonPressed();
                      cubit.loginWithEmailAndPassword();
                      cubit.onNavigateToHomeScreen = () {
                        Navigator.pushNamed(context, HomeScreen.route,
                            arguments: cubit.email);
                      };
                    } else {
                      cubit.onButtonPressed();
                    }
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'don\'t have an account?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignupScreen.route);
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
