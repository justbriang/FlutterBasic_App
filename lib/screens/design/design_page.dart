import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbasic/core/bloc/user_bloc/user_bloc.dart';

import 'package:flutterbasic/core/models/app_icons.dart';
import 'package:flutterbasic/core/models/user_prof.dart';
import 'package:flutterbasic/main.dart';
import 'package:flutterbasic/screens/design/user_details.dart';
import 'package:flutterbasic/screens/design/utils/hex_color.dart';
import 'package:flutterbasic/screens/info/info_page.dart';
import 'package:flutterbasic/screens/info/widgets/show_message.dart';
import 'package:flutterbasic/utils.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

class DesignPage extends StatefulWidget {
  static const name = 'DesignPage';
  const DesignPage({Key? key}) : super(key: key);

  @override
  _DesignPageState createState() => _DesignPageState();
}

class _DesignPageState extends State<DesignPage> {
  UserBloc _userBloc = UserBloc();
  List<AppIcons> choices = [
    AppIcons(
        icon: Icons.admin_panel_settings_outlined,
        semanticLabel: 'App Settings'),
  ];

  Completer<void>? _completer = new Completer();
  final GlobalKey<RefreshIndicatorState> _refreshIndicator = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserBloc(),
        child: BlocConsumer(
            bloc: _userBloc,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is UserBlocInitial) {
                _shimmerProfileLoading(context);
                Future.delayed(const Duration(milliseconds: 1000), () {
                  _userBloc.add(InitialUserEvent());
                });
              } else if (state is UserBlocLoaded) {
                _completer!.complete();
                _completer = Completer();
                return Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      centerTitle: true,
                      leading: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                          size: 24.0,
                          semanticLabel: 'Edit Profile',
                        ),
                        onPressed: () {
                          //open the info page while, ensuring persistance of the bottom navbar
                          Navigator.pushNamed(context, MyBottomNavBar.name,
                              arguments: (0));
                        },
                      ),
                      backgroundColor: Colors.white,
                      elevation: 4,
                      title: const Text(
                        'Profile',
                        style: TextStyle(color: Colors.blue),
                      ),
                      actions: choices.map<Widget>((iconDetail) {
                        return IconButton(
                          onPressed: () {
                            showMessage(
                                message: 'Not implemented, Yet!',
                                color: Colors.black,
                                context: context);
                          },
                          icon: Icon(
                            iconDetail.icon,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                    body: SafeArea(
                        child: RefreshIndicator(
                            key: _refreshIndicator,
                            onRefresh: () {
                              _userBloc.add(InitialUserEvent());
                              return _completer!.future;
                            },
                            child: SingleChildScrollView(
                                physics: new BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                child:
                                    _mainProfileContainer(context, state)))));
              }
              return _shimmerProfileLoading(context);
            }));
  }
}

Widget _profileHeader(BuildContext context, UserBlocLoaded state) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.5,
    child: Stack(
      children: <Widget>[
        Container(
            transform: Matrix4.translationValues(0, 0, -10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage('assets/images/prof.jpg'),
                    fit: BoxFit.cover)),
            child: Stack(
              children: <Widget>[
                _addBlur(context, 3, 3),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    transform: Matrix4.translationValues(0, 5, 0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5 * 0.6,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        colors: [
                          new HexColor('#E6E9E4F0'),
                          new HexColor('#FFFFFF')
                          // #FFFFFF
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(0),
                        width: 130,
                        height: 130,
                        transform: Matrix4.translationValues(0, -30, 0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: new Offset(0, 0),
                                blurRadius: 10)
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/prof.jpg'),
                          ),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(7, -10, 0),
                        child: Text(
                          state.user?.name ?? 'Not known',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                      const Text(
                        "Location Not Known",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ],
    ),
  );
}

Widget _profileBody(context, UserBlocLoaded state) {
  return Column(
    children: [
      const Divider(),
      SizedBox(
        height: 80.0,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                if (state.user != null) {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(seconds: 2),
                          transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secAnimation,
                              Widget child) {
                            animation = CurvedAnimation(
                                parent: animation, curve: Curves.elasticInOut);

                            return ScaleTransition(
                              alignment: Alignment.center,
                              scale: animation,
                              child: child,
                            );
                          },
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secAnimation) {
                            return UserDetailsPage(
                              user: state.user!,
                            );
                          }));
                } else {
                  showMessage(
                      message:
                          'Profile details not set yet.Please set your details inorder to continue',
                      color: Colors.red,
                      context: context);
                }
                // MaterialPageRoute(
                //     builder: (_) => UserDetailsPage(
                //         user: state.user!,
                //         )));
              },
              child: const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Account'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
                subtitle: Text('View your Account settings from here'),
              ),
            ),
          ],
        ),
      ),
      const Divider(),
      SizedBox(
        height: 80.0,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showMessage(
                    message: 'Not implemented, Yet!',
                    color: Colors.black,
                    context: context);
              },
              child: const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
                subtitle: Text('Modify your app preferences from here'),
              ),
            ),
          ],
        ),
      ),
      const Divider(),
      SizedBox(
        height: 80.0,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showMessage(
                    message: 'Not implemented, Yet!',
                    color: Colors.black,
                    context: context);
              },
              child: const ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
                subtitle: Text('Logout of your account'),
              ),
            ),
          ],
        ),
      ),
      Divider(),
    ],
  );
}

Widget _addBlur(BuildContext context, double x, double y) => BackdropFilter(
      filter: ImageFilter.blur(sigmaY: y, sigmaX: x),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          color: Colors.white.withOpacity(0)),
    );

Widget _shimmerProfileLoading(BuildContext context) => Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(250),
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: const BoxDecoration(color: Colors.red),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Container(
                            width: 150,
                            height: 15,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                          child: Container(
                            width: 150,
                            height: 15,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(
                child: Text(
                  'Loading your profile...',
                  style: TextStyle(fontSize: 19),
                ),
              ),
            )
          ],
        ),
      ),
    );
Widget _mainProfileContainer(BuildContext context, UserBlocLoaded state) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _profileHeader(context, state),
        Container(
          transform: Matrix4.translationValues(0, -110, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(18),
                      child: Text.rich(TextSpan(
                          text: 'Profile Completion: ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: "50%",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 16,
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.w600,
                                ))
                          ])),
                    ),
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            return;
                          },
                          padding: const EdgeInsets.only(right: 15),
                          icon: const Icon(
                            Icons.info_outline,
                            color: Colors.lightBlue,
                            size: 24.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                        )),
                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18, top: 5),
                  child: LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width * 0.9,
                    lineHeight: 10.0,
                    animation: true,
                    animationDuration: 2000,
                    percent: 50 / 100.toDouble(),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    backgroundColor: Colors.blue[100],
                    progressColor: Colors.blue,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Joined on ${state.user?.updated_on ?? DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now()).toString()}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              _profileBody(context, state),
            ],
          ),
        ),
      ],
    );
