import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:llfit_application/components/bottom_bar.dart';
import 'package:llfit_application/components/bottom_sheet.dart';
import 'package:llfit_application/services/user.dart';
import 'package:llfit_application/utils/config.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfileScreen extends StatefulWidget {
  final String token;
  final Map<String, dynamic> profile;
  final Map<String, dynamic> metrics;

  const ProfileScreen(
      {super.key,
      required this.token,
      required this.profile,
      required this.metrics});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: AppBar(
              centerTitle: true,
              title: const Text("Profile"),
            )),
        body: Column(
          children: [
            SizedBox(
              height: 230,
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 150,
                    child: CircleAvatar(
                      radius: 68,
                      child: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        backgroundImage: NetworkImage(
                            "https://yoolk.ninja/wp-content/uploads/2022/04/OnePiece-Monkey-D-Luffy-1024x819.png'"),
                        radius: 100,
                      ),
                    ),
                  ),
                  Text(widget.profile['user']['username'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 27,
                          fontFamily: 'Courier New')),
                  Text(widget.profile['user']['email'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          fontFamily: 'Courier New'))
                ],
              ),
            ),
            SizedBox(
              height: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 10,
                    shadowColor: Colors.black,
                    color: primaryColor,
                    child: SizedBox(
                      width: 180,
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
                            Text('${widget.metrics['weight']}',
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
                            Text('${widget.metrics['height']}',
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
                            widget.metrics['bmi'] != null ?
                            Text('${widget.metrics['bmi']}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 45,
                                    fontWeight: FontWeight.w600)) :
                            IconButton(
                              icon: const Icon(Icons.refresh, color: Colors.white, size: 40),
                              onPressed: (){calculateMetrics(widget.metrics['id']);},
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: LinearPercentIndicator(
                    width: 345,
                    lineHeight: 25.0,
                    percent: (widget.metrics['weight'] - 47) / (57-47),
                    center: Text(
                      "${widget.metrics['weight']} kgs",
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
        bottomNavigationBar: const BottomBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
            height: 75,
            width: 100,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: buttonOne),
                onPressed: () {
                  showModalBottomSheet<void>(
                    showDragHandle: true,
                    context: context,
                    builder: (BuildContext context) {
                      return const SizedBox(
                          height: 450, child: CustomeBottomSheet());
                    },
                  );
                },
                child: const Icon(Icons.add))));
  }
}
