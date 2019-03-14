import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarView extends CustomPainter {
  Paint mHelpPaint;
  BuildContext context;

  StarView(this.context) {
    mHelpPaint = new Paint();
    mHelpPaint.style = PaintingStyle.stroke;
    mHelpPaint.color = Color(0xffBBC3C5);
    mHelpPaint.isAntiAlias = true;
  }

  //4.3:绘制网格
  @override
  void paint(Canvas canvas, Size size) {
    var winSize = MediaQuery.of(context).size;

    canvas.drawPath(gridPath(20, winSize), mHelpPaint);

    drawCoo(canvas, winSize / 2, winSize);


    canvas.translate(160, 320);//移动到坐标系原点
    canvas.drawPath(nStarPath(5,80,40), mHelpPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  /**
   * 绘制网格路径
   *
   * @param step    小正方形边长
   * @param winSize 屏幕尺寸
   */
  Path gridPath(int step, Size winSize) {
    Path path = new Path();

    for (int i = 0; i < winSize.height / step + 1; i++) {
      path.moveTo(0, step * i.toDouble());
      path.lineTo(winSize.width, step * i.toDouble());
    }

    for (int i = 0; i < winSize.width / step + 1; i++) {
      path.moveTo(step * i.toDouble(), 0);
      path.lineTo(step * i.toDouble(), winSize.height);
    }
    return path;
  }

  //绘制坐标系
  drawCoo(Canvas canvas, Size coo, Size winSize) {
    //初始化网格画笔
    Paint paint = new Paint();
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.stroke;

    //绘制直线
    canvas.drawPath(cooPath(coo, winSize), paint);
    //左箭头
    canvas.drawLine(new Offset(winSize.width, coo.height),
        new Offset(winSize.width - 10, coo.height - 6), paint);
    canvas.drawLine(new Offset(winSize.width, coo.height),
        new Offset(winSize.width - 10, coo.height + 6), paint);
    //下箭头
    canvas.drawLine(new Offset(coo.width, winSize.height-90),
        new Offset(coo.width - 6, winSize.height - 10-90), paint);



    canvas.drawLine(new Offset(coo.width, winSize.height-90),
        new Offset(coo.width + 6, winSize.height - 10-90), paint);
  }

  /**
   * 坐标系路径
   *
   * @param coo     坐标点
   * @param winSize 屏幕尺寸
   * @return 坐标系路径
   */
  Path cooPath(Size coo, Size winSize) {
    Path path = new Path();
    //x正半轴线
    path.moveTo(coo.width, coo.height);
    path.lineTo(winSize.width, coo.height);
    //x负半轴线
    path.moveTo(coo.width, coo.height);
    path.lineTo(coo.width - winSize.width, coo.height);
    //y负半轴线
    path.moveTo(coo.width, coo.height);
    path.lineTo(coo.width, coo.height - winSize.height);
    //y负半轴线
    path.moveTo(coo.width, coo.height);
    path.lineTo(coo.width, winSize.height);
    return path;
  }

  /**
   * n角星路径
   *
   * @param num 几角星
   * @param R   外接圆半径
   * @param r   内接圆半径
   * @return n角星路径
   */
  Path nStarPath(int num, double R, double r) {
    Path path = new Path();
    double perDeg = 360 / num; //尖角的度数
    double degA = perDeg / 2 / 2;
    double degB = 360 / (num - 1) / 2 - degA / 2 + degA;

    path.moveTo(cos(_rad(degA)) * R, (-sin(_rad(degA)) * R));
    for (int i = 0; i < num; i++) {
      path.lineTo(
          cos(_rad(degA + perDeg * i)) * R, -sin(_rad(degA + perDeg * i)) * R);
      path.lineTo(
          cos(_rad(degB + perDeg * i)) * r, -sin(_rad(degB + perDeg * i)) * r);
    }
    path.close();
    return path;
  }

  double _rad(double deg) {
    return deg * pi / 180;
  }

}
