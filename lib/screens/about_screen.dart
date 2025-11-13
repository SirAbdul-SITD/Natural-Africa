import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/about';
  const AboutScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(children: const [
          Text('Natural Africa', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          SizedBox(height:10),
          Text('Version: 1.0.0'),
          SizedBox(height:8),
          Text('Mission: Empower knowledge about Africa\'s natural resources. This app works fully offline and provides curated, factual descriptions of natural resources found across African countries.'),
          SizedBox(height:12),
          Text('Credits:', style: TextStyle(fontWeight: FontWeight.w600)),
          Text('• Data curated by OBAINO COMMUNICATIONS AND GENERAL MERCHANDISE'),
          SizedBox(height:12),
          Text('Contact: dev@obaino-cagm.name.ng'),
        ]),
      ),
    );
  }
}
