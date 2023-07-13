import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/model/user_model.dart';
import 'package:travel/pages/profile/edit_profile_page.dart';
import 'package:travel/provider/auth_provider.dart';
import 'package:travel/widget/custom_navigation.dart';

class ProfilePage extends StatefulWidget {
  static const routerName = "/profile";
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<UserModel> futureUserModel;

  @override
  void initState() {
    // TODO: implement initState
    futureUserModel = context.read<AuthProvider>().getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      bottomNavigationBar: const CustomNavigationBar(
        currentRouteName: ProfilePage.routerName,
      ),
      body: Padding(
        padding: EdgeInsets.all(paddingSizeWidth),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsetsDirectional.symmetric(vertical: 20),
              child: Text(
                "Your Profile",
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: futureUserModel,
                builder: ((context, snapshot) {
                  UserModel user = snapshot.data!;
                  return Row(
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(user.image!, fit: BoxFit.cover,),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hello, ${user.firstName!} ${user.lastName!}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(user.address!,
                            style: const  TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      )
                    ],
                  );
                })),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfileEditPage()));
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: const Color.fromARGB(255, 180, 178, 178),
                        width: 0.5)),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(child: Text("Personal Infomation")),
                      SizedBox(
                        width: 20,
                        child: Icon(Icons.person),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color.fromARGB(255, 180, 178, 178),
                      width: 0.5)),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(child: Text("FAQ")),
                    SizedBox(
                      width: 20,
                      child: Icon(Icons.message),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Color.fromARGB(255, 180, 178, 178),
                      width: 0.5)),
              child: const  Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(child: Text("Logout")),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
