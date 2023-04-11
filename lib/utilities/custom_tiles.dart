import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  const CustomTile(
      {super.key,
      required this.heading,
      required this.description,
      required this.icon,
      this.size = const Size(150, 170)});

  final String heading;
  final String description;
  final Icon icon;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 140),
      padding: const EdgeInsets.all(10),
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3)),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              heading,
              style: const TextStyle(
                  fontFamily: 'Ubuntu-bold',
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              description,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const Spacer(),
          Align(alignment: Alignment.bottomRight, child: icon),

          // Image(
          //   image: AssetImage(
          //     'images/eatopia.png',
          //   ),
          //   height: 30,
          //   width: 100,
          // ),
        ],
      ),
    );
  }
}

class ImageTile extends StatelessWidget {
  const ImageTile(
      {super.key,
      required this.heading,
      required this.description,
      required this.image});

  final String heading;
  final String description;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              heading,
              style: const TextStyle(
                  fontFamily: 'Ubuntu-bold',
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              description,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }
}
