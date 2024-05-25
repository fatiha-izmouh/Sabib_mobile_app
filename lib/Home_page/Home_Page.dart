import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sabib_feecra/login_signup/Screens/login/login.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../components/water_quality.dart';
import '../models/notch_bottom_bar_controller.dart';
import 'accordion/accordion.dart';
import 'accordion/accordion_section.dart';
import '../Info_home/LocationTypeScreen.dart';

class Page1 extends StatefulWidget {
  final NotchBottomBarController? controller;

  const Page1({Key? key, this.controller}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> with TickerProviderStateMixin {
  late AnimationController _mainScreenAnimationController;
  late Animation<double> _mainScreenAnimation;
  static const headerStyle = TextStyle(
    color: Color(0xffffffff),
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const contentStyleHeader = TextStyle(
    color: Color(0xff999999),
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
  static const contentStyle = TextStyle(
    color: Color(0xff999999),
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
  static const slogan =
      'Do not forget to play around with all sorts of colors, backgrounds, borders, etc.';
  final navigatorKey = GlobalKey<NavigatorState>();

  String selectedhome = "";

  List<String> homes = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _mainScreenAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _mainScreenAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainScreenAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _mainScreenAnimationController.forward();

    _fetchUserHomes();
  }

  Future<void> _fetchUserHomes() async {
    setState(() {
      _isLoading = true;
    });

    String userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('locations')
          .where('userId', isEqualTo: userId)
          .get();

      List<String> userHomes = snapshot.docs
          .map((doc) => doc['address'].toString())
          .toList(); // Fetching addresses

      setState(() {
        homes = userHomes;
        _isLoading = false;
      });
    } catch (error) {
      print('Error fetching user homes: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildConditionalWidget();
  }

  Widget buildConditionalWidget() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (homes.isNotEmpty) {
      return buildHomeWidget();
    } else {
      return buildAddDeviceWidget();
    }
  }

  Widget buildHomeWidget() {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          widget.controller?.jumpTo(2);
        },
        child: Container(
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Accordion(
                  headerBorderColor: Colors.blueGrey,
                  headerBorderColorOpened: Colors.transparent,
                  headerBackgroundColorOpened: Colors.green,
                  contentBackgroundColor: Colors.white,
                  contentBorderColor: Colors.green,
                  contentBorderWidth: 3,
                  contentHorizontalPadding: 20,
                  scaleWhenAnimating: true,
                  openAndCloseAnimation: true,
                  headerPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  children: [
                    AccordionSection(
                      index: 0, // Adjust this value accordingly
                      isOpen: false,
                      leftIcon:
                          const Icon(Icons.home_filled, color: Colors.white),
                      headerBackgroundColor: Colors.blueGrey,
                      headerBackgroundColorOpened: Colors.blue,
                      headerBorderWidth: 1,
                      contentBackgroundColor: Colors.blue,
                      contentBorderWidth: 0,
                      contentVerticalPadding: 30,
                      header: const Text('your houses', style: headerStyle),
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (String home in homes)
                            RadioListTile(
                              title: Text(home, style: headerStyle),
                              value: home,
                              groupValue: selectedhome,
                              onChanged: (value) {
                                setState(() {
                                  selectedhome = value.toString();
                                });
                              },
                            ),
                          SizedBox(height: 20),
                          Text(
                            "Selected House: $selectedhome",
                            style: headerStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                WaterView(
                  mainScreenAnimationController: _mainScreenAnimationController,
                  mainScreenAnimation: _mainScreenAnimation,
                ),

                Container(
                  padding: const EdgeInsets.only(left: 35, top: 10, right: 35),
                ),
                Card(
                  color: Colors.white38,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: Column(
                    children: [
                      Text('votre consommation du mois',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 20)),
                      SfCartesianChart(
                        primaryYAxis: NumericAxis(
                          title: AxisTitle(text: "debut"),
                        ),
                        legend: Legend(isVisible: true),
                        tooltipBehavior: TooltipBehavior(
                            enable: true,
                            activationMode: ActivationMode.singleTap),
                        primaryXAxis: CategoryAxis(
                          title: AxisTitle(text: "mois"),
                        ),
                        series: <CartesianSeries>[
                          ColumnSeries<chartdata, String>(
                            dataSource: getColumnData(),
                            name: "Cacher",
                            legendIconType: LegendIconType.seriesType,
                            xValueMapper: (chartdata data, _) => data.x,
                            yValueMapper: (chartdata data, _) => data.y,
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Colors.white38,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: SfCircularChart(
                    tooltipBehavior: TooltipBehavior(
                      enable: true,
                    ),
                    legend: Legend(isVisible: true),
                    //  series: <CircularSeries>[
                    // PieSeries<chartdata, String>(
                    series: <DoughnutSeries>[
                      DoughnutSeries<chartdata, String>(
                        dataSource: getColumnData(),
                        xValueMapper: (chartdata data, _) => data.x,
                        yValueMapper: (chartdata data, _) => data.y,
                        dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.outside,
                            labelAlignment: ChartDataLabelAlignment.middle),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('Press Me'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAddDeviceWidget() {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.9,
        heightFactor: 0.8,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 21),
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 50),
          decoration: BoxDecoration(
            color: Colors.lightBlue[100],
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.home,
                  size: 100,
                  color: Colors.blue,
                ),
                SizedBox(height: 24),
                Text(
                  "Add Device",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocationTypeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: CircleBorder(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 5)
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<chartdata> getColumnData() {
    List<chartdata> columndata = [
      chartdata("janvier", 20),
      chartdata("février", 27),
      chartdata("mars", 20),
      chartdata("avril", 18),
    ];
    return columndata;
  }
}

class chartdata {
  late String x;
  late double y;
  chartdata(this.x, this.y);
}
