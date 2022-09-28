import 'package:equatable/equatable.dart';

abstract class CreateAddressState extends Equatable {}

class InitialCreateAddressState extends CreateAddressState {
  @override
  List<Object?> get props => [];
}

class LoadingCreateAddressState extends CreateAddressState {
  @override
  List<Object?> get props => [];
}

class ErrorCreateAddressState extends CreateAddressState {
  final String message;

  ErrorCreateAddressState({required this.message});

  @override
  List<Object?> get props => [message];
}

class SuccessCreateAddressState extends CreateAddressState {
  final String message;

  SuccessCreateAddressState({required this.message});

  @override
  List<Object?> get props => [message];
}