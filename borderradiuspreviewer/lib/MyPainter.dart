import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class MyPainter extends CustomPainter{

  double diffX;
  double diffY;

  MyPainter({this.diffX, this.diffY});


  Paint myPaint = Paint()
  ..isAntiAlias = true
  ..strokeWidth = 2.0
  ..style = PaintingStyle.stroke;


  @override
  void paint(Canvas canvas, Size size) {
    print("diffX: $diffX");
    print("diffY: $diffY");

    Offset center = Offset(size.width/2, size.height/2);

    double marginWidth = 50;
    double marginHeight = 50;

    double rectWidth = size.width - marginWidth;
    double rectHeight = size.height - marginHeight;

    Rect rectFrame = Rect.fromCenter(center: center, width: rectWidth, height: rectHeight);

    canvas.drawRect(rectFrame, myPaint);

    if(diffX > rectWidth/2){
      diffX = rectWidth/2;
    }

    if(diffY > rectHeight/2){
      diffY = rectHeight/2;
    }
    
  
    Offset pointTopLeft     =   Offset(marginWidth/2 + diffX, marginHeight/2);
    Offset pointTopRight    =   Offset(marginWidth/2 + rectWidth - diffX, marginHeight/2);
    Offset pointBottomLeft  =   Offset(marginWidth/2 + diffX, marginHeight/2 + rectHeight);
    Offset pointBottomRight =   Offset(marginWidth/2 + rectWidth - diffX, marginHeight/2 + rectHeight);
    Offset pointLeftTop     =   Offset(marginWidth/2, marginHeight/2 + diffY);
    Offset pointLeftBottom  =   Offset(marginWidth/2 , marginHeight/2 + rectHeight - diffY);
    Offset pointRightTop    =   Offset(marginWidth/2 + rectWidth, marginHeight/2+diffY);
    Offset pointRIghtBottom =   Offset(marginWidth/2 + rectWidth , marginHeight/2 + rectHeight -diffY);

    List<Offset> points = [pointTopLeft, pointTopRight, pointBottomLeft, pointBottomRight,
      pointLeftTop, pointLeftBottom, pointRightTop, pointRIghtBottom];

    myPaint.strokeWidth = 2;
    myPaint.strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.points, points, myPaint);

    myPaint.strokeWidth = 2;
    myPaint.style = PaintingStyle.stroke;
    _drawArc(canvas, myPaint, pointTopLeft, pointLeftTop, pi);
    _drawArc(canvas, myPaint, pointTopRight, pointRightTop, pi*3/2);
    _drawArc(canvas, myPaint, pointBottomLeft, pointLeftBottom, pi/2);
    _drawArc(canvas, myPaint, pointBottomRight, pointRIghtBottom, 0);

  

    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return oldDelegate.diffX != this.diffX || oldDelegate.diffY != this.diffY;
  }
  
  void _drawArc(Canvas canvas, Paint paint, Offset point1, Offset point2, double startAngle){
    Offset center = Offset(point1.dx, point2.dy);

    Rect rect = Rect.fromCenter(center: center, width: (point2.dx - point1.dx).abs()*2, 
      height: (point2.dy - point1.dy).abs()*2);

    canvas.drawArc(rect, startAngle, pi/2, false, paint);  
  }

}