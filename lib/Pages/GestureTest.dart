import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../Widgets/gestureTickBox.dart';

class GesturePage extends StatefulWidget {
  const GesturePage({Key? key}) : super(key: key);

  @override
  State<GesturePage> createState() => _GesturePageState();
}

class _GesturePageState extends State<GesturePage> {
  bool longpress = false;
  bool doubletap = false;
  bool verticaldrag = false;
  bool horizontaldrag = false;
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(centerTitle: true,title: Text('Gesture Test'),backgroundColor: Colors.black,),
      body: Container(color: Colors.white,
        child: Row(
          children: [
            Spacer(),
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Column(
                children: [
                  Spacer(),
                  Flexible(
                    fit: FlexFit.tight,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          longpress = false;
                        });
                      },
                      onLongPress: () {
                        setState(() {
                          longpress = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: Center(child: Text("On Long Press")),
                      ),
                    ),
                  ),
                  Spacer(),
                  Flexible(
                    fit: FlexFit.tight,
                    child: InkWell(
                        onLongPress: () {
                          setState(() {
                            doubletap = false;
                          });
                        },
                        onDoubleTap: () {
                          setState(() {
                            doubletap = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          child: Center(child: Text("On Double Tap")),
                        )),
                  ),
                  Spacer(),
                  Flexible(
                    fit: FlexFit.tight,
                    child: InkWell(onTap: (){},
                      child: GestureDetector(
                          onVerticalDragUpdate: (details) {
                            if (details.delta.dy > 0 || details.delta.dy < 0) {
                              setState(() {
                                verticaldrag = true;
                              });
                            }
                          },
                          onVerticalDragEnd: (details) {
                            setState(() {
                              verticaldrag = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            child: Center(child: Text("On Vertical Drag")),
                          )),
                    ),
                  ),
                  Spacer(),
                  Flexible(
                    fit: FlexFit.tight,
                    child: InkWell(onTap: (){},
                      child: GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          if (details.delta.dx > 0 || details.delta.dx < 0) {
                            setState(() {
                              horizontaldrag = true;
                            });
                          }
                        },
                        onHorizontalDragEnd: (details) {
                          setState(() {
                            horizontaldrag = false;
                          });
                        },
                        child: Container(
                          child: Center(child: Text("On Horizontal Drag")),
                          decoration: BoxDecoration(border: Border.all()),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Flexible(
                    fit: FlexFit.tight,
                    child: InkWell(
                      onTap: () {},
                      onHover: (isHovering) {
                        setState(() {
                          hover = isHovering;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: Center(child: Text("On Hover")),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Column(
                children: [
                  Spacer(),
                  Flexible(
                      fit: FlexFit.tight,
                      child: Center(child: gestureCheck(check: longpress))),
                  Spacer(),
                  Flexible(
                      fit: FlexFit.tight,
                      child: Center(child: gestureCheck(check: doubletap))),
                  Spacer(),
                  Flexible(
                      fit: FlexFit.tight,
                      child: Center(child: gestureCheck(check: verticaldrag))),
                  Spacer(),
                  Flexible(
                      fit: FlexFit.tight,
                      child:
                          Center(child: gestureCheck(check: horizontaldrag))),
                  Spacer(),
                  Flexible(
                      fit: FlexFit.tight,
                      child: Center(child: gestureCheck(check: hover))),
                  Spacer(),
                ],
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
