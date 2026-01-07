import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateEventScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddEvent;

  const CreateEventScreen({super.key, required this.onAddEvent});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  String? _eventType; // نوع الحدث
  final List<String> _eventTypes = [
    "Meeting",
    "Party",
    "Special Occasion",
    "Other",
  ];

  // ===== اختيار التاريخ =====
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  // ===== اختيار الوقت =====
  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  void _submitEvent() {
    if (_formKey.currentState!.validate()) {
      final newEvent = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'date': _dateController.text,
        'time': _timeController.text,
        'location': _locationController.text,
        'type': _eventType ?? "Other",
      };

      widget.onAddEvent(newEvent);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Event Added Successfully')));

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Event')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // ===== Title =====
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Title cannot be empty'
                    : null,
              ),
              const SizedBox(height: 16),

              // ===== Description =====
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Description cannot be empty'
                    : null,
              ),
              const SizedBox(height: 16),

              // ===== Date =====
              TextFormField(
                controller: _dateController,
                readOnly: true,
                onTap: _selectDate,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  prefixIcon: Icon(Icons.date_range),
                  hintText: 'Select date',
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Date cannot be empty'
                    : null,
              ),
              const SizedBox(height: 16),

              // ===== Time =====
              TextFormField(
                controller: _timeController,
                readOnly: true,
                onTap: _selectTime,
                decoration: const InputDecoration(
                  labelText: 'Time',
                  prefixIcon: Icon(Icons.access_time),
                  hintText: 'Select time',
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Time cannot be empty'
                    : null,
              ),
              const SizedBox(height: 16),

              // ===== Location =====
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Location cannot be empty'
                    : null,
              ),
              const SizedBox(height: 16),

              // ===== Event Type Dropdown =====
              DropdownButtonFormField<String>(
                initialValue: _eventType,
                decoration: const InputDecoration(
                  labelText: 'Event Type',
                  prefixIcon: Icon(Icons.category),
                ),
                items: _eventTypes
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _eventType = value;
                  });
                },
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select event type'
                    : null,
              ),
              const SizedBox(height: 24),

              // ===== Add Event Button =====
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitEvent,
                  child: const Text(
                    'Add Event',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
