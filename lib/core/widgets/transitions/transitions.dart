import 'dart:io';

import 'package:flutter/material.dart';

class BottomToTopTransition extends PageRouteBuilder{
  BottomToTopTransition({
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.reverseDuration = const Duration(milliseconds: 200),
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => child
  );

  final Widget child;
  final Duration duration;
  final Duration reverseDuration;


  @override
  Duration get transitionDuration => duration;

  @override
  Duration get reverseTransitionDuration => reverseDuration;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

}


class FadePageTransition extends PageRouteBuilder{
  FadePageTransition({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration = const Duration(milliseconds: 300),
    this.matchingBuilder = const CupertinoPageTransitionsBuilder(),
  }) : super(
      pageBuilder: (context, animation, secondaryAnimation) => child
  );

  final Widget child;
  final Duration duration;
  final Duration reverseDuration;

  final PageTransitionsBuilder matchingBuilder;


  @override
  Duration get transitionDuration => duration;

  @override
  Duration get reverseTransitionDuration => reverseDuration;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.6, 1.0),
          ),
        ),
        child: child
    );
  }

}



class RightToLeftTransition extends PageRouteBuilder{
  RightToLeftTransition({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration = const Duration(milliseconds: 300),
    this.matchingBuilder = const CupertinoPageTransitionsBuilder(),
  }) : super(
      pageBuilder: (context, animation, secondaryAnimation) => child
  );

  final Widget child;
  final Duration duration;
  final Duration reverseDuration;

  final PageTransitionsBuilder matchingBuilder;


  @override
  Duration get transitionDuration => duration;

  @override
  Duration get reverseTransitionDuration => reverseDuration;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    var slideTransition = SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );

    if (Platform.isIOS) {
      return matchingBuilder.buildTransitions(
          this, context, animation, secondaryAnimation, child);
    }
    return slideTransition;
  }

}