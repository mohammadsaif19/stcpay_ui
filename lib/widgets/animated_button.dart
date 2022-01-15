import 'package:flutter/material.dart';
import 'package:stc_pay/const/colors.dart';

//Chart option selection
class AnimatedSlidingButton extends StatefulWidget {
  final List<String> values;
  final ValueChanged<int> onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;
  final double width, height;

  const AnimatedSlidingButton({
    Key? key,
    required this.values,
    required this.onToggleCallback,
    required this.backgroundColor,
    required this.buttonColor,
    required this.textColor,
    required this.width,
    required this.height,
  }) : super(key: key);
  @override
  _AnimatedSlidingButtonState createState() => _AnimatedSlidingButtonState();
}

class _AnimatedSlidingButtonState extends State<AnimatedSlidingButton> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    double _width = widget.width;
    double _height = widget.height;
    bool initialPosition = currentIndex == 0;
    return SizedBox(
      width: _width,
      height: _height,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (currentIndex == 0) {
                currentIndex = 1;
              } else if (currentIndex == 1) {
                currentIndex = 0;
              }
              widget.onToggleCallback(currentIndex);
              setState(() {});
            },
            child: Container(
              width: _width,
              height: _height,
              decoration: ShapeDecoration(
                color: widget.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: widget.values
                    .map((icon) => Expanded(
                          child: Image.asset(
                            icon,
                            width: 25,
                            height: 25,
                            color: PRIMARY_COLOR,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment:
                initialPosition ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: _width / 2.5,
              height: _height - 5,
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: widget.buttonColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff4469A0).withOpacity(0.16),
                      offset: const Offset(0, 3),
                      blurRadius: 12,
                      spreadRadius: 0),
                ],
              ),
              child: Image.asset(
                widget.values[currentIndex],
                width: 25,
                height: 25,
                color: PRIMARY_COLOR,
              ),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
