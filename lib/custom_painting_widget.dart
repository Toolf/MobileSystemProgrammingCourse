import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_application_1/toggleswitch_widget.dart';

class DrawingCanvas extends StatefulWidget {
  DrawingCanvas({Key key}) : super(key: key);

  @override
  _DrawingCanvasState createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  final List<CustomPainter> painters = [
    CosPainter(),
    PiePainter([
      PiePart(0.45, Colors.blue[400]),
      PiePart(0.05, Colors.purple),
      PiePart(0.25, Colors.yellow),
      PiePart(0.25, Colors.grey),
    ])
  ];

  int _painterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleSwitch(
                value: _painterIndex,
                onChange: (int value) {
                  setState(() {
                    _painterIndex = value;
                  });
                },
                activeColor: Colors.blue,
                children: ["Графік", "Діаграма"],
              ),
              Center(
                child: CustomPaint(
                  painter: painters[_painterIndex],
                  child: Container(
                    width: 300,
                    height: 250,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PiePart {
  final double percent;
  final Color color;
  PiePart(this.percent, this.color);
}

class PiePainter extends CustomPainter {
  final List<PiePart> parts;
  final double diametr;
  PiePainter(this.parts, {this.diametr = 100});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 4;

    Offset center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromLTRB(center.dx - diametr, center.dy - diametr,
        center.dx + diametr, center.dy + diametr);
    final useCenter = true;

    // ------- draw pie -------

    double startAngle = 0.0;
    for (PiePart p in parts) {
      paint.color = p.color;
      canvas.drawArc(rect, startAngle, p.percent * 2 * pi, useCenter, paint);
      startAngle += p.percent * 2 * pi;
    }

    // -------- draw white center ------
    paint.color = Colors.white;
    canvas.drawCircle(center, diametr / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CosPainter extends CustomPainter {
  final Function f = cos;
  final double rangeStart = -pi;
  final double rangeEnd = pi;

  @override
  void paint(Canvas canvas, Size size) {
    int pointCount = 30;
    int scale = 40;

    var paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    Offset center = Offset(size.width / 2, size.height / 2);

    // ----------- draw axises ------------
    canvas.drawLine(
        Offset(center.dx, size.height), Offset(center.dx, 0), paint);
    // draw arrow
    canvas.drawLine(Offset(center.dx, 0), Offset(center.dx - 5, 10), paint);
    canvas.drawLine(Offset(center.dx, 0), Offset(center.dx + 5, 10), paint);

    canvas.drawLine(Offset(0, center.dy), Offset(size.width, center.dy), paint);
    //drow arrow
    canvas.drawLine(Offset(size.width, center.dy),
        Offset(size.width - 10, center.dy - 5), paint);
    canvas.drawLine(Offset(size.width, center.dy),
        Offset(size.width - 10, center.dy + 5), paint);

    // ---------- line segment -----------
    Offset segment = Offset(center.dx + scale, center.dy);
    canvas.drawLine(Offset(segment.dx, segment.dy - 5),
        Offset(segment.dx, segment.dy + 5), paint);

    // ------------ calc function ------------
    paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    List<Point<double>> points = List();
    // calc cos(x) : x in [rangeStart, rangeEnd)
    // with step: (rangeEnd - rangeStart) / pointCount

    for (int i = 0; i < pointCount; i++) {
      var x = (rangeEnd - rangeStart) * i / pointCount + rangeStart;
      var y = f(x);
      points.add(Point(x, y));
    }

    // ----------- draw function ------------
    Point pointer = points[0];

    for (Point p in points) {
      Offset p1 =
          Offset(center.dx + pointer.x * scale, center.dy - pointer.y * scale);
      Offset p2 = Offset(center.dx + p.x * scale, center.dy - p.y * scale);

      canvas.drawLine(p1, p2, paint);
      pointer = p;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
