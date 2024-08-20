import 'package:flutter/material.dart';
import 'package:llfit_application/services/user.dart';
import 'package:llfit_application/utils/config.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Report extends StatelessWidget {
  final Map<String, dynamic> metrics;
  const Report({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 465,
      child: SizedBox(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  color: primaryColor,
                  child: SizedBox(
                    width: 180,
                    height: 180,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text('Weight:',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Courier New')),
                          Text('${metrics['weight']}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.w600)),
                          const Text('Height:',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Courier New')),
                          Text('${metrics['height']}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  color: cardOne,
                  child: SizedBox(
                    width: 180,
                    height: 180,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text('BMI:',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Courier New')),
                          metrics['bmi'] != null
                              ? Text('${metrics['bmi']}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 45,
                                      fontWeight: FontWeight.w600))
                              : IconButton(
                                  icon: const Icon(Icons.refresh,
                                      color: Colors.white, size: 40),
                                  onPressed: () {
                                    calculateMetrics(metrics['id']);
                                  },
                                ),
                          const Text('Goal:',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Courier New')),
                          const Text('57',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                  ),
                ),
                // Card(
                //   elevation: 10,
                //   shadowColor: Colors.black,
                //   color: cardOne,
                //   child: SizedBox(
                //     width: 180,
                //     child: Padding(
                //       padding: const EdgeInsets.all(16.0),
                //       child: Column(
                //         children: [
                //           const Text('BMI:',
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 20,
                //                   fontWeight: FontWeight.w900,
                //                   fontFamily: 'Courier New')),
                //           metrics['bmi'] != null
                //               ? Text('${metrics['bmi']}',
                //                   style: const TextStyle(
                //                       color: Colors.white,
                //                       fontSize: 45,
                //                       fontWeight: FontWeight.w600))
                //               : IconButton(
                //                   icon: const Icon(Icons.refresh,
                //                       color: Colors.white, size: 40),
                //                   onPressed: () {
                //                     calculateMetrics(metrics['id']);
                //                   },
                //                 ),
                //           const Text('Goal:',
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 15,
                //                   fontWeight: FontWeight.w900,
                //                   fontFamily: 'Courier New')),
                //           const Text('57',
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 18,
                //                   fontWeight: FontWeight.w900)),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: LinearPercentIndicator(
                    width: 345,
                    lineHeight: 25.0,
                    percent: (metrics['weight'] - 47) / (57 - 47),
                    center: Text(
                      "${metrics['weight']} kgs",
                      style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    barRadius: const Radius.circular(16),
                    backgroundColor: Colors.grey,
                    progressColor: cardTwo,
                    trailing: const Text(
                      '57.0',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
