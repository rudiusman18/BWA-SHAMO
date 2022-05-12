import 'package:bwa_shamo/models/user_model.dart';
import 'package:bwa_shamo/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:bwa_shamo/theme.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    TextEditingController nameController =
        TextEditingController(text: '${user.name}');

    TextEditingController usernameController =
        TextEditingController(text: '${user.username}');

    TextEditingController emailController =
        TextEditingController(text: '${user.email}');

    handleUpdateProfile() async {
      setState(() {
        isLoading = true;
      });
      if (await authProvider.updateProfile(
        name: nameController.text,
        username: usernameController.text,
        email: emailController.text,
        token: user.token.toString(),
      )) {
        Navigator.pop(context);
      }

      setState(() {
        isLoading = false;
      });
    }

    // header
    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        toolbarHeight: 78,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.only(
              left: 30,
            ),
            child: const Icon(Icons.clear),
          ),
        ),
        actions: [
          isLoading == false
              ? GestureDetector(
                  onTap: handleUpdateProfile,
                  child: Container(
                      margin: const EdgeInsets.only(
                        right: 30,
                      ),
                      child: Icon(
                        Icons.check,
                        color: primaryColor,
                      )),
                )
              : new Container(
                  margin: EdgeInsets.only(
                    right: 30,
                    top: 25,
                    bottom: 25,
                  ),
                  width: 14.0,
                  height: 14.0,
                  child: new CircularProgressIndicator(
                    color: primaryTextColor,
                    strokeWidth: 2,
                  ),
                ),
        ],
        automaticallyImplyLeading: false,
        title: Text(
          'Edit Profile',
          style: primaryTextStyle,
        ),
        centerTitle: true,
      );
    }

    // nameInput
    Widget nameInput() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: primaryTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: subtitleColor)),
              ),
              style: primaryTextStyle,
            ),
          ],
        ),
      );
    }

    // username
    Widget usernameInput() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
              style: primaryTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: subtitleColor)),
              ),
              style: primaryTextStyle,
            ),
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: primaryTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: subtitleColor)),
              ),
              style: primaryTextStyle,
            ),
          ],
        ),
      );
    }

// content
    Widget content() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // NOTE: PROFILE IMAGE
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(user.profilePhotoUrl.toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            nameInput(),
            usernameInput(),
            emailInput(),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      backgroundColor: backgroundColor3,
      body: ListView(
        children: [
          content(),
        ],
      ),
    );
  }
}
