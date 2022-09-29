import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:konsi/cubits/generate_map/map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(InitialMapState());

  Future<void> loadMap(String addressDescription) async {
    try {
      emit(LoadingMapState(
          message:
              "Estamos localizando o endereço no mapa (isso pode levar alguns instantes)"));

      GeoCode _geoCode = GeoCode();

      Coordinates coordinates = await _geoCode.forwardGeocoding(
          address: addressDescription.replaceAll("Avenida", "Av"));

      emit(SuccessMapState(
        latitude: coordinates.latitude!,
        longitude: coordinates.longitude!,
      ));
    } catch (e) {
      emit(ErrorMapState(
          message: "Não foi possível encontrar as cordenadas no mapa"));
    }
  }
}
