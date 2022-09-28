import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsi/components/customInput/custom_input.dart';
import 'package:konsi/components/fullScreenLoading/full_screen_loading.dart';
import 'package:konsi/cubits/adresses/adresses_cubit.dart';
import 'package:konsi/cubits/adresses/adresses_state.dart';
import 'package:konsi/cubits/search_address/search_address_cubit.dart';
import 'package:konsi/cubits/search_address/search_address_state.dart';

class AdressesScreen extends StatefulWidget {
  const AdressesScreen({Key? key}) : super(key: key);

  @override
  State<AdressesScreen> createState() => _AdressesScreenState();
}

class _AdressesScreenState extends State<AdressesScreen> {
  final _searchController = MaskedTextController(mask: "00000-000");
  late AdressesCubit _adressesCubit;
  late SearchAddressCubit _searchAddressCubit;

  @override
  void initState() {
    _adressesCubit = context.read<AdressesCubit>();
    _searchAddressCubit = context.read<SearchAddressCubit>();
    _adressesCubit.fetchInitial();
    super.initState();
  }

  _handleConfirmEditing() {
    FocusManager.instance.primaryFocus?.unfocus();
    _searchAddressCubit.searchAdress(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<AdressesCubit, AdressesState>(
          bloc: _adressesCubit,
          builder: (context, adressesState) {
            if (adressesState is LoadingAdressesState) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }

            if (adressesState is ErrorAdressesState) {
              return Center(
                child: Text(
                  adressesState.message,
                  style: TextStyle(fontSize: 18.0),
                ),
              );
            }

            if (adressesState is EmptyAdressesState) {
              return Center(
                child: Text(
                  adressesState.message,
                  style: TextStyle(fontSize: 18.0),
                ),
              );
            }

            if (adressesState is SucessAdressesState) {
              return ListView(
                padding: EdgeInsets.all(10.0),
                children: [
                  BlocListener<SearchAddressCubit, SearchAddressState>(
                    bloc: _searchAddressCubit,
                    listener: (context, searchState) {
                      if (searchState is SuccessSearchAddress) {
                        _adressesCubit.replaceAdresses(searchState.adresses);
                      }

                      if (searchState is ErrorSearchAddress) {
                        _adressesCubit
                            .replaceStateForError(searchState.message);
                      }
                    },
                    child: CustomInput(
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      hintText: "Pesquisar por um CEP cadastrado...",
                      prefixIcon: Icon(Icons.search),
                      onEditingComplete: _handleConfirmEditing,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: adressesState.adresses.length,
                    itemBuilder: (context, index) {
                      final currentAddress = adressesState.adresses[index];

                      return Card(
                        child: InkWell(
                          onTap: () {},
                          child: ListTile(
                            title: Text(
                              'CEP - ${currentAddress.cep}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              '${currentAddress.street}, ${currentAddress.district}, ${currentAddress.city} - ${currentAddress.uf}',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }

            return Container();
          },
        ),
        BlocBuilder<SearchAddressCubit, SearchAddressState>(
          bloc: _searchAddressCubit,
          builder: (context, searchState) {
            if (searchState is LoadingSearchAddress) {
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
    _searchController.dispose();
    super.dispose();
  }
}
