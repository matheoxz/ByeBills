import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class Unknown extends StatelessWidget {
  final Function() backToHome;
  const Unknown({Key? key, required this.backToHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _title(context),
    );
  }

  _title(context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double fontSize = width < height ? height / 5 : width / 7;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        leading: IconButton(
          onPressed: backToHome,
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: TextLiquidFill(
        text: 'error\n   404',
        boxHeight: height,
        boxWidth: width,
        waveColor: Colors.teal.shade400,
        loadDuration: const Duration(seconds: 15),
        waveDuration: const Duration(seconds: 15),
        loadUntil: 0.7,
        boxBackgroundColor: Colors.amber,
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
