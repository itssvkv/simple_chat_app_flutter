import 'package:chat_app/core/utils/common.dart';
import 'package:chat_app/core/utils/constants.dart';
import 'package:chat_app/presentation/home/home_cubit/home_cubit.dart';
import 'package:chat_app/presentation/home/home_cubit/home_screen_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static String route = 'home_screen';
  final TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeScreenAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: homeScreenBody(),
      ),
    );
  }

  AppBar homeScreenAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/cr7.jpg',
            width: 30,
            height: 30,
          ),
          Center(
            child: Text(
              'Sui chat',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget homeScreenBody() {
    return BlocBuilder<HomeCubit, HomeScreenState>(
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        cubit.setEmail(ModalRoute.of(context)!.settings.arguments as String);
        return StreamBuilder<QuerySnapshot>(
            stream: cubit.messagesStream,
            builder: (context, snapshot) {
              var list = snapshot.data?.docs;
              List<Map<String, dynamic>> messagesList = [];
              if (list != null) {
                for (var doc in list) {
                  messagesList.add(doc.data() as Map<String, dynamic>);
                }
              }
              return Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return messageContainer(
                            isMe: messagesList[index]['id'] == cubit.email,
                            message: messagesList[index]['message'],
                          );
                        },
                        itemCount: messagesList.length,
                      ),
                    ),
                    messageTextField(
                      controller: messageController,
                      borderColor: kPrimaryColor,
                      hintText: 'send message',
                      onChanged: cubit.onMessageSent,
                      onSuffixIconPressed: () {
                        if (messageController.text.isNotEmpty) {
                          cubit.onSendMessageClicked();
                          messageController.text = '';
                        }
                      },
                    )
                  ],
                ),
              );
            });
      },
    );
  }
}
