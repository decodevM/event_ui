import 'package:event_ui/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  // private function
  void _initScaleAnimation() {
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 35).animate(_scaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: const HomeScreen(), type: PageTransitionType.fade));
        }
      });
  }

  @override
  void initState() {
    _initScaleAnimation();

    super.initState();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                CupertinoColors.black.withOpacity(.6),
                // CupertinoColors.black.withOpacity(.8),
                CupertinoColors.black.withOpacity(.2),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Find the best locations near you for a good night',
                      style: TextStyle(
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          height: 1.3),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Let us find you an event for your interest',
                      style: TextStyle(
                          color: CupertinoColors.white.withOpacity(.8),
                          fontSize: 25),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              CupertinoButton(
                onPressed: () {
                  _scaleController.forward();
                },
                child: AnimatedBuilder(
                  animation: _scaleController,
                  builder: (_, child) => Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius:
                            _scaleController.status == AnimationStatus.dismissed
                                ? BorderRadius.circular(10)
                                : null,
                        color: CupertinoColors.activeOrange,
                        shape:
                            _scaleController.status != AnimationStatus.dismissed
                                ? BoxShape.circle
                                : BoxShape.rectangle,
                      ),
                      alignment: Alignment.center,
                      child:
                          _scaleController.status == AnimationStatus.dismissed
                              ? const Text('Find nearest event',
                                  style: TextStyle(
                                      color: CupertinoColors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500))
                              : null,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom + 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
