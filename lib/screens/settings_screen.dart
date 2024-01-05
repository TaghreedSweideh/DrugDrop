import 'package:easy_localization/easy_localization.dart';
import '/translations/locale_keys.g.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/main.dart';
import '/providers/auth_provider.dart';
import '/screens/log_in_screen.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings-screen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

List<String> language = ['English', 'Arabic'];

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notification = false;
  bool _darkMode = false;
  String _language = language[0];
  void signout() async {
    await Provider.of<AuthProvider>(context, listen: false).logout();
  }

  void _showDialog(BuildContext context, String content, String text) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Center(
          child: Text(
            text,
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
        ),
        content: Text(content),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  signout();
                  Navigator.pushNamedAndRemoveUntil(context,
                      LogInScreen.routeName, (Route<dynamic> route) => false);
                },
                child: Text(LocaleKeys.yes.tr()),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(LocaleKeys.no.tr()),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(LocaleKeys.settings.tr()),
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              LocaleKeys.account_settings.tr(),
              style: TextStyle(
                fontSize: 16,
                color: theme.primary.withOpacity(0.6),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.person),
              trailing: Icon(Icons.chevron_right_rounded),
              iconColor: theme.primary,
              title: Text(
                LocaleKeys.edit_your_profile.tr(),
                style: TextStyle(color: theme.primary),
              ),
              onTap: () {
                //go to profile settings
              },
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              LocaleKeys.app_settings.tr(),
              style: TextStyle(
                fontSize: 16,
                color: theme.primary.withOpacity(0.6),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.language_rounded),
              trailing: Icon(Icons.chevron_right_rounded),
              iconColor: theme.primary,
              title: Text(
                LocaleKeys.language.tr(),
                style: TextStyle(color: theme.primary),
              ),
              subtitle: _language == language[0]
                  ? Text('English(US)')
                  : Text('العربية'),
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  constraints: BoxConstraints(maxHeight: media.height * 0.25),
                  context: context,
                  builder: (context) {
                    return Column(
                      children: <Widget>[
                        Card(
                          child: RadioListTile(
                            title: Text(
                              'English',
                              style: TextStyle(color: theme.primary),
                            ),
                            activeColor: theme.primary,
                            value: language[0],
                            groupValue: _language,
                            onChanged: (value) async {
                              await context.setLocale(Locale('en'));
                              setState(() {
                                _language = value.toString();
                              });
                            },
                          ),
                        ),
                        Card(
                          child: RadioListTile(
                            title: Text(
                              'العربية',
                              style: TextStyle(color: theme.primary),
                            ),
                            activeColor: theme.primary,
                            value: language[1],
                            groupValue: _language,
                            onChanged: (value) async {
                              await context.setLocale(Locale('ar'));
                              setState(() {
                                _language = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Card(
            child: SwitchListTile(
              value: _notification,
              onChanged: (value) {
                setState(() {
                  _notification = value;
                });
              },
              title: Text(
                LocaleKeys.notifications.tr(),
                style: TextStyle(color: theme.primary),
              ),
              subtitle: _notification
                  ? Text(LocaleKeys.on.tr())
                  : Text(LocaleKeys.off.tr()),
              secondary: Icon(
                _notification
                    ? Icons.notifications_active
                    : Icons.notifications_off,
                color: theme.primary,
              ),
            ),
          ),
          Card(
            child: SwitchListTile(
              value: _darkMode,
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
              },
              secondary: Icon(
                Icons.dark_mode_rounded,
                color: theme.primary,
              ),
              title: Text(
                LocaleKeys.dark_mode.tr(),
                style: TextStyle(color: theme.primary),
              ),
              subtitle: _darkMode
                  ? Text(LocaleKeys.on.tr())
                  : Text(LocaleKeys.off.tr()),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              LocaleKeys.contact_us.tr(),
              style: TextStyle(
                fontSize: 16,
                color: theme.primary.withOpacity(0.6),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.help_rounded),
              trailing: Icon(Icons.chevron_right_rounded),
              iconColor: theme.primary,
              title: Text(
                LocaleKeys.help.tr(),
                style: TextStyle(color: theme.primary),
              ),
            ),
          ),
          //SizedBox(height: media.height * 0.05),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              LocaleKeys.logging_out.tr(),
              style: TextStyle(
                fontSize: 16,
                color: theme.primary.withOpacity(0.6),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.logout_rounded),
              iconColor: theme.primary,
              title: Text(
                LocaleKeys.log_out.tr(),
                style: TextStyle(color: theme.primary),
              ),
              onTap: () {
                _showDialog(
                    context,
                    '${LocaleKeys.are_u_sure_from_logging.tr()}?',
                    LocaleKeys.sorry_to_hear.tr());
              },
            ),
          ),
        ],
      ),
    );
  }
}
