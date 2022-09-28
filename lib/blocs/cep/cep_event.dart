import 'package:equatable/equatable.dart';

abstract class CepEvent extends Equatable{}

class FetchCepEvent extends CepEvent {
  final String cep;

  FetchCepEvent({required this.cep});

  @override
  List<Object?> get props => [cep];
}