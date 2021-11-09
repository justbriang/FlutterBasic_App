import 'dart:ui';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbasic/core/bloc/user_bloc/user_bloc.dart';

import 'package:flutterbasic/core/models/user_prof.dart';
import 'package:flutterbasic/main.dart';
import 'package:flutterbasic/screens/info/form_validation.dart';
import 'package:flutterbasic/screens/info/widgets/show_message.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class InfoPage extends StatefulWidget {
 static const name = 'InfoPage';



  InfoPage({Key? key}) : super(key: key);

  @override
InfoPageState createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage> {
  Validation validation = Validation();
  UserBloc userBloc = UserBloc();
  double appBarElevation = 3;
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  bool loading = false;
  var countryCode = '+254';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => UserBloc(),
      child: BlocConsumer(
        listener: (context, state) {
          if (state is UserBlocLoaded && state.message != null) {
            //use the show message widget to display a snackbar indicating successful update of user data
            if (state.updated == true) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                showMessage(
                    context: context,
                    message: state.message!,
                    color: Colors.green);
                _btnController.success();
                Future.delayed(const Duration(milliseconds: 400), () {
                  Navigator.pushNamed(context, MyBottomNavBar.name,
                      arguments: (1));
                });
              });
            } else {
              //use the show message widget to display a snackbar indicating failed update of user data

              WidgetsBinding.instance!.addPostFrameCallback((_) {
                _btnController.reset();
                showMessage(
                    context: context,
                    message: state.message!,
                    color: Colors.red);
              });
            }
          }
        },
        bloc: userBloc,
        builder: (context, state) {
          if (state is UserBlocInitial) {
            userBloc.add(InitialUserEvent());
            return const CircularProgressIndicator();
          } else if (state is UserBlocLoaded) {
            if (state.user != null) {
              _initTextControllers(state.user!);
            }
            if (state.user!.countrycode != null) {
              countryCode = state.user!.countrycode!;
            }
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  title: Container(
                    decoration:
                        BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
                      BoxShadow(
                        color: Colors.grey[600]!,
                        blurRadius: 70.0,
                      ),
                    ]),
                    child: const Center(
                      child: Text(
                        "Edit User Info",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  expandedHeight: 340.0,
                  pinned: true,
                  iconTheme: const IconThemeData(color: Colors.white),
                  flexibleSpace: const FlexibleSpaceBar(
                      background: Image(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/prof.jpg'),
                  )),
                  actions: <Widget>[
                    Container(
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                          color: Colors.grey[600]!,
                          blurRadius: 70.0,
                        ),
                      ]),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                        tooltip: 'Add or change profile photo',
                        onPressed: () {
                          showMessage(
                              message: 'Not implemented, Yet!',
                              color: Colors.black,
                              context: context);
                        },
                      ),
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(
                              height: 30.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 40),
                              child: TextFormField(
                                // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))],
                                controller: usernameController,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.person),
                                  hintText: 'Enter Your Name',
                                  labelText: 'Name',
                                ),
                                validator: (value) =>
                                    validation.checker('Name', value),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 40),
                              child: TextFormField(
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))],
                                controller: emailController,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.email),
                                  hintText: 'Enter Your Email Address ',
                                  labelText: 'Email Address',
                                ),
                                validator: (value) =>
                                    validation.checker('Email', value),
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: CountryCodePicker(
                                    initialSelection:
                                        state.user!.countrycode ?? 'KE',
                                    alignLeft: true,
                                    favorite: ['US', 'KE'],
                                    onChanged: (code) {
                                      setState(() {
                                        countryCode = code.toString();
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))],
                                    controller: phonenumberController,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Your Phonenumber',
                                      labelText: 'Phonenumber',
                                    ),
                                    validator: (value) => validation.checker(
                                        'Phonenumber', value),
                                    keyboardType: TextInputType.phone,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 70.0,
                            ),
                            RoundedLoadingButton(
                              child: const Text('Save Details',
                                  style: TextStyle(color: Colors.white)),
                              controller: _btnController,
                              onPressed: () {
                                saveUserDetails();
                              },
                            ),
                            loading
                                ? const CircularProgressIndicator.adaptive()
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(
              child: Text(
                  'App run into an unexpected error please close and restart it'));
        },
      ),
    ));
  }

  void widgetsFinishedBuilding(Function callback) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      callback();
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    stateController.dispose();
    phonenumberController.dispose();

    super.dispose();
  }

  void saveUserDetails() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> userCredentials = {
        "name": usernameController.text.toString().trim(),
        "email": emailController.text.toString().trim(),
        'countrycode': countryCode,
        'phonenumber': phonenumberController.text.toString().trim(),
 
        'updated_at':DateFormat('EEE, MMM d, ''yy').format(DateTime.now()).toString()
      };
      userBloc.add(UpdateUserDetailsEvent(userDetails: userCredentials));
    } else {
      _btnController.reset();
    }
  }

  void _initTextControllers(User user) {
    usernameController.value = TextEditingValue(
      text: user.name ?? '',
      selection: TextSelection.fromPosition(
        TextPosition(offset: user.name!.length),
      ),
    );

    emailController.value = TextEditingValue(
      text: user.email ?? '',
      selection:
          TextSelection.fromPosition(TextPosition(offset: user.email!.length)),
    );

    phonenumberController.value = TextEditingValue(
      text: user.phonenumber ?? '',
      selection: TextSelection.fromPosition(
        TextPosition(
          offset: (user.phonenumber!.toString().length),
        ),
      ),
    );
  }
}
