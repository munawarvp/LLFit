import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:llfit_application/components/bottom_bar.dart';
import 'package:llfit_application/components/bottom_sheet.dart';
import 'package:llfit_application/components/info.dart';
import 'package:llfit_application/components/report.dart';
import 'package:llfit_application/models/shonawar.dart';
import 'package:llfit_application/services/user.dart';
import 'package:llfit_application/utils/config.dart';

class ProfileScreen extends StatefulWidget {
  final String token;
  final Map<String, dynamic> profile;
  final Map<String, dynamic> metrics;
  final List<Datum> metricsChart;

  const ProfileScreen(
      {super.key,
      required this.token,
      required this.profile,
      required this.metrics,
      required this.metricsChart});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 0;
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
              actions: [IconButton(onPressed: (){logoutUser(context);}, icon: const Icon(Icons.logout))],
            )),
        body: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 150,
                    child: CircleAvatar(
                      radius: 68,
                      child: CircleAvatar(
                        backgroundColor: Color.fromARGB(193, 157, 203, 226),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: NeumorphicToggle(
                       style: const NeumorphicToggleStyle(
                        backgroundColor: Colors.blue,
                        depth: 10
                        ),
                      selectedIndex: _selectedIndex,
                      thumb: Neumorphic(
                        style: NeumorphicStyle(
                          color: Colors.blue[100],
                          boxShape: NeumorphicBoxShape.roundRect(
                              const BorderRadius.all(Radius.circular(12))),
                        ),
                      ),
                      children: [
                        ToggleElement(
                          background: const Center(
                              child: Text(
                            "Reports",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, color: Colors.white),
                          )),
                          foreground: const Center(
                              child: Text(
                            "Reports",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, color: Colors.black),
                          )),
                        ),
                        ToggleElement(
                          background: const Center(
                              child: Text(
                            "Info",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, color: Colors.white),
                          )),
                          foreground: const Center(
                              child: Text(
                            "Info",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, color: Colors.black),
                          )),
                        )
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedIndex = value;
                        });
                      },
                    ),
                  ),
                  _selectedIndex == 0 ? Report(metrics: widget.metrics, metricsChart: widget.metricsChart) : InfoPage(profile: widget.profile),
                ],
              ),
            ),
        bottomNavigationBar: const BottomBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
            height: 50,
            width: 70,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: baseColor),
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
                child: const Icon(Icons.add, size: 25, color: Colors.white))));
  }
}
