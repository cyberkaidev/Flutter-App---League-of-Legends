import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:lol/pages/details/details_page.dart';
import 'dart:ui';

class CardChampion extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String title;
  final String iconChampion;
  final List tags;
  final Function onSubmit;

  const CardChampion(
    {
      Key? key, 
      required this.id,
      required this.name,
      required this.image,
      required this.title,
      required this.iconChampion,
      required this.tags,
      required this.onSubmit
    }
  ) : super(key: key);

  @override
  _CardChampionState createState() => _CardChampionState();
}

class _CardChampionState extends State<CardChampion>{

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsPage(
            id: widget.id,
            name: widget.name,
          ))
        );
      },
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.width-40,
            width: MediaQuery.of(context).size.width-40,
            margin: const EdgeInsets.only(bottom: 25),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only( 
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20)
              ),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only( 
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20)
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
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
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                      child: Container(
                        color: const Color(0xFFF6F6F6).withOpacity(0.8),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                            border: Border.all(
                              width: 2,
                              color: Colors.white
                            )
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              widget.iconChampion,
                              height: 110,
                            ),
                          )
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only( 
                              bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(20)
                            ),
                            color: Colors.white
                          ),
                          child: Column(
                            children: [
                              Text(
                                widget.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF111111),
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  StringUtils.capitalize(widget.title),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF111111),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(widget.tags.length, (index) => (
                                  Text(
                                    index+1 == widget.tags.length ?
                                    widget.tags[index] :
                                    widget.tags[index]+" - ",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF111111)
                                    ),
                                  )
                                )),
                              )
                            ],
                          )
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ),
          Positioned(
            left: 10,
            top: 13,
            child: Container(
              height: MediaQuery.of(context).size.width-50,
              width: MediaQuery.of(context).size.width-60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only( 
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                ),
                border: Border.all(color: const Color(0xFF111111), width: 1.5)
              ),
            ),
          ),
          Positioned(
            left: 12,
            top: 10,
            child: Container(
              height: MediaQuery.of(context).size.width-40,
              width: MediaQuery.of(context).size.width-60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only( 
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                ),
                border: Border.all(color: const Color(0xFF0CDEFF), width: 1.5)
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width-40,
            width: MediaQuery.of(context).size.width-40,
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      widget.onSubmit(widget.id, !isFavorite);
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only( 
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20)
                        ),
                        color: Color(0xFF111111)
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : 
                        Icons.favorite_border_sharp,
                        color: const Color(0xFF0CDEFF)
                      ),
                    ),
                  )
                )
              ]
            ),
          )
        ],
      ),
    );
  }
}
