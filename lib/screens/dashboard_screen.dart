import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsi/blocs/cep/cep_bloc.dart';
import 'package:konsi/components/header/header.dart';
import 'package:konsi/cubits/adresses/adresses_cubit.dart';
import 'package:konsi/cubits/create_address/create_address_cubit.dart';
import 'package:konsi/cubits/search_address/search_address_cubit.dart';
import 'package:konsi/repositories/implementations/address_repository.dart';
import 'package:konsi/screens/adresses_screen.dart';
import 'package:konsi/screens/create_address_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AddressRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CepBloc(
              context.read<AddressRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => AdressesCubit(
              context.read<AddressRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CreateAddressCubit(
              context.read<AddressRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SearchAddressCubit(
              context.read<AddressRepository>(),
            ),
          ),
        ],
        child: _DashboardContainer(),
      ),
    );
  }
}

class _DashboardContainer extends StatelessWidget {
  const _DashboardContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Header(),
              Material(
                elevation: 2.0,
                color: Colors.blue,
                child: Container(
                  child: TabBar(
                    labelStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    labelColor: Colors.yellow,
                    unselectedLabelColor: Colors.white,
                    indicatorColor: Colors.yellow,
                    tabs: [
                      Tab(text: "Cadastrar Endereço"),
                      Tab(text: "Endereços Cadastrados"),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: TabBarView(
                  children: [
                    CreateAddressScreen(),
                    AdressesScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
