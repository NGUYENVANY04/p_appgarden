import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:p_appgarden/data/datafirebase.dart';
import 'package:p_appgarden/widget/hiu_widget/infocardHiu.dart';

class InfoWidgetHiu extends StatelessWidget {
  const InfoWidgetHiu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataFirebase>(builder: (context, view, child) {
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                child: infoCardHiu(
                    colorInfo: Colors.white,
                    // context: context,
                    iconInfo: "assets/soi1.png",
                    nameInfo: "Soil Misture",
                    contentInfo: view.soil_misture.toString()),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                child: infoCardHiu(
                    colorInfo: Colors.white,
                    // context: context,
                    iconInfo: "assets/soi1.png",
                    nameInfo: "Humidity Indoor",
                    contentInfo: view.humidity_indoor.toString()),
              )
            ],
          ),
        ),
      );
    });
  }
}
