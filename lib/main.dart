import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/presentation/home/home_cubit/home_cubit.dart';
import 'package:chat_app/presentation/home/home_screen.dart';
import 'package:chat_app/presentation/login/login_cubit/login_cubit.dart';
import 'package:chat_app/presentation/login/login_screen.dart';
import 'package:chat_app/presentation/signup/sign_up_screen.dart';
import 'package:chat_app/presentation/signup/signup_cubit/signup_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginScreen.route: (context) => LoginScreen(),
          SignupScreen.route: (context) => SignupScreen(),
          HomeScreen.route: (context) => HomeScreen(),
        },
        initialRoute: LoginScreen.route,
      ),
    );
  }
}
