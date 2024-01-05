import '/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/widgets/profile_item.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context).colorScheme;
    return Column(
      children: [
        SizedBox(height: media.height * 0.04),
        CircleAvatar(
          radius: 70,
          backgroundImage: AssetImage('assets/images/Online Doctor-cuate.png'),
          backgroundColor: theme.background,
        ),
        SizedBox(height: media.height * 0.04),
        ProfileItem(LocaleKeys.name.tr(), 'Omar Hawary', Icons.person),
        SizedBox(height: media.height * 0.02),
        ProfileItem(LocaleKeys.phone_number.tr(), '0951738948', Icons.phone),
        SizedBox(height: media.height * 0.02),
        ProfileItem(LocaleKeys.address.tr(), 'Medan', Icons.location_pin),
        SizedBox(height: media.height * 0.02),
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 5),
                    color: Theme.of(context).colorScheme.background.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10)
              ]),
          child: ListTile(
            onTap: () => Navigator.of(context).pushNamed(SettingsScreen.routeName),
            title: Text(
              'Settings',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.primary,
            ),
            //trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
            tileColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        )
        // ProfileItem('Email', 'taghreedsweideh@gmail.com', Icons.mail),
        // SizedBox(height: media.height * 0.02),
        // ElevatedButton(
        //     onPressed: () {},
        //     style: ElevatedButton.styleFrom(
        //       padding: const EdgeInsets.all(10),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(20),
        //       ),
        //       backgroundColor: Theme.of(context).colorScheme.primary,
        //       foregroundColor: Colors.white,
        //     ),
        //     child: const Text('Edit Profile')),
      ],
    );
  }
}
