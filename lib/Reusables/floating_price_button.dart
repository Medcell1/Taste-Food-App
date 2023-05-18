import 'package:flutter/material.dart';

class PriceButton extends StatefulWidget {
  final String label;

  const PriceButton({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  State<PriceButton> createState() => _PriceButtonState();
}

class _PriceButtonState extends State<PriceButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () {},
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
