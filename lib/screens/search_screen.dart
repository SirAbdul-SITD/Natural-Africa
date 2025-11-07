import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:natural_africa/services/data_service.dart';
import 'package:natural_africa/models/country.dart';
import 'package:natural_africa/models/resource.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  const SearchScreen({Key? key}): super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String q = '';
  @override
  Widget build(BuildContext context){
    final ds = Provider.of<DataService>(context);
    final results = q.isEmpty ? [] : ds.search(q);
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search countries or resources'),
            onChanged: (v)=>setState(()=>q=v),
          ),
        ),
        Expanded(
          child: results.isEmpty ? const Center(child: Text('No results')) : ListView.builder(
            itemCount: results.length,
            itemBuilder: (_, i){
              final item = results[i];
              if (item is Country) {
                return ListTile(title: Text(item.name), subtitle: Text('Country'), onTap: ()=>Navigator.pushNamed(context, '/country', arguments: item.id));
              } else if (item is ResourceModel) {
                return ListTile(title: Text(item.name), subtitle: Text('Resource'), onTap: ()=>Navigator.pushNamed(context, '/resource', arguments: item.id));
              } else return const SizedBox.shrink();
            },
          ),
        )
      ]),
    );
  }
}
