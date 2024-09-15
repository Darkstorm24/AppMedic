class Doctor {
  final String name;
  final String specialty;
  final String profileImageUrl;
  final String description; // Nouveau champ pour les détails

  Doctor({
    required this.name,
    required this.specialty,
    required this.profileImageUrl,
    required this.description, // Initialiser le nouveau champ
  });
}
