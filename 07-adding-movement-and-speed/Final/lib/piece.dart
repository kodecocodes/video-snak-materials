import 'package:flutter/material.dart';

class Piece extends StatefulWidget {
  final int posX, posY;
  final int size;
  final Color color;
  final bool isAnimated;

  const Piece(
      {Key key,
      this.posX,
      this.posY,
      this.size,
      this.color = const Color(0XFFBF3100),
      this.isAnimated = false})
      : super(key: key);

  @override
  _PieceState createState() => _PieceState();
}

class _PieceState extends State<Piece> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    if (widget.isAnimated) {
      _animationController = AnimationController(
        lowerBound: 0.25,
        upperBound: 1.0,
        duration: Duration(milliseconds: 1000),
        vsync: this,
      );
      _animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
      _animationController.addListener(() {
        setState(() {});
      });

      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.posX.toDouble(),
      top: widget.posY.toDouble(),
      child: Opacity(
        opacity: widget.isAnimated ? _animationController.value : 1.0,
        child: Container(
          width: widget.size.toDouble(),
          height: widget.size.toDouble(),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.all(
              Radius.circular(
                widget.size.toDouble(),
              ),
            ),
            border: Border.all(color: Colors.black, width: 2.0),
          ),
        ),
      ),
    );
  }
}
