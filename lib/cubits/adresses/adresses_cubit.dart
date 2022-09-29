import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsi/cubits/adresses/adresses_state.dart';
import 'package:konsi/models/address.dart';
import 'package:konsi/repositories/address_repository_interface.dart';

class AdressesCubit extends Cubit<AdressesState> {
  AdressesCubit(this._addressRepository) : super(LoadingAdressesState());

  final AddressRepositoryInterface _addressRepository;

  Future<void> fetchInitial() async {
    try {
      final address = await _addressRepository.listAll();

      if (address.length == 0) {
        emit(EmptyAdressesState(message: "Não há endereços cadastrados!"));
        return;
      }

      emit(SucessAdressesState(adresses: address));
    } catch (err) {
      emit(EmptyAdressesState(message: err.toString()));
    }
  }

  void replaceAdresses(List<Address> newAdresses) {
    emit(SucessAdressesState(adresses: newAdresses));
  }

  void replaceStateForError(String messageError) {
    emit(EmptyAdressesState(message: messageError));
  }
}
