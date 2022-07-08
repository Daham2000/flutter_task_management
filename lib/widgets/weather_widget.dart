import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherWidget extends StatelessWidget {
  final String temperature;
  final String city;

  const WeatherWidget({Key? key, required this.temperature, required this.city})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${temperature}" + "°C",
                style: GoogleFonts.roboto(
                  fontSize: 25.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  city,
                  style: GoogleFonts.roboto(
                    fontSize: 17.0,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
