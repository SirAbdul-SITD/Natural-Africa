class ResourceModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final List<String> countries; // country ids
  final String uses;
  final List<String> exportDestinations;

  ResourceModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.countries,
    required this.uses,
    required this.exportDestinations,
  });

  factory ResourceModel.fromJson(Map<String, dynamic> j) => ResourceModel(
        id: j['id'] as String,
        name: j['name'] as String,
        category: j['category'] as String? ?? 'General',
        description: j['description'] as String? ?? '',
        countries: List<String>.from(j['countries'] ?? []),
        uses: j['uses'] as String? ?? '',
        exportDestinations: List<String>.from(j['exportDestinations'] ?? []),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'description': description,
        'countries': countries,
        'uses': uses,
        'exportDestinations': exportDestinations,
      };
}
