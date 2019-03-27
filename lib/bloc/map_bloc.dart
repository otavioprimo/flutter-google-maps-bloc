import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:google_maps/models/place.dart';
import 'package:google_maps/mocks/places_mock.dart';

class MapBloc implements BlocBase {
  Place focusedPlace;
  List<Place> places = PlacesMock.places;
  Map<MarkerId, Marker> markers = {};

  final StreamController _placesController =
      BehaviorSubject<List<Place>>(seedValue: []);

  final StreamController<Place> _placeFocusedController =
      StreamController<Place>();

  final StreamController<Map<MarkerId, Marker>> _markersController =
      StreamController<Map<MarkerId, Marker>>();

  Stream<List<Place>> get outPlaces => _placesController.stream;
  Stream<Place> get outPlaceFocused => _placeFocusedController.stream;
  Stream<Map<MarkerId, Marker>> get outMarkers => _markersController.stream;

  Sink get inFocusPlace => _placeFocusedController.sink;

  MapBloc() {
    _placesController.sink.add(places);
    _createMarkers();
    _markersController.sink.add(markers);
    _placeFocusedController.stream.listen(_focusPlace);
  }

  void _createMarkers() {
    places.forEach((el) {
      final MarkerId _markerId = MarkerId(el.id.toString());

      Marker _marker = Marker(
        markerId: _markerId,
        position: LatLng(el.latitude, el.longitude),
        infoWindow: InfoWindow(
          title: el.description,
          snippet: '${el.address}',
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      markers[_markerId] = _marker;
    });
  }

  void _focusPlace(Place place) {
    focusedPlace = place;
  }

  @override
  void dispose() {
    _placesController.close();
    _placeFocusedController.close();
    _markersController.close();
  }
}
