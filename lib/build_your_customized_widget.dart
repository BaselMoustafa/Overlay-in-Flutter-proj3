import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BuildYourCustomizedWidget extends StatefulWidget {
  const BuildYourCustomizedWidget({super.key});
  @override
  State<BuildYourCustomizedWidget> createState() => _BuildYourCustomizedWidgetState();
}

class _BuildYourCustomizedWidgetState extends State<BuildYourCustomizedWidget> {
  double _width=1;
  double _height=50;
  late Timer _timer;
  double _opacityOfWord=0;
  @override
  void initState() {
    _timer=Timer(
      const Duration(milliseconds: 200),
      (){
        _width=MediaQuery.of(context).size.width;
        _opacityOfWord=1;
        _timer.cancel();
        setState(() {});
      }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style:const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
      child: Align(
        alignment: Alignment.topCenter,
        child: AnimatedContainer(
          duration:const Duration(seconds: 1),
          height: _height,
          width: _width,
          margin:const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: AnimatedOpacity(
            opacity: _opacityOfWord, 
            duration:const Duration(milliseconds: 1300),
            child:const Text("Follower"),
            ),
        ),
      ),
    );
  }
}