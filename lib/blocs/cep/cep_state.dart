import 'package:equatable/equatable.dart';
import 'package:konsi/models/address.dart';

abstract class CepState extends Equatable {}

class InitialCepState extends CepState {
  @override
  List<Object?> get props => [];
}

class LoadingCepState extends CepState {
  @override
  List<Object?> get props => [];
}

class ErrorCepState extends CepState {
  final String message;

  ErrorCepState({required this.message});

  @override
  List<Object?> get props => [message];
}

class SuccessCepState extends CepState {
  final Address address;

  SuccessCepState({required this.address});

  @override
  List<Object?> get props => [address];
}
