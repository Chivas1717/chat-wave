import 'package:clean_architecture_template/core/style/colors.dart';
import 'package:clean_architecture_template/core/widgets/buttons/primary_button.dart';
import 'package:clean_architecture_template/features/chats/presentation/blocs/users/users_cubit.dart';
import 'package:clean_architecture_template/features/chats/presentation/widgets/user_row.dart';
import 'package:clean_architecture_template/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateChatModalWindow extends StatefulWidget {
  const CreateChatModalWindow({super.key});

  @override
  State<CreateChatModalWindow> createState() => _CreateChatModalWindowState();
}

class _CreateChatModalWindowState extends State<CreateChatModalWindow> {
  late UsersCubit usersCubit;
  int? selectedUserId;

  @override
  void initState() {
    usersCubit = sl();
    usersCubit.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
        bloc: usersCubit,
        builder: (context, state) {
          return Dialog(
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)), //this right here
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 350),
                color: CColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'З ким почнем балакати?',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      if (state is UsersLoading)
                        const CircularProgressIndicator(),
                      if (state is UsersFailure)
                        const CircularProgressIndicator(
                          color: CColors.error,
                        ),
                      if (state is UsersData)
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ...List.generate(
                                  state.users.length,
                                  (index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (selectedUserId ==
                                              state.users[index].id) {
                                            selectedUserId = null;
                                          } else {
                                            selectedUserId =
                                                state.users[index].id;
                                          }
                                        },
                                        child: UserRow(
                                          user: state.users[index],
                                          isSelected: state.users[index].id ==
                                              selectedUserId,
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      PrimaryButton(
                        active: selectedUserId != null,
                        title: 'Підтвердити',
                        onTap: () {
                          // signInCubit.signIn(
                          //   SignInInfo(
                          //     email: emailController.value.text,
                          //     password: passwordController.value.text,
                          //   ),
                          // );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
