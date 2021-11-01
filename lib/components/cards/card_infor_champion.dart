import 'package:flutter/material.dart';
import 'dart:ui';

class CardInforChampion extends StatelessWidget {

  final String title;
  final Widget component;

  const CardInforChampion({
    Key? key,
    required this.title,
    required this.component
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF111111),
        borderRadius: BorderRadius.only( 
          bottomLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )
            ),
          ),
          component
        ],
      ),
    );
  }
}