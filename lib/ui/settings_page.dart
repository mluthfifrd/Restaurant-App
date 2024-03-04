import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/custom_widget/custom_dialog.dart';
import 'package:restaurant_app/provider/schedulling_provider.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Pengaturan';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(settingsTitle),
        ),
        body: ListView(
          children: [
            Material(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('Tema Gelap'),
                    trailing: Switch.adaptive(
                      value: false,
                      onChanged: (value) => customDialog(context),
                    ),
                  ),
                ],
              ),
            ),
            Material(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('Scheduling News'),
                    trailing: Consumer<SchedulingProvider>(
                      builder: (context, scheduled, _) {
                        return Switch.adaptive(
                          value: scheduled.isScheduled,
                          onChanged: (value) async {
                            scheduled.scheduledNews(value);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
