import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const ServiceCard({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //elevation: 2.0,
      //margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Image.asset(image, height: 50),
              const SizedBox(height: 5.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
