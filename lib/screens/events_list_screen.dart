import 'package:flutter/material.dart';

class EventsListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> events;

  const EventsListScreen({super.key, required this.events});

  List<Map<String, dynamic>> _filterEvents(String type) {
    if (type == 'All') return events;
    return events.where((e) => e['type'] == type).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Events"),
          bottom: const TabBar(
            unselectedLabelColor: Colors.white,
            labelColor: Colors.red,
            indicatorColor: Colors.blue,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: "All"),
              Tab(text: "Meeting"),
              Tab(text: "Party"),
              Tab(text: "Special Occasion"),
              Tab(text: "Other"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildList(_filterEvents('All')),
            _buildList(_filterEvents('Meeting')),
            _buildList(_filterEvents('Party')),
            _buildList(_filterEvents('Special Occasion')),
            _buildList(_filterEvents('Other')),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<Map<String, dynamic>> list) {
    if (list.isEmpty) {
      return const Center(child: Text("No events"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final event = list[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            title: Text(event['title']),
            subtitle: Text(
              "${event['date']} - ${event['time']}\n${event['location']}",
            ),
            trailing: Chip(label: Text(event['type'])),
          ),
        );
      },
    );
  }
}
