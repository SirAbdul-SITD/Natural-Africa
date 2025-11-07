import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:natural_africa/providers/favorites_provider.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    final fav = Provider.of<FavoritesProvider>(context, listen:false);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(padding: const EdgeInsets.all(12.0), children: [
        ListTile(title: const Text('Theme'), subtitle: const Text('System default (Material 3)')),
        ListTile(title: const Text('Clear favorites'), trailing: IconButton(icon: const Icon(Icons.delete_forever), onPressed: ()=>fav.clear())),
        const SizedBox(height:12),
        const Text('Privacy & Offline', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height:6),
        const Text('This app stores all data locally and does not transmit any user data.'),
      ]),
    );
  }
}
