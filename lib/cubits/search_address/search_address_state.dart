import 'package:equatable/equatable.dart';
import 'package:konsi/models/address.dart';

abstract class SearchAddressState extends Equatable {}

class InitialSearchAddress extends SearchAddressState {
  @override
  List<Object?> get props => [];
}

class LoadingSearchAddress extends SearchAddressState {
  @override
  List<Object?> get props => [];
}

class ErrorSearchAddress extends SearchAddressState {
  final String message;

  ErrorSearchAddress({required this.message});

  @override
  List<Object?> get props => [message];
}

class SuccessSearchAddress extends SearchAddressState {
  final List<Address> adresses;

  SuccessSearchAddress({required this.adresses});

  @override
  List<Object?> get props => [adresses];
}
