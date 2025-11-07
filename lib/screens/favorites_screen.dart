import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:natural_africa/providers/favorites_provider.dart';
import 'package:natural_africa/services/data_service.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = '/favorites';
  const FavoritesScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    final fav = Provider.of<FavoritesProvider>(context);
    final ds = Provider.of<DataService>(context, listen: false);
    final ids = fav.all;
    final items = ids.map((id){
      final c = ds.countryById(id);
      if (c!=null) return {'type':'country','id':c.id,'title':c.name};
      final r = ds.resourceById(id);
      if (r!=null) return {'type':'resource','id':r.id,'title':r.name};
      return null;
    }).whereType<Map<String,String>>().toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites'), actions: [
        IconButton(onPressed: ()=>fav.clear(), icon: const Icon(Icons.delete))
      ]),
      body: items.isEmpty ? const Center(child: Text('No favorites yet')) : ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, i){
          final it = items[i];
          return ListTile(
            title: Text(it['title']!),
            subtitle: Text(it['type']!),
            onTap: ()=>Navigator.pushNamed(context, it['type']=='country'? '/country' : '/resource', arguments: it['id']),
          );
        },
      ),
    );
  }
}
