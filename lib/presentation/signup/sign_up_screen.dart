import 'package:chat_app/core/utils/common.dart';
import 'package:chat_app/core/utils/constants.dart';
import 'package:chat_app/presentation/home/home_screen.dart';
import 'package:chat_app/presentation/signup/signup_cubit/signup_cubit.dart';
import 'package:chat_app/presentation/signup/signup_cubit/signup_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  static String route = 'signup_screen';
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: signupScreenBody(),
    );
  }

  Widget signupScreenBody() {
    return BlocBuilder<SignupCubit, SignupScreenState>(
      builder: (context, state) {
        SignupCubit cubit = SignupCubit.get(context);
        if (state is SignupCreateUserSuccess) {
          Navigator.pushNamed(context, HomeScreen.route);
        }
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
                  'Signup',
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
                  height: 8,
                ),
                customTextField(
                  controller: rePasswordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password must be not empty';
                    } else if (value.length < 8) {
                      return 'Password must not less than 8 litter';
                    } else if (value != passwordController.text) {
                      return 'Password not matches';
                    } else {
                      return null;
                    }
                  },
                  onChanged: cubit.onPasswordChanged,
                  isPassword: true,
                  hintText: 're-Password',
                  onSuffixIconPressed: cubit.onShowPasswordClick,
                  isShowPassword: cubit.isShowPassword,
                ),
                SizedBox(
                  height: 24,
                ),
                customButton(
                  title: 'Signup',
                  isLoading: cubit.isButtonLoading,
                  onButtonPressed: () {
                    if (formKey.currentState!.validate()) {
                      cubit.isButtonLoading ? null : cubit.onButtonPressed();
                      cubit.createUser();
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
                      'already have an account?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
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
