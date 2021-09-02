import 'package:flutter/material.dart';

class AnimatedColorText extends StatefulWidget {
  final String text;
  final ColorTween tween;
  final Key? key;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final Duration colorDuration;
  final Duration lightDuration;

  const AnimatedColorText({
    this.text = "Hello",
    required this.tween,
    this.textAlign = TextAlign.right,
    this.fontSize = 80,
    this.fontWeight = FontWeight.bold,
    this.colorDuration = const Duration(seconds: 5),
    this.lightDuration = const Duration(seconds: 10),
    this.key,
  }) : super(key: key);

  @override
  _ColorTextState createState() => _ColorTextState(text, tween, textAlign,
      fontSize, fontWeight, colorDuration, lightDuration);
}

class _ColorTextState extends State<AnimatedColorText>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController positionController;
  late Animation<double?> _positionAnim;
  late Animation<Color?> _colorAnim;

  String text;
  ColorTween tween;
  double fontSize;
  FontWeight fontWeight;
  TextAlign textAlign;
  Duration colorDuration;
  Duration lightDuration;

  _ColorTextState(this.text, this.tween, this.textAlign, this.fontSize,
      this.fontWeight, this.colorDuration, this.lightDuration);

  @override
  void initState() {
    super.initState();
    positionController =
        AnimationController(vsync: this, duration: lightDuration);
    controller = AnimationController(
        duration: colorDuration, reverseDuration: colorDuration, vsync: this);
    _colorAnim = tween.animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    _positionAnim = Tween(begin: -1.0, end: 2.0).animate(positionController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          positionController.reset();
          positionController.forward();
        }
      });

    controller.forward();
    positionController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
              fontSize: fontSize, fontWeight: fontWeight, color: Colors.white),
        ),
        shaderCallback: (rect) {
          return LinearGradient(stops: [
            _positionAnim.value! - 1,
            _positionAnim.value!,
            _positionAnim.value! + 1
          ], colors: [
            _colorAnim.value!,
            _colorAnim.value!.withAlpha(120),
            _colorAnim.value!,
          ]).createShader(rect);
        });
  }
}
