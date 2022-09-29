import 'package:flutter/material.dart';
import 'package:konsi/components/header/header.dart';
import 'package:konsi/components/map_flutter/map_flutter.dart';
import 'package:konsi/models/address.dart';

class AddressDetailScreen extends StatelessWidget {
  final Address address;

  const AddressDetailScreen({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(
              title: "Detalhes do endereço",
              hasPop: true,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    _title("CEP"),
                    _description(address.cep!),
                    _title("Rua"),
                    _description(address.street!),
                    _title("Bairro"),
                    _description(address.district!),
                    _title("Cidade"),
                    _description(address.city!),
                    _title("UF"),
                    _description(address.uf!),
                    _title("Localização do endereço no mapa"),
                    MapFlutter(addressDescription: address.toString()),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _title(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        '$title',
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _description(String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        '$description',
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.black38,
        ),
      ),
    );
  }
}
