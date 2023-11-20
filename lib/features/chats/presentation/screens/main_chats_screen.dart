import 'package:clean_architecture_template/core/style/colors.dart';
import 'package:clean_architecture_template/core/util/pop_up_opener.dart';
import 'package:clean_architecture_template/core/widgets/transitions/transitions.dart';
import 'package:clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:clean_architecture_template/features/auth/presentation/blocs/user_cubit/user_cubit.dart';
import 'package:clean_architecture_template/features/chats/presentation/blocs/chats/chats_cubit.dart';
import 'package:clean_architecture_template/features/chats/presentation/widgets/chats_list.dart';
import 'package:clean_architecture_template/features/chats/presentation/widgets/create_chat_modal_window.dart';
import 'package:clean_architecture_template/features/chats/presentation/widgets/favorite_contacts.dart';
import 'package:clean_architecture_template/features/chats/presentation/widgets/sections.dart';
import 'package:clean_architecture_template/features/chats/presentation/widgets/user_avatar.dart';
import 'package:clean_architecture_template/injection_container.dart';
import 'package:clean_architecture_template/redirector.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainChatsScreen extends StatefulWidget {
  const MainChatsScreen({super.key});

  @override
  State<MainChatsScreen> createState() => _MainChatsScreenState();
}

class _MainChatsScreenState extends State<MainChatsScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late final UserCubit userCubit;
  late final ChatsCubit chatsCubit;

  @override
  void initState() {
    userCubit = sl();
    chatsCubit = sl()..getChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      bloc: userCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return state is UserData
            ? BlocBuilder<ChatsCubit, ChatsState>(
                bloc: chatsCubit,
                builder: (context, chatsState) {
                  if (chatsState is ChatsData) {
                    return Scaffold(
                      key: _globalKey,
                      backgroundColor: const Color(0x550080bf),
                      body: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 50, left: 5, right: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        _globalKey.currentState!.openDrawer();
                                      },
                                      icon: const Icon(
                                        Icons.menu,
                                        color: CColors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.search,
                                        color: CColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Sections(),
                            ],
                          ),
                          Positioned(
                            top: 160,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 25, right: 25),
                              height: 220,
                              decoration: const BoxDecoration(
                                color: Color(0xEE7ce8ff),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                              ),
                              child: FavoriteContacts(),
                            ),
                          ),
                          Positioned(
                            top: 325,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.only(top: 15),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                                color: Color(0xFFEFFFFC),
                              ),
                              child: ChatsList(chats: chatsState.chats),
                            ),
                          ),
                        ],
                      ),
                      floatingActionButton: DraggableFab(
                        child: SizedBox(
                          height: 65,
                          width: 65,
                          child: FloatingActionButton(
                            backgroundColor: const Color(0xEE7ce8ff),
                            child: const Icon(
                              Icons.add,
                              size: 30,
                            ),
                            onPressed: () {
                              showPopUp(context, CreateChatModalWindow());
                            },
                          ),
                        ),
                      ),
                      drawer: CustomDrawer(
                        user: state.user,
                        userCubit: userCubit,
                      ),
                    );
                  }

                  return const Scaffold(
                    body: CircularProgressIndicator(
                      color: CColors.green,
                    ),
                  );
                })
            : const Scaffold(
                body: SizedBox.shrink(),
              );
      },
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.user, required this.userCubit});
  final User user;
  final UserCubit userCubit;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 275,
      elevation: 30,
      backgroundColor: const Color(0xF3393838),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(40),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: Color(0x3D000000),
              spreadRadius: 30,
              blurRadius: 20,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: CColors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 56,
                      ),
                      const Text(
                        'Settings',
                        style: TextStyle(color: CColors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      UserAvatar(filename: 'img3.jpeg'),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        user.username ?? '',
                        style: TextStyle(color: CColors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const DrawerItem(
                    title: 'Account',
                    icon: Icons.key,
                  ),
                  const DrawerItem(title: 'Chats', icon: Icons.chat_bubble),
                  const DrawerItem(
                      title: 'Notifications', icon: Icons.notifications),
                  const DrawerItem(
                      title: 'Data and Storage', icon: Icons.storage),
                  const DrawerItem(title: 'Help', icon: Icons.help),
                  const Divider(
                    height: 35,
                    color: CColors.green,
                  ),
                  const DrawerItem(
                      title: 'Invite a friend', icon: Icons.people_outline),
                ],
              ),
              DrawerItem(
                title: 'Log out',
                icon: Icons.logout,
                onTap: () {
                  print('here');
                  userCubit.logOut();
                  Navigator.of(context).pushAndRemoveUntil(
                    FadePageTransition(
                      child: const RedirectPage(),
                    ),
                    (route) => false,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  const DrawerItem(
      {super.key, required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Row(
          children: [
            Icon(
              icon,
              color: CColors.white,
              size: 20,
            ),
            const SizedBox(
              width: 40,
            ),
            Text(
              title,
              style: const TextStyle(color: CColors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
