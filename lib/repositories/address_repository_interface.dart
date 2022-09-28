import 'package:konsi/models/address.dart';

abstract class AddressRepositoryInterface {
  Future<Address> searchApiCEP(String cep);
  Future<List<Address>> listAll();
  Future<void> create(Address address);
  Future<List<Address>> findByCEP(String cep);
}