import 'package:flutter/material.dart';
import 'package:natural_africa/models/resource.dart';

class ResourceCard extends StatelessWidget {
  final ResourceModel resource;
  final VoidCallback? onTap;
  const ResourceCard({required this.resource, this.onTap, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical:6.0, horizontal: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        title: Text(resource.name, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(resource.category),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
