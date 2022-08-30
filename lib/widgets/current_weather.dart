
import 'package:flutter/material.dart';

Widget currentWeather(String temp,String city,String des,String country){
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        const SizedBox(height: 10,),
        Text('${temp}',
          style: const TextStyle(
              fontSize: 46
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${city}',
              style: const TextStyle(
                  fontSize: 20
              ),
            ),
            Text(' ${country}',
              style: const TextStyle(
                  fontSize: 20
              ),
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Text('${des}',
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF5a5a5a),
            )
        ),
        const SizedBox(height: 10,),

      ],
    ),
  );
}