import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:konsi/cubits/generate_map/map_cubit.dart';
import 'package:konsi/cubits/generate_map/map_state.dart';
import 'package:latlong2/latlong.dart';

class MapFlutter extends StatefulWidget {
  final String addressDescription;

  const MapFlutter({
    Key? key,
    required this.addressDescription,
  }) : super(key: key);

  @override
  _MapFlutterState createState() => _MapFlutterState();
}

class _MapFlutterState extends State<MapFlutter> {
  late MapCubit _mapCubit;

  @override
  void initState() {
    _mapCubit = context.read<MapCubit>();
    _mapCubit.loadMap(widget.addressDescription);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      bloc: _mapCubit,
      builder: (context, mapState) {
        if (mapState is LoadingMapState) {
          return _loadingContainer(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10.0),
                Text(
                  mapState.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          );
        }

        if (mapState is ErrorMapState) {
          return _loadingContainer(
            Text(
              "${mapState.message}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          );
        }

        if (mapState is SuccessMapState) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              height: 200.0,
              width: double.infinity,
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(mapState.latitude, mapState.longitude),
                  zoom: 16.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "https://api.mapbox.com/styles/v1/castroclucas/ckrnh4hwpahsj17o2nz5n2l2q/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiY2FzdHJvY2x1Y2FzIiwiYSI6ImNrcm5mOGRjbDAwcnAycG8zdXlib3VjeGYifQ.-yjsnJ6Gqcrao5ac-_Q6cg",
                    additionalOptions: {
                      'accessToken':
                          'pk.eyJ1IjoiY2FzdHJvY2x1Y2FzIiwiYSI6ImNrcm5mOGRjbDAwcnAycG8zdXlib3VjeGYifQ.-yjsnJ6Gqcrao5ac-_Q6cg',
                      'id': 'mapbox.satellite'
                    },
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(mapState.latitude, mapState.longitude),
                        builder: (ctx) => Container(
                          child: Icon(
                            Icons.location_on_sharp,
                            color: Colors.red,
                            size: 45.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget _loadingContainer(Widget content) {
    return Container(
      padding: EdgeInsets.all(10.0),
      height: 200.0,
      width: double.infinity,
      foregroundDecoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(child: content),
    );
  }
}
