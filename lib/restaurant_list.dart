import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/restaurant_detail.dart';

class RestaurantList extends StatefulWidget {
  static const routeName = '/restaurant_list';

  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  List<Restaurant> restaurants = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String jsonString =
        await rootBundle.loadString('assets/local_restaurant.json');
    final jsonResponse = jsonDecode(jsonString);
    final List<dynamic> restaurantsJson = jsonResponse['restaurants'];
    setState(() {
      restaurants = restaurantsJson
          .map((json) => Restaurant.fromJson(json as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: restaurants.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return _buildRestaurantItem(context, restaurants[index]);
              },
            ),
    );
  }

  Card _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Image.network(
            restaurant.pictureId,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          restaurant.name,
          style: GoogleFonts.sora(textStyle: const TextStyle(fontSize: 14)),
        ),
        subtitle: Text(
          restaurant.city,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Container(
            width: 36,
            height: 25,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green[700],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 16,
                ),
                Text(
                  restaurant.rating.toString(),
                  style: const TextStyle(fontSize: 8, color: Colors.white),
                ),
              ],
            )),
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetail.routeName,
              arguments: restaurant);
        },
      ),
    );
  }
}
