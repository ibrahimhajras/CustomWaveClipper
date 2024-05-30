import 'package:flutter/material.dart';
import 'package:ring_app/config/constants.dart';
import 'package:ring_app/pages/wellness/fingerTempPage.dart';
import 'package:ring_app/pages/wellness/hrPage.dart';
import 'package:ring_app/pages/wellness/hrvPage.dart';
import 'package:ring_app/pages/wellness/spo2Page.dart';
import 'custom_wave_clipper.dart';  // Import the custom wave clippers

class WellnessPage extends StatefulWidget {
  const WellnessPage({super.key});

  @override
  State<WellnessPage> createState() => _WellnessPageState();
}

class _WellnessPageState extends State<WellnessPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size(80, 94),
          child: Stack(
            children: [
              ClipPath(
                clipper: (index == 0 || index == 1)
                    ? CustomWaveClipperRight()
                    : CustomWaveClipperLeft(),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  height: 150,
                  color: accentColor,
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 95,
                  ),
                  TabBar(
                    onTap: (value) {
                      setState(() {
                        index = _tabController.index;
                      });
                    },
                    controller: _tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    labelStyle: tabTextStyle,
                    dividerHeight: 0,
                    tabs: const [
                      Tab(
                        text: 'HR',
                      ),
                      Tab(
                        text: 'HRV',
                      ),
                      Tab(
                        text: 'SPO2',
                      ),
                      Tab(
                        text: 'Temp',
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        const HRPage(),
        const HRVPage(),
        const SPO2Page(),
        FingerTempPage(),
      ]),
    );
  }
}