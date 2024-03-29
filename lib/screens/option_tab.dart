import 'package:events/Services/event_services.dart';
import 'package:events/constants/theme.dart';
import 'package:events/provider/userProvider.dart';
import 'package:events/screens/home_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:events/constants/colors.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../models/navigation_item.dart';
import '../provider/navigationProvider.dart';
import '../widgets/drawer.dart';
import 'authentication/signin_screen.dart';
import 'event/ongoing_screen.dart';
import 'event/pastevent_screen.dart';
import 'event/upcoming_event.dart';

class OptionTab extends StatefulWidget {
  const OptionTab({Key? key}) : super(key: key);


  @override
  State<OptionTab> createState() => _OptionTabState();
}

class _OptionTabState extends State<OptionTab> {
  List ongoing = [], upcoming = [], past = [];
  bool isLoading = true;
  String type='user';
  late NavigationItem item;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    EventServices().getEvents(
        context: context,
        onFetch: (data) {
          setState(() {
            print(data);
            ongoing = data['events']['ongoing'];
            upcoming = data['events']['upcoming'];
            past = data['events']['completed'];
            isLoading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.colors.lightestShade,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 25, spreadRadius: 10, color: Colors.black54)
                    ]),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.colors.midShade,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      height: 80,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () => Scaffold.of(context).openDrawer(),
                                icon: Icon(
                                  Icons.menu,
                                  color: AppColors.colors.white,
                                )),
                            Text(
                              'Evento',
                              style: appTheme().textTheme.headline2?.copyWith(color: AppColors.colors.white,fontSize: 20),
                            ),
                            SizedBox(
                              width: 50,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TabBar(
                      tabs: [
                        Tab(
                          child: Text(
                            "Ongoing",
                            style:
                            appTheme().textTheme.headline3?.copyWith(color: AppColors().brown,fontSize: 15),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Upcoming",
                            style:
                            appTheme().textTheme.headline3?.copyWith(color: AppColors().brown,fontSize: 15),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Past",
                            style:
                            appTheme().textTheme.headline3?.copyWith(color: AppColors().brown,fontSize: 15),
                          ),
                        ),
                      ],
                      indicatorColor: AppColors.colors.midShade,
                      indicatorWeight: 3,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                    children: isLoading
                        ? [
                            Center(
                              child: CircularProgressIndicator(
                                value: 20,
                              ),
                            ),
                            SizedBox(),
                            SizedBox(),
                          ]
                        : [
                            OngoingScreen(
                              ongoing: ongoing,
                            ),
                            UpcomingEventScreen(
                              upcoming: upcoming,
                            ),
                            PastEventScreen(
                              past: past,
                            )
                          ]),
              )
            ],
          )),
    );
  }
}
