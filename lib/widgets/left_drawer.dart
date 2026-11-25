import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;

    return Drawer(
      backgroundColor: const Color(0xFF12151A),
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF14171D),
              border: Border(
                bottom: BorderSide(color: Color(0xFFFF6A00), width: 2.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Portfolio',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF6A00),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Explore personal projects and experiences!',
                  style: TextStyle(fontSize: 15, color: Color(0xFFE5E7EB)),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined, color: Color(0xFFFF6A00)),
            title: const Text(
              'Home',
              style: TextStyle(color: Color(0xFFF3F4F6)),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.folder_outlined,
              color: Color(0xFFFF6A00),
            ),
            title: const Text(
              'View Projects',
              style: TextStyle(color: Color(0xFFF3F4F6)),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProjectListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.add_circle_outline,
              color: Color(0xFFFF6A00),
            ),
            title: const Text(
              'Add Project',
              style: TextStyle(color: Color(0xFFF3F4F6)),
            ),
            onTap: () async {
              final allowed = await ensureLoggedIn(context);
              if (!context.mounted || !allowed) return;

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProjectFormPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.school_outlined,
              color: Color(0xFFFF6A00),
            ),
            title: const Text(
              'Add Education',
              style: TextStyle(color: Color(0xFFF3F4F6)),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const EducationFormPage(),
                ),
              );
            },
          ),
          const Divider(color: Color(0x33FF6A00)),
          if (!isLoggedIn)
            ListTile(
              leading: const Icon(Icons.login, color: Color(0xFFFF6A00)),
              title: const Text(
                'Login',
                style: TextStyle(color: Color(0xFFF3F4F6)),
              ),
              onTap: () async {
                Navigator.pop(context);
                await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFFEF4444)),
              title: const Text(
                'Logout',
                style: TextStyle(color: Color(0xFFF3F4F6)),
              ),
              onTap: () async {
                final messenger = ScaffoldMessenger.of(context);
                Navigator.pop(context);
                await context.read<AuthState>().logout();
                messenger
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      backgroundColor: Color(0xFF14171D),
                      content: Text(
                        'Logged out successfully.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
              },
            ),
        ],
      ),
    );
  }
}
