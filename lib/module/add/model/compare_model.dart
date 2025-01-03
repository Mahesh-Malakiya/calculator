class FamilyEventModel {
  final String name;
  final String relationship;
  final String familyEvent;
  final double totalReceived;
  final double totalSpent;

  FamilyEventModel({
    required this.name,
    required this.relationship,
    required this.familyEvent,
    required this.totalReceived,
    required this.totalSpent,
  });

  // Factory constructor to create a FamilyEvent instance from a map
  factory FamilyEventModel.fromMap(Map<String, dynamic> map) {
    return FamilyEventModel(
      name: map['name'] ?? '',
      relationship: map['relationship'] ?? '',
      familyEvent: map['familyEvent'] ?? '',
      totalReceived: map['total_received']?.toDouble() ?? 0.0,
      totalSpent: map['total_spent']?.toDouble() ?? 0.0,
    );
  }

  // Method to convert a FamilyEvent instance to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'relationship': relationship,
      'familyEvent': familyEvent,
      'total_received': totalReceived,
      'total_spent': totalSpent,
    };
  }
}
