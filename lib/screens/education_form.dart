import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _degree = "";
  String _institution = "";
  String _dateRange = "";
  String _descriptionHeader = "Coursework:";
  String _coursework = "";
  String _location = "";

  InputDecoration _buildInputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFF14171D),
      labelStyle: const TextStyle(color: Color(0xFFE5E7EB)),
      hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: Color(0x99FF6A00)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: Color(0xFFFF6A00), width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: Color(0xFFEF4444)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C0E),
      appBar: AppBar(
        title: const Text(
          'ADD EDUCATION',
          style: TextStyle(
            color: Color(0xFFFF6A00),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.8,
          ),
        ),
        backgroundColor: const Color(0xFF12151A),
        iconTheme: const IconThemeData(color: Color(0xFFFF6A00)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(color: const Color(0xFFFF6A00), height: 2.0),
        ),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Degree (Required, max 255)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  style: const TextStyle(color: Color(0xFFF3F4F6)),
                  decoration: _buildInputDecoration(
                    "Degree / Level",
                    "Example: S1 Ilmu Komputer KKI",
                  ),
                  maxLength: 255,
                  onChanged: (value) => setState(() => _degree = value),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter a degree or education level.";
                    }
                    if (value.trim().length > 255) {
                      return "Degree cannot exceed 255 characters.";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  style: const TextStyle(color: Color(0xFFF3F4F6)),
                  decoration: _buildInputDecoration(
                    "Institution",
                    "Example: Universitas Indonesia",
                  ),
                  maxLength: 255,
                  onChanged: (value) => setState(() => _institution = value),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter an institution name.";
                    }
                    if (value.trim().length > 255) {
                      return "Institution cannot exceed 255 characters.";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  style: const TextStyle(color: Color(0xFFF3F4F6)),
                  decoration: _buildInputDecoration(
                    "Time Period",
                    "Example: 2025 – Present",
                  ),
                  maxLength: 100,
                  onChanged: (value) => setState(() => _dateRange = value),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter a time period.";
                    }
                    if (value.trim().length > 100) {
                      return "Time period cannot exceed 100 characters.";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  initialValue: _descriptionHeader,
                  style: const TextStyle(color: Color(0xFFF3F4F6)),
                  decoration: _buildInputDecoration(
                    "Description Header",
                    "Example: Coursework:",
                  ),
                  maxLength: 255,
                  onChanged: (value) =>
                      setState(() => _descriptionHeader = value),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter a description header.";
                    }
                    if (value.trim().length > 255) {
                      return "Description header cannot exceed 255 characters.";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  maxLines: 4,
                  style: const TextStyle(color: Color(0xFFF3F4F6)),
                  decoration: _buildInputDecoration(
                    "Coursework (Newline Separated)",
                    "Data Structures\nAlgorithms\nDatabases",
                  ),
                  onChanged: (value) => setState(() => _coursework = value),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter at least one coursework item.";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  style: const TextStyle(color: Color(0xFFF3F4F6)),
                  decoration: _buildInputDecoration(
                    "Location (Optional)",
                    "Example: Depok, Indonesia",
                  ),
                  maxLength: 255,
                  onChanged: (value) => setState(() => _location = value),
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        value.trim().isEmpty) {
                      return "Location cannot contain only spaces.";
                    }
                    if (value != null && value.trim().length > 255) {
                      return "Location cannot exceed 255 characters.";
                    }
                    return null;
                  },
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6A00),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: const Color(0xFF14171D),
                          title: const Text(
                            'Education added successfully!',
                            style: TextStyle(color: Color(0xFFFF6A00)),
                          ),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Degree: ${_degree.trim()}'),
                                Text('Institution: ${_institution.trim()}'),
                                Text('Time Period: ${_dateRange.trim()}'),
                                Text('Header: ${_descriptionHeader.trim()}'),
                                Text('Coursework:\n${_coursework.trim()}'),
                                Text(
                                  'Location: ${_location.trim().isEmpty ? "-" : _location.trim()}',
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(color: Color(0xFFFF6A00)),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
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
