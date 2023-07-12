import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/enum/appBarFuncEnum.dart';
import 'package:travel/model/user_model.dart';
import 'package:travel/provider/auth_provider.dart';
import 'package:travel/widget/custom_appbar.dart';
import 'package:travel/widget/custom_form_field.dart';
import 'package:travel/widget/custom_navigation.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditPage extends StatefulWidget {
  static const routerName = "/edit_profile";
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late Future<UserModel> futureUserModel;
  final firstNameController = TextEditingController();
  final picker = ImagePicker();
  String urlImage = "";
  File? galleryFile;

  @override
  void initState() {
    // TODO: implement initState
    futureUserModel = context.read<AuthProvider>().getUser();
    firstNameController.text = "Bach";
    super.initState();
  }

  void loadImage() async{
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      urlImage = image!.path;
    });
  }

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: CustomAppBar(funcType: AppBarFuncENum.OTHER),
      body: Padding(
        padding: EdgeInsets.all(paddingSizeWidth),
        child: Column(
          children: [
            Text("Personal Infomation"),
            const SizedBox(height: 20,),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  height: 150,
                ),
                Positioned(
                  child: SizedBox( 
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: urlImage.isNotEmpty ? Image.file(File(urlImage)) : Image.network("https://img.freepik.com/free-icon/user_318-563642.jpg?w=360"),
                    ),
                  )
                ),
                Positioned(
                  bottom: 15,
                  child: GestureDetector(
                    onTap: (){
                      _showPicker(context: context);
                    },
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: const  Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20), 
                        child: Center(
                          child: Row(
                            children: [
                              Icon(Icons.camera_alt, size: 16,),
                              SizedBox(width: 5,),
                              Text("Edit")
                            ],
                          ),
                        ),
                      ),
                    )
                  )
                ),
              ],
            ),
            const SizedBox(height: 20,),
            CustomFormField(
              controller: firstNameController, 
              fieldName: 'First Name', 
              isRequired: false, 
              obscureText: false, 
              textHint: 'Input First Name',

            ),
            CustomFormField(
              controller: firstNameController, 
              fieldName: 'Last Name', 
              isRequired: false, 
              obscureText: false, 
              textHint: 'Input Last Name',

            ),
            CustomFormField(
              controller: firstNameController, 
              fieldName: 'Address', 
              isRequired: false, 
              obscureText: false, 
              textHint: 'Input Address',

            ),
          ],
        )),
    );
  }
}
