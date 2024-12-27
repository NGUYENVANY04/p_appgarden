import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:p_appgarden/data/datafirebase.dart';
import 'package:p_appgarden/widget/widget_ppm/infocardPpm.dart';

class InfoWidgetPpm extends StatelessWidget {
  const InfoWidgetPpm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataFirebase>(builder: (context, view, child) {
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                child: infoCardPpm(
                    colorInfo: Colors.white,
                    // context: context,
                    iconInfo: "assets/co2.jpg",
                    nameInfo: "C02 Concentration",
                    contentInfo: view.mq135Data.toString()),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                child: infoCardPpm(
                    colorInfo: Colors.white,
                    // context: context,
                    iconInfo: "assets/soi1.png",
                    nameInfo: "HP Concentration",
                    contentInfo: view.ph.toString()),
              )
            ],
          ),
        ),
      );
    });
  }
}
