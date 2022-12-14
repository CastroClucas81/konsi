import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsi/blocs/cep/cep_bloc.dart';
import 'package:konsi/blocs/cep/cep_event.dart';
import 'package:konsi/blocs/cep/cep_state.dart';
import 'package:konsi/components/custom_input/custom_input.dart';
import 'package:konsi/components/full_screen_loading/full_screen_loading.dart';
import 'package:konsi/components/map_flutter/map_flutter.dart';
import 'package:konsi/cubits/create_address/create_address_cubit.dart';
import 'package:konsi/cubits/create_address/create_address_state.dart';
import 'package:konsi/models/address.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

class CreateAddressScreen extends StatefulWidget {
  const CreateAddressScreen({Key? key}) : super(key: key);

  @override
  State<CreateAddressScreen> createState() => _CreateAddressScreenState();
}

class _CreateAddressScreenState extends State<CreateAddressScreen> {
  final _cepController = MaskedTextController(mask: "00000-000");
  final _streetController = TextEditingController();
  final _districtController = TextEditingController();
  final _cityController = TextEditingController();
  final _ufController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late CepBloc _cepBloc;
  late CreateAddressCubit _createAddressCubit;

  @override
  void initState() {
    _cepBloc = context.read<CepBloc>();
    _createAddressCubit = context.read<CreateAddressCubit>();
    super.initState();
  }

  _clearInputs() {
    _cepController.clear();
    _streetController.clear();
    _districtController.clear();
    _cityController.clear();
    _ufController.clear();
    _formKey.currentState!.reset();
  }

  _handleCreateNewAddress() {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();

      _createAddressCubit.createAddress(
        Address(
          cep: _cepController.text,
          city: _cityController.text,
          district: _districtController.text,
          street: _streetController.text,
          uf: _ufController.text,
        ),
      );
    }
  }

  _onChangeCEP(String value) {
    if (value.length == 9) {
      _cepBloc.add(FetchCepEvent(cep: _cepController.text.replaceAll("-", "")));
    }
  }

  _populateInputs(Address address) {
    _streetController.text = address.street!;
    _districtController.text = address.district!;
    _cityController.text = address.city!;
    _ufController.text = address.uf!;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cadastre um novo endere??o em sua caderneta a partir do formul??rio abaixo:",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  BlocListener<CepBloc, CepState>(
                    bloc: _cepBloc,
                    listener: (context, cepState) {
                      if (cepState is ErrorCepState) {
                        _clearInputs();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(cepState.message)),
                        );
                      }

                      if (cepState is SuccessCepState) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        _populateInputs(cepState.address);
                      }
                    },
                    child: CustomInput(
                      controller: _cepController,
                      textInputAction: TextInputAction.next,
                      hintText: "Insira o c??digo do CEP",
                      onChanged: _onChangeCEP,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira o c??digo do CEP!';
                        }

                        if (value.length < 9) {
                          return 'CEP inv??lido!';
                        }

                        return null;
                      },
                    ),
                  ),
                  CustomInput(
                    controller: _streetController,
                    textInputAction: TextInputAction.next,
                    hintText: "Insira o nome da Rua",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira o nome da rua!';
                      }
                      return null;
                    },
                  ),
                  CustomInput(
                    controller: _districtController,
                    textInputAction: TextInputAction.next,
                    hintText: "Insira o nome do bairro",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira o bairro!';
                      }
                      return null;
                    },
                  ),
                  CustomInput(
                    controller: _cityController,
                    textInputAction: TextInputAction.next,
                    hintText: "Insira o nome da Cidade",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira a cidade!';
                      }
                      return null;
                    },
                  ),
                  CustomInput(
                    maxLength: 2,
                    controller: _ufController,
                    hintText: "Insira o UF do estado",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira o UF!';
                      }

                      if (value.length < 1) {
                        return 'UF inv??lido!';
                      }

                      return null;
                    },
                  ),
                  BlocBuilder<CepBloc, CepState>(
                    bloc: _cepBloc,
                    builder: (context, cepState) {
                      if (cepState is SuccessCepState) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Localiza????o do endere??o atrav??s do CEP - ${cepState.address.cep}.",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                "Obs.: N??o ?? necess??rio esperar a conclus??o do carregamento para finalizar o cadastro.",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              SizedBox(height: 5.0),
                              MapFlutter(
                                addressDescription: cepState.address.toString(),
                              ),
                            ],
                          ),
                        );
                      }

                      return Container();
                    },
                  ),
                  BlocListener<CreateAddressCubit, CreateAddressState>(
                    bloc: _createAddressCubit,
                    listener: (context, createState) {
                      if (createState is ErrorCreateAddressState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(createState.message)),
                        );
                      }

                      if (createState is SuccessCreateAddressState) {
                        _cepBloc.add(ResetCepEvent());
                        _clearInputs();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(createState.message)),
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      child:
                          BlocBuilder<CreateAddressCubit, CreateAddressState>(
                        bloc: _createAddressCubit,
                        builder: (context, createAddress) {
                          if (createAddress is LoadingCreateAddressState) {
                            return ElevatedButton(
                              onPressed: () {},
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }

                          return ElevatedButton.icon(
                            onPressed: _handleCreateNewAddress,
                            icon: Icon(Icons.check),
                            label: Text("Confirmar cadastro"),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        BlocBuilder<CepBloc, CepState>(
          bloc: _cepBloc,
          builder: (context, cepState) {
            if (cepState is LoadingCepState) {
              return FullScreenLoading();
            }

            return Container();
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _cepController.dispose();
    _streetController.dispose();
    _districtController.dispose();
    _cityController.dispose();
    _ufController.dispose();
  }
}
