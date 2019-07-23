import 'package:flutter/material.dart';
import 'package:response_ui/common/app_bottom_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  double collapsedHeightFactor = 0.80;
  double expandedHeightFactor = 0.67;
  bool isAnimationCompleted = false;

  AnimationController _controller;
  Animation<double> _heightFactorAnimation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _heightFactorAnimation = Tween<double>(begin: collapsedHeightFactor, end: expandedHeightFactor).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  onBottomPartTap() {
    setState(() {
      if (isAnimationCompleted) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      isAnimationCompleted = !isAnimationCompleted;
    });
  }

  Widget getWidget() {
    return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: _heightFactorAnimation.value,
            child: Image.asset("images/a.jpg",
              height: 600.0,
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.hue,
              color: Colors.black),
          ),
          GestureDetector(
            onTap: () {
              onBottomPartTap();
            },
            child: FractionallySizedBox(
              alignment: Alignment.bottomCenter,
              heightFactor: 1.05 - _heightFactorAnimation.value,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))
                ),
              ),
            ),
          ),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomBar(),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, widget) {
          return getWidget();
        },
      ),
    );
  }
}