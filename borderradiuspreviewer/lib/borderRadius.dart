import 'package:borderradiuspreviewer/MyPainter.dart';
import 'package:flutter/material.dart';

class borderRadius extends StatefulWidget {
  borderRadius({Key key}) : super(key: key);

  @override
  _borderRadiusState createState() => _borderRadiusState();
}

class _borderRadiusState extends State<borderRadius> {

  double _x = 0.0;
  double _y = 0.0;

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('border radius previwer'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: GestureDetector(
            onHorizontalDragStart: (detail){
              _x = detail.globalPosition.dx;
            },
            onVerticalDragStart: (detail){
              _y = detail.globalPosition.dy;
            },
            onHorizontalDragUpdate: (detail){
              setState(() {
                _x = detail.globalPosition.dx;
              });
            },
            onVerticalDragUpdate: (detail){
              setState(() {
                _y = detail.globalPosition.dy;
              });
            },
            
            child:Container(
              width: screenSize.width*0.8,
              height: screenSize.height*0.8,
              color: Colors.grey,
              child: CustomPaint(
                painter: MyPainter(diffX: _x*0.8, diffY: _y*0.8),
              ),
            ),
          )
        ),
      ),
    );
  }
}