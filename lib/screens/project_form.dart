import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _description = "";
  String _techStack = "";
  String _projectUrl = "";
  String _projectImageUrl = "";
  bool _isSubmitting = false;

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

  bool _isValidHttpUrl(String value) {
    final uri = Uri.tryParse(value);
    return uri != null &&
        uri.hasScheme &&
        (uri.isScheme('http') || uri.isScheme('https')) &&
        uri.host.isNotEmpty;
  }

  String? _validateProjectUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter a project URL.";
    }
    final trimmed = value.trim();
    if (trimmed.length > 200) {
      return "Project URL cannot exceed 200 characters.";
    }
    if (!_isValidHttpUrl(trimmed)) {
      return "Enter a valid URL starting with http:// or https://.";
    }
    return null;
  }

  String? _validateOptionalImageUrl(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return "Image URL cannot contain only spaces.";
    }
    if (trimmed.length > 500) {
      return "Image URL cannot exceed 500 characters.";
    }
    if (!_isValidHttpUrl(trimmed)) {
      return "Enter a valid URL starting with http:// or https://.";
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final allowed = await ensureLoggedIn(context);
    if (!mounted || !allowed) return;

    final token = context.read<AuthState>().token;
    if (token == null) return;

    setState(() {
      _isSubmitting = true;
    });

    final newProject = Project(
      title: _title.trim(),
      description: _description.trim(),
      techStack: _techStack.trim(),
      projectUrl: _projectUrl.trim(),
      projectImageUrl: _projectImageUrl.trim(),
    );

    try {
      final created = await context.read<ApiClient>().createProject(
        newProject,
        token: token,
      );
      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            backgroundColor: const Color(0xFF14171D),
            title: const Text(
              'Project added successfully!',
              style: TextStyle(color: Color(0xFFFF6A00)),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Title: ${created.title}'),
                  Text('Description: ${created.description}'),
                  Text('Tech Stack: ${created.techStack}'),
                  Text('Project URL: ${created.projectUrl}'),
                  Text(
                    'Image URL: ${created.projectImageUrl.isEmpty ? "-" : created.projectImageUrl}',
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  _formKey.currentState!.reset();
                  setState(() {
                    _title = "";
                    _description = "";
                    _techStack = "";
                    _projectUrl = "";
                    _projectImageUrl = "";
                  });
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
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e.statusCode == 401) {
        await context.read<AuthState>().logout();
        if (!mounted) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              backgroundColor: Color(0xFF9B1C1C),
              content: Text(
                'Session expired (401). Please log in again.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              backgroundColor: const Color(0xFF9B1C1C),
              content: Text(
                'Failed to create project (status ${e.statusCode}).',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFF9B1C1C),
            content: Text(
              'Network error: $e',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C0E),
      appBar: AppBar(
        title: const Text(
          'ADD PROJECT',
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
              // 1. Title (Required, max 255)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  style: const TextStyle(color: Color(0xFFF3F4F6)),
                  decoration: _buildInputDecoration(
                    "Title",
                    "Example: Portfolio Website",
                  ),
                  maxLength: 255,
                  onChanged: (value) => setState(() => _title = value),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter a project title.";
                    }
                    if (value.trim().length > 255) {
                      return "Title cannot exceed 255 characters.";
                    }
                    return null;
                  },
                ),
              ),

              // 2. Description (Required)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  maxLines: 4,
                  style: const TextStyle(color: Color(0xFFF3F4F6)),
                  decoration: _buildInputDecoration(
                    "Description",
                    "Describe what your project does...",
                  ),
                  onChanged: (value) => setState(() => _description = value),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter a project description.";
                    }
                    return null;
                  },
                ),
              ),

              // 3. Tech Stack (Required, max 255)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  style: const TextStyle(color: Color(0xFFF3F4F6)),
                  decoration: _buildInputDecoration(
                    "Tech Stack",
                    "Example: Flutter, Django, PostgreSQL",
                  ),
                  maxLength: 255,
                  onChanged: (value) => setState(() => _techStack = value),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter the technologies used.";
                    }
                    if (value.trim().length > 255) {
                      return "Tech stack cannot exceed 255 characters.";
                    }
                    return null;
                  },
                ),
              ),

              // 4. Project URL (Required, validated URL format, max 200)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  style: const TextStyle(color: Color(0xFFF3F4F6)),
                  decoration: _buildInputDecoration(
                    "Project URL",
                    "Example: https://github.com/SPingol/...",
                  ),
                  maxLength: 200,
                  onChanged: (value) => setState(() => _projectUrl = value),
                  validator: _validateProjectUrl,
                ),
              ),

              // 5. Project Image URL (Optional, max 500)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  style: const TextStyle(color: Color(0xFFF3F4F6)),
                  decoration: _buildInputDecoration(
                    "Project Image URL (Optional)",
                    "Example: https://example.com/preview.png",
                  ),
                  maxLength: 500,
                  onChanged: (value) =>
                      setState(() => _projectImageUrl = value),
                  validator: _validateOptionalImageUrl,
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
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
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
