import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:llfit_application/components/bottom_bar.dart';
import 'package:llfit_application/components/bottom_sheet.dart';
import 'package:llfit_application/components/info.dart';
import 'package:llfit_application/components/report.dart';
import 'package:llfit_application/models/shonawar.dart';
import 'package:llfit_application/services/user.dart';
import 'package:llfit_application/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String token = '';
  int _selectedIndex = 0;
  Map<String, dynamic>? profile;
  Map<String, dynamic>? metrics;
  List<Datum>? metricsChart = [];
  bool isLoading = true;
  bool _isLoggedIn = false;
  String? username;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
    _fetchProfileData();
  }

  Future<void> _checkIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('token');
    final loggedInUser = prefs.getString('username');

    if (storedToken == null || storedToken.isEmpty) {
      Navigator.pushReplacementNamed(context, '/login-screen');
    } else {
      setState(() {
        _isLoggedIn = true;
        token = storedToken;
        username = loggedInUser;
      });
      _fetchProfileData(); // Call fetchProfileData after setting the token
    }
  }

  Future<void> _fetchProfileData() async {
    try {
      final userProfile = await getUserProfile(token);
      final userMetrics = await getUserMetrics(token);

      setState(() {
        profile = userProfile;
        metrics = userMetrics;
        isLoading = false; // Mark loading as false after fetching data
      });
    } catch (e) {
      print("Error fetching profile data: $e");
    }
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(40.0),
              child: AppBar(
                centerTitle: true,
                title: const Text("Profile"),
                actions: [
                  IconButton(
                      onPressed: () {
                        logoutUser(context);
                      },
                      icon: const Icon(Icons.logout))
                ],
              )),
          body: _isLoggedIn
              ? SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 90,
                        child: CircleAvatar(
                          radius: 68,
                          child: CircleAvatar(
                            backgroundColor: Color.fromARGB(152, 206, 239, 255),
                            backgroundImage: NetworkImage(
                                "https://yoolk.ninja/wp-content/uploads/2022/04/OnePiece-Monkey-D-Luffy-1024x819.png'"),
                            radius: 100,
                          ),
                        ),
                      ),
                      Text(username ?? '',
                          style: const TextStyle(
                              // fontWeight: FontWeight.w900,
                              fontSize: 20,)),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: NeumorphicToggle(
                          // style: const NeumorphicToggleStyle(backgroundColor: Colors.blue, depth: 5),
                          selectedIndex: _selectedIndex,
                          thumb: Neumorphic(
                            style: NeumorphicStyle(
                              color: Colors.deepPurple[100],
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
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueGrey),
                              )),
                              foreground: const Center(
                                  child: Text(
                                "Reports",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              )),
                            ),
                            ToggleElement(
                              background: const Center(
                                  child: Text(
                                "Info",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueGrey),
                              )),
                              foreground: const Center(
                                  child: Text(
                                "Info",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
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
                      _selectedIndex == 0
                          ? Report(
                              metrics: metrics ?? {},
                              metricsChart: metricsChart ?? [])
                          : InfoPage(profile: profile ?? {}),
                    ],
                  ),
                ) : const Center(child: CircularProgressIndicator()),
          bottomNavigationBar: const BottomBar(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
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
                  child:
                      const Icon(Icons.add, size: 25, color: Colors.white))));
    }
  }
