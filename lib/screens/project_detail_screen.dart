import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final hasImage = project.projectImageUrl.trim().isNotEmpty;
    final hasUrl = project.projectUrl.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0C0E),
      appBar: AppBar(
        title: Text(
          project.title,
          style: const TextStyle(
            color: Color(0xFFFF6A00),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF12151A),
        iconTheme: const IconThemeData(color: Color(0xFFFF6A00)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(color: const Color(0xFFFF6A00), height: 2.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: const Color(0xFF14171D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(color: Color(0x99FF6A00), width: 1.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasImage) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      project.projectImageUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 150,
                        width: double.infinity,
                        color: const Color(0xFF0A0C0E),
                        alignment: Alignment.center,
                        child: const Text(
                          'Failed to load project image.',
                          style: TextStyle(color: Color(0xFF9CA3AF)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Title
                Text(
                  project.title,
                  style: const TextStyle(
                    color: Color(0xFFF3F4F6),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Tech Stack
                const Text(
                  'TECH STACK',
                  style: TextStyle(
                    color: Color(0xFFFF6A00),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  project.techStack,
                  style: const TextStyle(
                    color: Color(0xFFE5E7EB),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 16),

                // Description
                const Text(
                  'DESCRIPTION',
                  style: TextStyle(
                    color: Color(0xFFFF6A00),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  project.description,
                  style: const TextStyle(
                    color: Color(0xFFE5E7EB),
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),

                // Project URL
                const Text(
                  'PROJECT URL',
                  style: TextStyle(
                    color: Color(0xFFFF6A00),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hasUrl ? project.projectUrl : 'No URL provided.',
                  style: TextStyle(
                    color: hasUrl
                        ? const Color(0xFFFF6A00)
                        : const Color(0xFF9CA3AF),
                    fontSize: 14,
                    decoration: hasUrl
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    decorationColor: const Color(0xFFFF6A00),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
