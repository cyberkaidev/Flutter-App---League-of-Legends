import 'package:flutter/material.dart';

class AppBarBack extends StatelessWidget {
  
  final String name;
  
  const AppBarBack({ Key? key, required this.name }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: double.infinity,
      elevation: 0,
      toolbarHeight: AppBar().preferredSize.height + 15,
      leading: GestureDetector(
        onTap: () { Navigator.pop(context); },
        child: Container(
          margin: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF0CDEFF)
              ),
              Text(
                name,
                style: const TextStyle(
                  color: Color(0xFF0CDEFF),
                  fontWeight: FontWeight.bold
                )
              )
            ],
          ),
        ), 
      ),
    );
  }
}