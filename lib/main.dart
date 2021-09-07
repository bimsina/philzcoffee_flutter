import 'dart:math';

import 'package:flutter/material.dart';
import 'package:philzcoffee/card_model.dart';

final double _maxImageHeight = 280;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Philz Coffee',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xff2a2119),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController(initialPage: 2);
  int _currentPage = 2;
  double? _pageOffset = 2;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();

      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
      setState(() {
        _pageOffset = _pageController.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Material(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Philz coffee'),
          ),
          body: AnimatedContainer(
            duration: Duration(milliseconds: 150),
            color: cards[_currentPage % cards.length].backgroundColor,
            child: ListView(
              children: [
                SizedBox(
                  height: 0.7 * MediaQuery.of(context).size.height,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      PageView(
                        controller: _pageController,
                        children: cards.map((card) {
                          return SingleCard(
                            cardModel: card,
                          );
                        }).toList(),
                      ),
                      Column(
                        children: [
                          Expanded(child: Container()),
                          SizedBox(
                            height: _maxImageHeight,
                            child: IgnorePointer(
                              child: Stack(
                                children: cards
                                    .map((card) => SingleCardImage(
                                          cardModel: card,
                                          offset: _pageOffset,
                                          index: cards.indexOf(card),
                                          activeIndex: _currentPage,
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class SingleCard extends StatelessWidget {
  final CardModel? cardModel;

  SingleCard({
    Key? key,
    this.cardModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: cardModel!.cardColor,
          borderRadius: BorderRadius.circular(16.0)),
      duration: Duration(milliseconds: 150),
      child: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  cardModel!.tagLine,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(cardModel!.title,
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          )),
          SizedBox(height: _maxImageHeight),
          Expanded(
              child: Center(
                  child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
            decoration: BoxDecoration(
                color: const Color(0xff321b08),
                borderRadius: BorderRadius.circular(100.0)),
            child: Text(
              "I'll try it!",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ))),
        ],
      ),
    );
  }
}

class SingleCardImage extends StatelessWidget {
  final CardModel? cardModel;
  final double? offset;
  final int? index, activeIndex;

  SingleCardImage(
      {Key? key, this.cardModel, this.offset, this.index, this.activeIndex})
      : super(key: key);
  final viewPort = 0.5;
  final maxHeight = 0.4;

  @override
  Widget build(BuildContext context) {
    final realOffset = (offset! - index!);
    final dy = -realOffset * MediaQuery.of(context).size.width;

    return Center(
      child: Transform.translate(
        // offset: Offset(-realOffset * MediaQuery.of(context).size.width, 0),
        offset: Offset(
            !dy.isNegative ? min(dy, dy * viewPort) : max(dy, dy * viewPort),
            0),
        child: Transform.scale(
          scale: max(1 - realOffset.abs(), maxHeight),
          child: Image.asset(
            'assets/${cardModel!.imagePath}',
            height: _maxImageHeight,
          ),
        ),
      ),
    );
  }
}
