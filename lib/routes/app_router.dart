import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konsi/models/address.dart';
import 'package:konsi/screens/address_detail_screen.dart';
import 'package:konsi/screens/dashboard_screen.dart';

class AppRouter {
  static const String initialRoute = "/dashboard";

  Route onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case "/dashboard":
        return MaterialPageRoute(
          builder: (_) => DashboardScreen(),
        );
      case "/address-details":
        if (args is Address) {
          return MaterialPageRoute(
            builder: (_) => AddressDetailScreen(address: args),
          );
        }

        return _undefined();
      default:
        return _undefined();
    }
  }

  static Route<dynamic> _undefined() {
    return MaterialPageRoute(
      builder: (_) {
        return const Scaffold(
          body: Center(
            child: Text(
              "Página indefinida.",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
