import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementModel {
  String id;
  String title;
  String description;
  Timestamp date;
  String imageUrl;

  AnnouncementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.imageUrl,
  });

  factory AnnouncementModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AnnouncementModel(
      id: doc.id,
      title: data['title'],
      description: data['description'],
      date: data['date'],
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'imageUrl': imageUrl,
    };
  }
}
