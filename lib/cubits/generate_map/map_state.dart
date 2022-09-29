import 'package:equatable/equatable.dart';

abstract class MapState extends Equatable {}

class InitialMapState extends MapState {
  @override
  List<Object?> get props => [];
}

class LoadingMapState extends MapState {
  final String message;

  LoadingMapState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ErrorMapState extends MapState {
  final String message;

  ErrorMapState({required this.message});

  @override
  List<Object?> get props => [message];
}

class SuccessMapState extends MapState {
  final double latitude;
  final double longitude;

  SuccessMapState({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}
