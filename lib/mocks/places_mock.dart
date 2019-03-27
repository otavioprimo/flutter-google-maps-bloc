import 'package:google_maps/models/place.dart';

class PlacesMock {
  static List<Place> places = <Place>[
    Place(
        id: 1,
        description: 'Lojas Americanas',
        state: 'SP',
        city: 'São Paulo',
        address: 'R. Silva Bueno 400',
        latitude: -23.5963531,
        longitude: -46.6019338,
        image:
            'https://image.isu.pub/140205201423-452dd45aa318dc4631b69596161f96f0/jpg/page_1.jpg'),
    Place(
        id: 2,
        description: 'Magazine Luiza',
        state: 'SP',
        city: 'São Paulo',
        address: 'R. Silva Bueno 380',
        latitude: -23.5993549,
        longitude: -46.6030992,
        image:
            'https://digitalks.com.br/wp-content/uploads/2018/12/magazine-luiza-logo-1.png')
  ];
}
