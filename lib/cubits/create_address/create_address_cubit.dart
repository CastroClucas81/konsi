import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsi/cubits/create_address/create_address_state.dart';
import 'package:konsi/models/address.dart';
import 'package:konsi/repositories/address_repository_interface.dart';

class CreateAddressCubit extends Cubit<CreateAddressState> {
  CreateAddressCubit(this._addressRepository)
      : super(InitialCreateAddressState());

  final AddressRepositoryInterface _addressRepository;

  Future<void> createAddress(Address address) async {
    try {
      emit(LoadingCreateAddressState());

      await _addressRepository.create(address);

      emit(SuccessCreateAddressState(message: "Cadastro realizado com sucesso!"));
    } catch (err) {
      emit(ErrorCreateAddressState(message: err.toString()));
    }
  }
}
