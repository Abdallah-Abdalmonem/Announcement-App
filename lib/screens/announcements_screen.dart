import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:school_announcements/models/announcement_model.dart';

import '../widgets/custom_rich_text.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff8110b9),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.jpg', width: 46, height: 46),
            const SizedBox(width: 2),
            const Text('Student App', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('announcements')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return MyListViewWidget(
            snapshot: snapshot,
          );
        },
      ),
    );
  }
}

class MyListViewWidget extends StatelessWidget {
  const MyListViewWidget({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: snapshot.data!.docs.map((doc) {
        final AnnouncementModel announcement =
            AnnouncementModel.fromDocument(doc);
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 4,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: const GradientBoxBorder(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                ),
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: FancyShimmerImage(
                      boxDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      imageUrl: announcement.imageUrl,
                      boxFit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(announcement.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(announcement.description),
                const SizedBox(height: 8),
                CustomRichText(
                  title: 'date',
                  content:
                      announcement.date.toDate().toString().substring(0, 10),
                ),
                CustomRichText(
                  title: 'time',
                  content:
                      announcement.date.toDate().toString().substring(10, 16),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
