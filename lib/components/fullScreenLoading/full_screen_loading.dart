import 'package:flutter/material.dart';

class FullScreenLoading extends StatelessWidget {
  const FullScreenLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 8.0,
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                "aguarde, carregando...",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
