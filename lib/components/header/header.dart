import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final hasPop;

  const Header({
    Key? key,
    this.title = "Caderneta de Endereços",
    this.hasPop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      child: Container(
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: hasPop,
              replacement: Container(),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 28.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                title,
                textAlign: hasPop ? TextAlign.left : TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
