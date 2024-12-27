import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ControlDevice extends StatefulWidget {
  const ControlDevice({Key? key}) : super(key: key);

  @override
  State<ControlDevice> createState() => _ControlDeviceState();
}

class _ControlDeviceState extends State<ControlDevice> {
  bool stateLight = true;
  bool stateMotor = true;
  bool log = false;
  final refcontrol = FirebaseDatabase.instance.ref();

  void Log() {
    setState(() {
      log = !log;
    });
  }

  void controlLight() {
    setState(() {
      stateLight = !stateLight;
      refcontrol.child("state").update({
        "light": stateLight,
      });
    });
  }

  void controlMotor() {
    setState(() {
      stateMotor = !stateMotor;
      refcontrol.child("state").update({
        "motor": stateMotor,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return log
        ? Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Căn giữa theo trục dọc
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Căn giữa theo trục ngang
                children: [
                  Container(
                    height: 70,
                    width: 120,
                    decoration: BoxDecoration(
                      color: stateLight
                          ? const Color.fromARGB(255, 227, 117, 117)
                          : Colors.grey,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        controlLight();
                      },
                      child: Text(
                        stateLight ? "ON" : "OFF",
                        style: const TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 20, 14, 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30.0),
                  Container(
                    height: 70,
                    width: 120,
                    decoration: BoxDecoration(
                      color: stateMotor
                          ? const Color.fromARGB(255, 227, 117, 117)
                          : Colors.grey,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        controlMotor();
                      },
                      child: Text(
                        stateMotor ? "ON" : "OFF",
                        style: const TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 20, 14, 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Khoảng cách giữa hàng nút và icon
              IconButton(
                onPressed: () {
                  Log();
                },
                icon: const Icon(
                  Icons.arrow_drop_up,
                  size: 40,
                ),
              ),
            ],
          )
        : IconButton(
            onPressed: () {
              Log();
            },
            icon: const Icon(
              Icons.arrow_drop_down,
              size: 20,
            ),
          );
  }
}
