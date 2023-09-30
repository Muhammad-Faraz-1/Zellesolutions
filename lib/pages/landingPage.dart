import 'package:employee_time_managment/statemanager/provider.dart';
import 'package:employee_time_managment/widgets/break_buttons.dart';
import 'package:employee_time_managment/widgets/cappbar.dart';
import 'package:employee_time_managment/widgets/clock.dart';
import 'package:employee_time_managment/widgets/left_panel.dart';
import 'package:employee_time_managment/widgets/shift_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context, listen: true);
    bool state2 = false;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 35, 50),
      body: Column(
        children: [
          cappbar(),
          Row(
            children: [
               Expanded(
                flex: 2,
                child: Container(
                  height:550.h ,
                  width: 500.w,
                  child:leftpanel()),
              ),
              Expanded(
                flex: 10,
                child: Stack(
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(height: 100.h, child: breakbuttons()),
                          Container(height: 350.h, child: const clock()),
                          Container(height: 100.h, child: ShiftButtons()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
