import 'package:flutter/material.dart';

Expanded infoCardPpm({
  // required BuildContext context,
  required String nameInfo,
  required String contentInfo,
  required String iconInfo,
  required Color colorInfo,
}) {
  return Expanded(
    child: Container(
        padding: EdgeInsets.only(left: 20, top: 30),
        // width: MediaQuery.of(context).size.width*0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: colorInfo,
        ),
        // constraints: BoxConstraints.expand(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nameInfo,
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Image.asset(
                    iconInfo,
                    height: 30,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "$contentInfo Ppm",
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
        )),
  );
}
