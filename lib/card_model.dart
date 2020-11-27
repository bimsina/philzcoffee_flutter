import 'package:flutter/material.dart';

class CardModel {
  final String tagLine;
  final String title;
  final String imagePath;
  final Color cardColor;
  final Color backgroundColor;

  CardModel(this.tagLine, this.title, this.imagePath, this.cardColor,
      this.backgroundColor);
}

final List<CardModel> cards = [
  CardModel(
      'Thirsty for more holiday Gratitude?',
      'Candied Orange,Caramel, Warming spices',
      'tesora.png',
      const Color(0xffa36443),
      const Color(0xffa97052)),
  CardModel('Excited for an Ecstatic?', 'Large, No Cream, No Sugar, Iced',
      'dark.png', const Color(0xffab3500), const Color(0xff964700)),
  CardModel('Is it mint Mojito time?', 'Large, Creamy Cream, Sweet Sugar',
      'philharmonic.png', const Color(0xffaa601e), const Color(0xffb47f55)),
  CardModel(
      'How about an Iced Coffee Rosé?',
      'Medium, Creamy Cream, Sweet Sugar',
      'rose.png',
      const Color(0xff764014),
      const Color(0xff7f4818)),
  CardModel('Croissant?', 'Croissant Croissant Croissant', 'croissant.png',
      const Color(0xffa46246), const Color(0xffa97052)),
  CardModel(
      'How about an Iced Coffee Rosé?',
      'Medium, Creamy Cream, Sweet Sugar',
      'coldbrew.png',
      const Color(0xff105a09),
      const Color(0xff0e5413)),
];
