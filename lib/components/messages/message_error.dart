import 'package:flutter/material.dart';

class MessageError extends StatelessWidget {
  const MessageError({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Opacity(
        opacity: 0.5,
        child: Text(
          'Ops...\nAlgo deu errado\nvolte mais tarde',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}