
import 'package:flutter/material.dart';

TextStyle titleFont = const TextStyle(fontWeight: FontWeight.w600, fontSize: 18);
TextStyle infoFont = const TextStyle(fontWeight: FontWeight.w400, fontSize: 18);

Widget additionalInformation(String main,String des){
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Main",
                  style: titleFont,
                  ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  "${main}",
                  style: infoFont,
                ),
              ],
            ),
            const Divider(thickness: 5,height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Humidity",
                  style: titleFont,
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  "${des}",
                  style: infoFont,
                ),
              ],
            ),
            const Divider(thickness: 5,height: 20,),

          ],
        ),
      ],
    ),
  );
}