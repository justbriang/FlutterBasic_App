import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterbasic/core/models/user_prof.dart';

class UserDetailsPage extends StatefulWidget {
  final User user;
  static const name = 'UserDetailsPage';
 const UserDetailsPage({Key? key, required this.user}) : super(key: key);

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  void initState() {
    super.initState();
    _initTextControllers(widget.user);

  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Container(
              decoration: BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
                BoxShadow(
                  color: Colors.grey[600]!,
                  blurRadius: 70.0,
                ),
              ]),
              child: const Text(
                  " Account Details",
                  style: TextStyle(color: Colors.blue),
              
              ),
            ),
            expandedHeight: 340.0,
            pinned: true,
            iconTheme: const IconThemeData(color: Colors.blue),
            flexibleSpace: const FlexibleSpaceBar(
                background: Image(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/prof.jpg'),
            )),
            actions: <Widget>[
              Container(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                    color: Colors.grey[600]!,
                    blurRadius: 70.0,
                  ),
                ]),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 40),
                        child: TextFormField(
                          readOnly: true,
                          controller: usernameController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Enter Your Name',
                            labelText: 'Name',
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 40),
                        child: TextFormField(
                          readOnly: true,
                          controller: emailController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email),
                            hintText: 'Enter Your Email Address ',
                            labelText: 'Email Address',
                          ),
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
                              initialSelection: widget.user.countrycode??'KE',
                              alignLeft: true,
                              favorite: ['US', 'KE'],
                              onChanged: (code) {},
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              readOnly: true,
                              controller: phonenumberController,
                              decoration: const InputDecoration(
                                hintText: 'Enter Your Phonenumber',
                                labelText: 'Phonenumber',
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _initTextControllers(User user) {
    usernameController.value = TextEditingValue(
      text: user.name ?? 'Not set yet',
      selection: TextSelection.fromPosition(
        TextPosition(offset: user.name!.length),
      ),
    );

    emailController.value = TextEditingValue(
      text: user.email ?? 'Not set yet',
      selection:
          TextSelection.fromPosition(TextPosition(offset: user.email!.length)),
    );

    phonenumberController.value = TextEditingValue(
      text: user.phonenumber ?? 'Not set yet',
      selection: TextSelection.fromPosition(
        TextPosition(
          offset: (user.phonenumber!.toString().length),
        ),
      ),
    );
  }
}
