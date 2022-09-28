import 'package:equatable/equatable.dart';
import 'package:konsi/models/address.dart';

abstract class AdressesState extends Equatable {}

class LoadingAdressesState extends AdressesState {
  @override
  List<Object?> get props => [];
}

class ErrorAdressesState extends AdressesState {
  final String message;

  ErrorAdressesState({required this.message});

  @override
  List<Object?> get props => [];
}

class EmptyAdressesState extends AdressesState {
  final String message;

  EmptyAdressesState({required this.message});

  @override
  List<Object?> get props => [];
}

class SucessAdressesState extends AdressesState {
  final List<Address> adresses;

  SucessAdressesState({required this.adresses});

  @override
  List<Object?> get props => [adresses];
}
