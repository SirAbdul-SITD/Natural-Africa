import 'package:flutter/material.dart';
import 'package:natural_africa/screens/resource_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:natural_africa/services/data_service.dart';
import 'package:natural_africa/widgets/resource_card.dart';

class ResourceListScreen extends StatelessWidget {
  static const routeName = '/resources';
  const ResourceListScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    final ds = Provider.of<DataService>(context);
    final resources = ds.allResources();
    return Scaffold(
      appBar: AppBar(title: const Text('Resources')),
      body: ListView.builder(
        itemCount: resources.length,
        itemBuilder: (_, i){
          final r = resources[i];
          return ResourceCard(resource: r, onTap: ()=>Navigator.pushNamed(context, ResourceDetailScreen.routeName, arguments: r.id));
        },
      ),
    );
  }
}
