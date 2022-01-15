import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stc_pay/const/colors.dart';
import 'package:stc_pay/const/static_data.dart';
import 'package:stc_pay/widgets/repeated_widgets.dart';

class OtherScreens extends StatefulWidget {
  final int currentPage;
  const OtherScreens({Key? key, required this.currentPage}) : super(key: key);

  @override
  _OtherScreensState createState() => _OtherScreensState();
}

class _OtherScreensState extends State<OtherScreens>
    with SingleTickerProviderStateMixin {
  //Controller for animation
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();

    //Applying animation duraion and mode
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animationController.forward();
  }

  //Disposing the animation controller to prevent the memory leaks
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //Initializing the class to access the static data
  final StaticData _staticData = StaticData();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      key: Key(widget.currentPage.toString()),
      animation: _animationController.view,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animationController.value * 2 * pi,
          child: _titleWidget(),
        );
      },
      child: _titleWidget(),
    );
  }

  //Style of text
  TextStyle get titleStyle => const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: PRIMARY_COLOR,
        height: 1.5,
      );

  //The text widget
  Widget _titleWidget() {
    return Center(
      child: Container(
          width: 300,
          height: 270,
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/${_staticData.pagesTitleIcons[widget.currentPage]}.png',
                width: 70,
                color: GREEN_COLOR,
              ),
              verticalSpace(10),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Hello stc pay :) \n',
                  style: titleStyle,
                  children: [
                    TextSpan(
                        text: _staticData.pagesTitle[widget.currentPage],
                        style: titleStyle.copyWith(
                            color: GREEN_COLOR, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
