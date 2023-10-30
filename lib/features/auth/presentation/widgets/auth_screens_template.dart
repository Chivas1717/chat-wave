import 'package:clean_architecture_template/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class AuthScreensTemplate extends StatefulWidget {
  const AuthScreensTemplate({
    super.key,
    required this.screenTitle,
    required this.children,
    this.withBackButton = false,
    this.initialOpen = false,
    this.floatingButton,
    this.appBar,
    this.closedKeyboardBottom,
    this.closedTopPadding,
  });

  final String screenTitle;
  final List<Widget> children;
  final bool withBackButton;
  final Widget? floatingButton;
  final Widget? closedKeyboardBottom;
  final CustomAppBar? appBar;
  final double? closedTopPadding;

  final bool initialOpen;

  @override
  State<AuthScreensTemplate> createState() => _AuthScreensTemplateState();
}

class _AuthScreensTemplateState extends State<AuthScreensTemplate>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _animation;
  final GlobalKey bodyKey = GlobalKey();
  double? bodyHeight;
  double? bottomHeight;
  double? closedKeyboardHeight;
  final GlobalKey bottomKey = GlobalKey();
  final GlobalKey closedKeyboarBottomKey = GlobalKey();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.initialOpen ? 900 : 450),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: widget.initialOpen ? 200 : 150))
          .then((value) {
        runAnimation();
      });
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: widget.appBar,
        backgroundColor: Colors.white,
        body: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
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
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 30.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  // borderRadius: const BorderRadius.only(
                  //   topLeft: Radius.circular(50.0),
                  //   topRight: Radius.circular(50.0),
                  // ),
                ),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...widget.children,
                    Spacer(),
                    widget.floatingButton ?? const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
