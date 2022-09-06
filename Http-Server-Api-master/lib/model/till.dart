class Till {
  final String id;
  final String name;
  final String tillid;

  Till({required this.id, required this.name, required this.tillid});

  Map toJson() => {
        'id': id,
        'name': name,
        'tillid': tillid,
      };
      
}
