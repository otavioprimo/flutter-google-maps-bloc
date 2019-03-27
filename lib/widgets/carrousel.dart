import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/models/place.dart';

class CarrouselMap extends StatelessWidget {
  final List<Place> places;
  final dynamic onItemChanged;

  CarrouselMap({this.places, this.onItemChanged});

  _onChange(int page) {
    onItemChanged(page, places[page]);
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      onPageChanged: _onChange,
      autoPlay: false,
      height: 100.0,
      items: places.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF626487),
                      Color(0xFF393A51),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: _buildCard(i));
          },
        );
      }).toList(),
    );
  }

  _buildCard(Place place) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(place.image),
            radius: 32.0,
          ),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  place.description,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  place.address,
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                  maxLines: 2,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  '${place.city} - ${place.state}',
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              )
            ],
          ),
        )),
      ],
    );
  }
}
