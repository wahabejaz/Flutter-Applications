import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Welcome back",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 3, 117, 79),
          titleTextStyle: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 20),
          iconTheme: IconThemeData(color: const Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  //controller variables
  var dateController = TextEditingController();
  var userController = TextEditingController();
  var passController = TextEditingController();
  var timeController = TextEditingController();
  //error variables
  String? userError;
  String? passError;
  String? dateError;
  String? timeError;
  bool _obsecurePassword = true;
  bool isPasswordNotEmpty = false;

  //validation button
  void validateInput() {
    setState(() {
      // Reset errors first
      userError = null;
      passError = null;
      dateError = null;
      timeError = null;

      if (userController.text.isEmpty) {
        userError = "Please enter username!";
      } else if (passController.text.isEmpty) {
        passError = "Please enter password!";
      } else if (dateController.text.isEmpty) {
        dateError = "Please enter date!";
      } else if (timeController.text.isEmpty) {
        timeError = "Please enter time!";
      } else if (userError == null &&
          passError == null &&
          dateError == null &&
          timeError == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Login successfully!")));
      }
    });
  }

  //password visibility icon
  @override
  void initState() {
    super.initState();
    passController.addListener(() {
      setState(() {
        isPasswordNotEmpty = passController.text.isNotEmpty;
      });
    });
  }

  //dispose for memory leak
  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User credentials"),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //username
                Container(
                  width: 250,
                  child: TextField(
                    controller: userController,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          userError = "Username can't be empty!";
                        } else {
                          userError = null;
                        }
                      });
                    },
                    onSubmitted: (value) {
                      FocusScope.of(context).nextFocus();
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 6, 68, 126),
                              width: 2)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 3, 117, 79),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      labelText: "Enter username",
                      errorText: userError,
                      floatingLabelStyle: TextStyle(
                          color: Color.fromARGB(255, 6, 68, 126)),
                    ),
                  ),
                ),

                SizedBox(height: 12), 

                //Password text field
                Container(
                  width: 250,
                  child: TextField(
                    controller: passController,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          passError = "Password can't be empty!";
                        } else if (value.length > 8 || value.length < 8) {
                          passError = "Password must be of 8 characters!";
                        } else {
                          passError = null;
                        }
                      });
                    },
                    onSubmitted: (value) {
                      FocusScope.of(context).nextFocus();
                    },
                    obscureText: _obsecurePassword,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 6, 68, 126),
                              width: 2)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 3, 117, 79),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      labelText: "Password",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                      suffix: isPasswordNotEmpty
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _obsecurePassword = !_obsecurePassword;
                                });
                              },
                              icon: Icon(
                                _obsecurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 20,
                              ),
                            )
                          : null,
                      errorText: passError,
                      floatingLabelStyle: TextStyle(
                          color: Color.fromARGB(255, 6, 68, 126)),
                    ),
                  ),
                ),

                SizedBox(height: 12), 

                //Date
                Container(
                  width: 250,
                  height: 60,
                  child: TextField(
                    readOnly: true,
                    controller: dateController,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          dateError = "Date can't be empty!";
                        }
                      });
                    },
                    onSubmitted: (value) {
                      FocusScope.of(context).nextFocus();
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 6, 68, 126),
                              width: 2)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 3, 117, 79),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      labelText: "Date",
                      errorText: dateError,
                      floatingLabelStyle: TextStyle(
                          color: Color.fromARGB(255, 6, 68, 126)),
                      hintText: "dd/mm/yyyy",
                      suffix: IconButton(
                        icon: Icon(Icons.calendar_month),
                        onPressed: () async {
                          DateTime? datePicked = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2001),
                            initialDate: DateTime.now(),
                            lastDate: DateTime(2026),
                          );
                          if (datePicked != null) {
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(datePicked);
                            dateController.text =
                                formattedDate; // update text field
                          }
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 12), 

                //time
                Container(
                  width: 250,
                  height: 60,
                  child: TextField(
                    readOnly: true,
                    controller: timeController,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          timeError = "Time can't be empty!";
                        }
                      });
                    },
                    onSubmitted: (value) {
                      FocusScope.of(context).nextFocus();
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 6, 68, 126),
                              width: 2)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 3, 117, 79),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      labelText: "Time",
                      errorText: timeError,
                      floatingLabelStyle: TextStyle(
                          color: Color.fromARGB(255, 6, 68, 126)),
                      hintText: "hh:mm:ss",
                      suffix: IconButton(
                        icon: Icon(Icons.timelapse),
                        onPressed: () async {
                          TimeOfDay? timePicked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            initialEntryMode: TimePickerEntryMode.input,
                          );
                          if (timePicked != null) {
                            final formattedTime = timePicked.format(context);
                            timeController.text = formattedTime;
                          }
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20), 

                //login button
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      backgroundColor: Color.fromARGB(255, 3, 117, 79),
                    ),
                    onPressed: () {
                      validateInput();
                      String username = userController.text;
                      String Password = passController.text;
                      String Date = dateController.text;
                      String time = timeController.text;
                      print(
                          "Username: $username, Password: $Password, Date: $Date, Time: $time");
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ))
              ]),
        ));
  }
}
