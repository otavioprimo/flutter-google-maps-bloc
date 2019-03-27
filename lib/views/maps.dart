import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/bloc/map_bloc.dart';
import 'package:google_maps/util/colors.dart';
import 'package:google_maps/widgets/carrousel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:google_maps/models/place.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  LatLng userCoords;

  _MapsState() {
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    final blocMap = BlocProvider.of<MapBloc>(context);
    final Completer<GoogleMapController> _mapController = Completer();

    void _onMapCreated(GoogleMapController controller) {
      if (!_mapController.isCompleted) {
        _mapController.complete(controller);
      }
    }

    Future<void> _onItemCarouselChange(Place place, index) async {
      GoogleMapController controller = await _mapController.future;
      CameraPosition _newPos = CameraPosition(
        target: LatLng(place.latitude, place.longitude),
        zoom: 14.5,
      );

      controller.animateCamera(CameraUpdate.newCameraPosition(_newPos));
    }

    Future<void> _moveMapToUser() async {
      GoogleMapController controller = await _mapController.future;
      CameraPosition _newPos = CameraPosition(
        target: LatLng(userCoords.latitude, userCoords.longitude),
        zoom: 14.5,
      );

      controller.animateCamera(CameraUpdate.newCameraPosition(_newPos));
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(AppColors.backgroundColor1),
            Color(AppColors.backgroundColor2),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.clamp,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: StreamBuilder<List<Place>>(
                  initialData: [],
                  stream: blocMap.outPlaces,
                  builder: (context, snapshotPlaces) {
                    return StreamBuilder<Map<MarkerId, Marker>>(
                      initialData: {},
                      stream: blocMap.outMarkers,
                      builder: (context, snapshotMarkers) {
                        print(snapshotMarkers.data);
                        if (snapshotPlaces.data.length > 0) {
                          return GoogleMap(
                            onMapCreated: _onMapCreated,
                            markers: Set<Marker>.of(
                                snapshotMarkers.data.length > 0
                                    ? snapshotMarkers.data.values
                                    : []),
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(snapshotPlaces.data[0].latitude,
                                  snapshotPlaces.data[0].longitude),
                              zoom: 13.0,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: StreamBuilder<List<Place>>(
                    initialData: [],
                    stream: blocMap.outPlaces,
                    builder: (context, snapshot) {
                      if (snapshot.data.length > 0) {
                        return CarrouselMap(
                          onItemChanged: (index, place) {
                            blocMap.inFocusPlace.add(place);
                            _onItemCarouselChange(place, index);
                          },
                          places: snapshot.data,
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 32.0, 8.0, 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 45.0,
                    height: 45.0,
                    child: FittedBox(
                      child: FloatingActionButton(
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Color(0xFF393A51),
                        child: Icon(
                          Icons.person_pin_circle,
                          size: 32.0,
                        ),
                        onPressed: _moveMapToUser,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getUserLocation() async {
    try {
      var location = new Location();
      location.getLocation().then((coords) {
        userCoords = LatLng(coords.latitude, coords.longitude);
        print(userCoords);
      });
    } catch (e) {
      print(e);
    }
  }
}
