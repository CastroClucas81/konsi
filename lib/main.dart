import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsi/cubits/generate_map/map_cubit.dart';
import 'package:konsi/routes/app_router.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => MapCubit(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppRouter _appRouter = AppRouter();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Konsi',
      initialRoute: AppRouter.initialRoute,
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}
