import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:lol/pages/details/details_page.dart';
import 'dart:ui';

class CardChampion extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String title;
  final List tags;
  final int isFavorite;
  final Function onSubmit;

  const CardChampion(
    {
      Key? key, 
      required this.id,
      required this.name,
      required this.image,
      required this.title,
      required this.tags,
      required this.isFavorite,
      required this.onSubmit
    }
  ) : super(key: key);

  @override
  _CardChampionState createState() => _CardChampionState();
}

class _CardChampionState extends State<CardChampion>{

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsPage(
              id: widget.id,
              name: widget.name,
            ))
          );
        },
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width-80,
              width: MediaQuery.of(context).size.width-60,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20)
                ),
                color: Color(0xFF111111),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20)
                ),
                child: Stack(
                  children: [ 
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
            Container(
              height: 90,
              width: MediaQuery.of(context).size.width-60,
              padding: const EdgeInsets.only(left: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only( 
                  bottomLeft: Radius.circular(20)
                ),
                color: Color(0xFF111111),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(StringUtils.capitalize(widget.title)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(widget.tags.length, (index) => (
                          Text(
                            index+1 == widget.tags.length ?
                            widget.tags[index] :
                            widget.tags[index]+" - ",
                            style: const TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic
                            ),
                          )
                        )),
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        widget.onSubmit(
                          {
                            'name': widget.name,
                            'image': widget.image,
                            'title': widget.title,
                            'tags': widget.tags,
                            'id': widget.id
                          },
                          widget.isFavorite.isNegative
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20)
                          ),
                          color: Color(0xFF0CDEFF)
                        ),
                        child: Icon(
                          widget.isFavorite.isNegative
                          ? Icons.favorite_border_sharp
                          : Icons.favorite,
                          color: const Color(0xFF111111)
                        ),
                      ),
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
