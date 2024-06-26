import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantDetail extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetail({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
                tag: restaurant.pictureId,
                child: Image.network(restaurant.pictureId)),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        restaurant.name,
                        style: GoogleFonts.sora(
                            textStyle: const TextStyle(fontSize: 18)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 16),
                        width: 46,
                        padding: const EdgeInsets.all(2),
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
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.green[700],
                        size: 16,
                      ),
                      Text(
                        restaurant.city,
                        style: GoogleFonts.sora(
                            textStyle: const TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    restaurant.description,
                    style: const TextStyle(fontSize: 14, letterSpacing: 0.5),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Foods :',
                    style: TextStyle(fontSize: 16),
                  ),
                  _scrollBoxFoods(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Drinks :',
                    style: TextStyle(fontSize: 16),
                  ),
                  _scrollBoxDrinks(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _scrollBoxDrinks() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: restaurant.menus.drinks.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(8),
              width: 160,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.green[700],
              ),
              child: Text(
                textAlign: TextAlign.center,
                restaurant.menus.drinks[index].name,
                style: TextStyle(color: Colors.white),
              ),
            );
          }),
    );
  }

  SizedBox _scrollBoxFoods() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: restaurant.menus.foods.length,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(8),
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.green[700],
              ),
              child: Text(
                textAlign: TextAlign.center,
                restaurant.menus.foods[index].name,
                style: TextStyle(color: Colors.white),
              ),
            );
          }),
    );
  }
}
