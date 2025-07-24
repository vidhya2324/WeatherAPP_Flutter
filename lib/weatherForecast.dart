import 'package:flutter/material.dart';

//Weather Forescast
class WeatherForecast extends StatelessWidget {
  final String time;
  final IconData icon;
  final String degree;
  const WeatherForecast({
    super.key,
    required this.degree,
    required this.icon,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: 100,

      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

        child: Padding(
          padding: EdgeInsets.only(right:8.0, left:8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(alignment: Alignment.bottomLeft),
              SizedBox(width: 10, height: 10),
              Text(
                time,
                style: TextStyle(
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10),
              Icon(icon, size: 32),
              SizedBox(height: 10),
              Text(degree, style: TextStyle(fontSize: 17)),
            ],
          ),
        ),
      ),
    );
  }
}
