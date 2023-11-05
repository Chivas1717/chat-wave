import 'dart:async';

import 'package:clean_architecture_template/core/style/colors.dart';
import 'package:clean_architecture_template/core/widgets/transitions/transitions.dart';
import 'package:clean_architecture_template/features/auth/presentation/blocs/user_cubit/user_cubit.dart';
import 'package:clean_architecture_template/features/auth/presentation/screens/enter_phone_screen.dart';
import 'package:clean_architecture_template/features/chats/presentation/screens/main_chats_screen.dart';
import 'package:clean_architecture_template/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class RedirectPage extends StatefulWidget {
  const RedirectPage({super.key});

  @override
  State<RedirectPage> createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage>
    with TickerProviderStateMixin {
  late final UserCubit userCubit;
  late final StreamSubscription subscription;
  late final AnimationController _controller;

  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1450),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 150)).then((value) {
        runAnimation();
      });
    });

    userCubit = sl();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userCubit.getUser();
    });
    super.initState();
  }

  void runAnimation() {
    if (mounted) {
      if (!_controller.isAnimating && !_controller.isCompleted) {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
        bloc: userCubit,
        listener: (context, state) async {
          if (state is UserData) {
            Navigator.of(context).pushAndRemoveUntil(
              FadePageTransition(
                child: const MainChatsScreen(),
              ),
              (route) => false,
            );
          } else if (state is UserUnregistered) {
            Navigator.of(context).pushAndRemoveUntil(
              FadePageTransition(
                child: const EnterPhoneScreen(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: CColors.white,
            body: SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                      .animate(_controller),
              child: Stack(
                children: [
                  WaveWidget(
                    config: CustomConfig(
                      gradients: [
                        [Colors.blue, Color(0xEEccf9ff)],
                        [Colors.blue[800]!, Color(0xEE7ce8ff)],
                        [Colors.blue, Color(0x6655d0ff)],
                        [Colors.blue, Color(0x5500acdf)]
                      ],
                      durations: [35000, 19440, 10800, 6000],
                      heightPercentages: [-0.07, -0.03, -0.08, -0.05],
                      gradientBegin: Alignment.bottomLeft,
                      gradientEnd: Alignment.topRight,
                    ),
                    size: Size(double.infinity, double.infinity),
                    waveAmplitude: 0,
                  ),
                ],
              ),
            ),
            // );
            //   }
          );
        });
  }
}
