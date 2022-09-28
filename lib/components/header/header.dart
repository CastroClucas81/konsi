import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Caderneta de Endereços",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
