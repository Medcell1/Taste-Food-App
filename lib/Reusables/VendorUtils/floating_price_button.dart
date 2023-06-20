import 'package:flutter/material.dart';

class PriceButton extends StatefulWidget {
  final String label;
  final dynamic onPressed;

  const PriceButton({
    Key? key,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  State<PriceButton> createState() => _PriceButtonState();
}

class _PriceButtonState extends State<PriceButton> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.4,
      child: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: widget.onPressed,
        label: Row(
          children: [
            Text(
              widget.label,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
