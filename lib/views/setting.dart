
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'adminpanal.dart';
import 'components/modified_text.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  void auth() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: ModifiedText(data: "Login"),
          content: Container(
            height: 150,
            width: 300,
            child: Column(
              children: [
                TextField(
                  controller: username,
                  decoration: InputDecoration(
                    labelText: "Username",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (username.text == "sathish" && password.text == "1234") {
                  Get.to(Adminpanal());
                  Navigator.pop(context);
                } else {
                  print("Authentication failed");
                }
              },
              child: ModifiedText(data: "Log in"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Hero(
                    tag: "profile",
                    child: Icon(
                      Icons.person,
                      size: 100,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: ModifiedText(data: "Admin panel"),
                trailing: IconButton(
                  onPressed: () {
                    Get.to(Adminpanal());
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
