import 'package:flutter/material.dart';
import 'package:weather_app/modules/search/presenter/search/widgets/map_widget.dart';
import 'package:weather_app/modules/search/presenter/search/widgets/weather_info_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 12, 12),
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.ac_unit_sharp),
            SizedBox(width: 10),
            Text("WeatherApp"),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            opacity: 0.5,
            image: NetworkImage("https://wallpapercave.com/wp/wp2949175.jpg"),
          ),
        ),
        width: double.infinity,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MapWidget(),
            WeatherInfoWidget(),
          ],
        ),
      ),
    );
  }
}
