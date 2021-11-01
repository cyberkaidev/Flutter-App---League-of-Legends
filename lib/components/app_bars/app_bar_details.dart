import 'package:flutter/material.dart';

class AppBarDetails extends StatelessWidget {
  
  final String name;
  final int isFavorite;
  final Function onSubmit;
  
  const AppBarDetails({
    Key? key,
    required this.name,
    required this.isFavorite,
    required this.onSubmit
  }) : super(key: key);

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
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () {
              onSubmit(
                {'id': name},
                isFavorite.isNegative
              );
            },
            child: Icon(
              isFavorite.isNegative
              ? Icons.favorite_border_sharp
              : Icons.favorite,
              color: const Color(0xFF0CDEFF)
            ),
          ),
        )
      ],
    );
  }
}