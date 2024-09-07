import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:llfit_application/services/user.dart';
import 'package:llfit_application/utils/config.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Report extends StatefulWidget {
  final Map<String, dynamic> metrics;
  Report({super.key, required this.metrics});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  late ZoomPanBehavior _zoomPanBehavior;
  late TrackballBehavior _trackballBehavior;


  final int year = DateTime.now().year;
  final List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
    'All'
  ];
  late DateTime selectedItem;
  final List<DateTime> months =
      List<DateTime>.generate(12, (int index) => DateTime(2024, index + 1, 1));

  final List<SalesData> chartData = [
    SalesData(DateTime(2010), 52.4),
    SalesData(DateTime(2011), 52.4),
    SalesData(DateTime(2012), 52.4),
    SalesData(DateTime(2013), 53.4),
    SalesData(DateTime(2014), 53.6),
  ];

  @override
  void initState() {
    selectedItem = DateTime(2024);
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      zoomMode: ZoomMode.xy,
    );
    _trackballBehavior = TrackballBehavior(
        enable: true,
        markerSettings: TrackballMarkerSettings(
            markerVisibility: TrackballVisibilityMode.visible));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 465,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
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
                  height: 160,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
                  height: 160,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const Text('BMI:',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Courier New')),
                        widget.metrics['bmi'] != null
                            ? Text('${widget.metrics['bmi']}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 45,
                                    fontWeight: FontWeight.w600))
                            : IconButton(
                                icon: const Icon(Icons.refresh,
                                    color: Colors.white, size: 40),
                                onPressed: () {
                                  calculateMetrics(widget.metrics['id']);
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
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: LinearPercentIndicator(
                  width: 345,
                  lineHeight: 25.0,
                  percent: (widget.metrics['weight'] - 47) / (57 - 47),
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
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text('Montly Report'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.5,
                  child: DropdownButton<DateTime>(
                    value: selectedItem,
                    menuMaxHeight: 150,
                    items: months.map<DropdownMenuItem<DateTime>>((DateTime value) {
                      return DropdownMenuItem<DateTime>(
                        value: value,
                        child: Text('${monthNames[value.month - 1]} ${value.year}'),
                      );
                    }).toList(),
                    onChanged: (DateTime? newValue) {
                      // Handle the change here
                      print("${newValue} --- new selected value");
                      setState(() {
                        selectedItem = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(width: 100)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
                height: 300,
                child: SfCartesianChart(
                    zoomPanBehavior: _zoomPanBehavior,
                    primaryXAxis: const DateTimeAxis(),
                    trackballBehavior: _trackballBehavior,
                    series: <CartesianSeries>[
                      // Renders line chart
                      LineSeries<SalesData, DateTime>(
                          dataSource: chartData,
                          color: Colors.red,
                          width: 4,
                          markerSettings: const MarkerSettings(isVisible: true),
                          xValueMapper: (SalesData sales, _) => sales.date,
                          yValueMapper: (SalesData sales, _) => sales.weight),
                    ])),
          )
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.date, this.weight);
  final DateTime date;
  final double weight;
}
