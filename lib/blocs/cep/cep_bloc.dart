import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsi/blocs/cep/cep_event.dart';
import 'package:konsi/blocs/cep/cep_state.dart';
import 'package:konsi/repositories/address_repository_interface.dart';

class CepBloc extends Bloc<CepEvent, CepState> {
  CepBloc(this._addressRepository) : super(InitialCepState()) {
    on<FetchCepEvent>(_findCEPData);
    on<ResetCepEvent>(_resetCep);
  }

  final AddressRepositoryInterface _addressRepository;

  Future<void> _findCEPData(
      FetchCepEvent event, Emitter<CepState> emitter) async {
    try {
      emitter(LoadingCepState());

      final address = await _addressRepository.searchApiCEP(event.cep);

      emitter(SuccessCepState(address: address));
    } catch (err) {
      emitter(ErrorCepState(message: err.toString()));
    }
  }

  _resetCep(ResetCepEvent event, Emitter<CepState> emitter) {
    emitter(InitialCepState());
  }
}
