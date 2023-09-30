import 'package:employee_time_managment/pages/landingPage.dart';
import 'package:employee_time_managment/pages/login.dart';
import 'package:employee_time_managment/statemanager/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import 'package:provider/provider.dart';

class cappbar extends StatelessWidget {
  const cappbar({super.key});

  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);

    return Container(
      height: 50,
      color: const Color.fromARGB(255, 32, 35, 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              // logo place
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Image(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2FyfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60'),
                    height: 35,
                    width: 35,
                  )),
              Text(
                "Zelle Solutions",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return new LoginPage();
                  }));
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Color.fromARGB(255, 0, 191, 239);
                    }
                    return const Color.fromARGB(255, 32, 35, 50);
                  }),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return const Color.fromARGB(255, 32, 35, 50);
                    }
                    return const Color.fromARGB(255, 207, 208, 215);
                  }),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 7),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Image.network(
                    'https://cdn-icons-png.flaticon.com/128/5337/5337129.png',
                    color: const Color.fromARGB(255, 255, 255, 255),
                    height: 20,
                    width: 20,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Image.network(
                    'https://cdn-icons-png.flaticon.com/128/3953/3953226.png',
                    color: const Color.fromARGB(255, 255, 255, 255),
                    height: 20,
                    width: 20,
                  )),
              Container(
                width: 50,
                child: PopupMenuButton(
                  icon: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://4.bp.blogspot.com/-Jx21kNqFSTU/UXemtqPhZCI/AAAAAAAAh74/BMGSzpU6F48/s1600/funny-cat-pictures-047-001.jpg"),
                    backgroundColor: Color.fromARGB(255, 253, 252, 252),
                  ),
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: '1',
                        child: Text('1'),
                      ),
                      const PopupMenuItem<String>(
                        value: '2',
                        child: Text('2'),
                      ),
                      const PopupMenuItem<String>(
                        value: '3',
                        child: Text('3'),
                      ),
                    ];
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
