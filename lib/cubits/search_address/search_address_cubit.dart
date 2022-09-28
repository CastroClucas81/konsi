import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsi/cubits/search_address/search_address_state.dart';
import 'package:konsi/repositories/address_repository_interface.dart';

class SearchAddressCubit extends Cubit<SearchAddressState> {
  SearchAddressCubit(this._addressRepository) : super(InitialSearchAddress());

  final AddressRepositoryInterface _addressRepository;

  Future<void> searchAdress(String cep) async {
    try {
      emit(LoadingSearchAddress());

      final adresses = await _addressRepository.findByCEP(cep);

      emit(SuccessSearchAddress(adresses: adresses));
    } catch (err) {
      emit(ErrorSearchAddress(message: err.toString()));
    }
  }
}
