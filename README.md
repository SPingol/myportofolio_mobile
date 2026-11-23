# myportofolio_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## REFLECTION QUESTIONS

### Assignment 7

1. Explain what a widget tree is in Flutter and how parent-child relationships work between widgets.

A widget tree is a hierarchical, nested data structure that is formed when widgets are placed inside one another to construct the layout of an application. A parent widget contains one or more child widgets. The child widgets inherits constraints and configuration data from the parent widget while itself is allowed to determine its own dimension within the constraints.

2. List all the widgets you used in this project and explain each of their functions.
    - MyApp: Root application widget that configures global dark theme color scheme, styling, and initial route (MyHomePage)

    - MyHomePage: The main screen widget containing user data (NPM, Name, Class) and the list of the homepage items (items), the overall page structure

    - InfoCard: A reusable custom card widget that displays a titled piece of user metadata (such as NPM, Name, or Class) inside a styled container

    - ItemCard: A reusable interactive tile widget an icon and label for a menu action (ItemHomepage) and displays a notification when interacted with

    # Flutter built-in widgets
    - MaterialApp: Configures top-level Material Design settings, app title, theme data, and navigation

    - Scaffold: Provides the standard visual layout structure for the screen, managing the appBar and body

    - AppBar: Renders the top navigation bar displaying the 'MYPORTFOLIO' title and a bottom accent border

    - PreferredSize: Wraps the bottom accent line inside the AppBar to enforce a specific height of 2.0 pixels

    - Container: A versatile layout and styling box used for setting dimensions (double.infinity or proportional widths), background images (PW.jpg), dark color filters, padding, and the AppBar's orange bottom divider

    - Padding: Adds empty space (insets) around its child widgets for visual separation (e.g., 16.0 around the main body and 3 around item text)

    - Column: Arranges child widgets vertically in a top-to-bottom sequence (used for the main layout, card text, and action button contents)

    - Row: Arranges child widgets horizontally side-by-side (used to display the three InfoCard widgets evenly across the screen)

    - SizedBox: Creates fixed-size empty gaps between widgets (16.0 height between the info row and greeting, 8.0 height inside InfoCard)

    - Center: Centers its child widget horizontally and vertically within the available space

    - Text: Displays styled strings on the screen, such as titles, user details, welcome messages, button labels, and snackbar notifications

    - GridView.count: Creates a scrollable 2D grid layout with a fixed number of columns (crossAxisCount: 3) to display the ItemCard actions

    - Card: Renders a Material Design container with rounded corners and an orange border for each InfoCard

    - Material: Provides a Material surface with background color (item.color) and border shape so that child ink splash effects render properly

    - InkWell: Makes its child area interactive, responding to user taps (onTap) with a visual ripple effect and triggering a SnackBar

    - SnackBar: Displays a temporary dark notification bar at the bottom of the screen confirming which button was pressed

    - Icon: Renders graphical Material icons (Icons.folder, Icons.add_circle, Icons.logout) inside each ItemCard


3. What is the purpose of the MaterialApp widget? Explain why this widget is commonly used as the root widget in Flutter applications.      

The MaterialApp widget is a convenience widget that wraps numerous foundational widgets required for applications implementing Google's Material Design language. It handles routing and navigation, Global theming, Localization and Directionality, and Messenger Integration. Since it handles such essential app wide infrastructure automatically, it is commonly used as the root widget. 


4. Explain the difference between StatelessWidget and StatefulWidget. When should you choose StatelessWidget, and when is StatefulWidget necessary?

StatlessWidget is immutable, only rebuilds if its parent passes new constructor arguments or an inherited dependency changes, and consists of mostly simple build() method. In comparison, StateffulWidget is mutable, rebuilds whenever setState() is called internally, in addition to parent or dependency updates, and it includes lifecycle hooks such as initState(), didUpdateWidget(), build(), and dispose().

StatelessWidget is typically used when the UI depends solely on the configuration passed on into the widget at the time of creation and does not dynamically changed with user interaction or asynchronous data streams.

StatefulWidget is used when a widget must dynamically update its appeareance or data during its lifetime, such as tracking user form inputs, toggles, animations, counters or updating the UI after fetching API data. 

5. What is BuildContext and why is it crucial in Flutter? How is it used inside the build method?

BuildContext is an object that represents the exact location of a specific widget within the widget tree. Since flutter widgets are immutable blueprints, a widget itself does not know where it sits in the hierarchy or who its ancestors are. BuildContext acts as the handler that allows a widget to locate and interact with ancestor widgets up the tree. Within a build method it is used to access inherited data where widgets call static .of(context) methods to retrieve data provided by ancestor widgets. Furthermore its used for triggering ancestor behaviors, such as inside ItemCard's build method, ScaffoldMessenger.of(context) uses context to locate the enclosing ScaffoldMessenger so it can display a SnackBar, and navigation (Navigator.of(context) relies on context to push or pop routes relative to the current screen).    

6. Explain the concept of hot reload in Flutter and how it differs from hot restart. When can you not rely on hot reload and must instead perform a hot restart or full restart?

Hot reload injects updated source code files directly to the Dart Virtual Machine and rebuilds the widget tree, preserving the current app state and is typically quite fast. Whereas, hot restart, restarts the entire Dart Virtual Machine from scratch, re-executing main(), destroying all in-memory app state, resetting the app to the initial state. Its slightly slower than Hot reload though it is still faster than a full native rebuild.

A hot reload cannot be relied upon when modifying global variables or static fields, which are only evalutated when the app starts, essentially the same applies when making changes to main() or initState(), necessitating a hot restart. Converting the widget types and modifying enum definitions or generic type declarations will also require a hot restart. Adding or updating native dependencies/plugins, and editing native configuration files will necessitate a full restart (native binary recompile).

### Assignment 8

1. Explain the differences between Navigator.push(), Navigator.pushReplacement(), and Navigator.pop(). Which method opens the form from the action card? Explain how the Home option in the drawer takes the user back to the home screen.

Navigator.push(), pushes a new route onto the top of the navigation stack while keeping the previous route underneath it, allowing the user to return to the previous screen using the system/browser Back button

Navigator.pushReplacement(), replaces the current route at the top of the stack with a new route and removing the old one, preventing the user from navigating back to the replaced screen

Navigator.pop(), removes the top-most route (such as a screen, modal, or dialog) from the navigation stack and returns focus to the route directly beneath it.

In the ItemCard, clicking the Add Education card calls Navigator.push() to open EducationFormPage on top of MyHomePage, preserving Back-button navigation.

In LeftDrawer (lib/widgets/left_drawer.dart), selecting the Home ListTile executes Navigator.pushReplacement() with MaterialPageRoute(builder: (context) => yHomePageM()). This replaces the active form screen with MyHomePage rather than stacking duplicates of the home screen on top of each other.

2. How does the arrangement of Scaffold, AppBar, and Drawer keep the page structure consistent? Give one example of the portfolio theme colors being used on more than one page.

Both MyHomePage and EducationFormPage use a top-level Scaffold that anchors an AppBar at the top of the screen and attaches the exact same reusable LeftDrawer widget to the drawer property. Reusing this hierarchy guarantees uniform header placement, drawer toggle behavior, and navigation routes across screens. In my case my Project Wingman themed palette.


3. Why was this layout chosen for the form? Explain what the spacing and scrolling widgets do when screen space is limited. A single-column vertical wrapped in a SingleChildScrollView ensures all six Education fields span the available width cleanly and remain readable on both narrow mobile screens and wider desktop browser windows.

When vertical viewport space shrinks such as on compact screens or when the soft on-screen keyboard slides up SingleChildScrollView makes the form scrollable rather than throwing a RenderFlex overflow error, keeping every input field and the Save button accessible.

Outer screen padding and per-field bottom spacing separate touch targets and leave room for inline validation error messages to appear beneath fields without overlapping adjacent inputs.


4. What roles do GlobalKey<FormState>, validator, and validate() play when Save is pressed? Give one example of a value the form rejects and explain why choosing an input widget or keyboard type alone is insufficient.

When the Save button is pressed on EducationFormPage, GlobalKey<FormState> (_formKey), validator, and validate() work together to verify user input before displaying the summary dialog. The GlobalKey<FormState> uniquely identifies the Form widget across rebuilds and gives the external Save ElevatedButton access to its FormState. Inside the form, each TextFormField defines a validator function that inspects the field's current value and returns either a  error message if a constraint is broken or null if the value is valid. Clicking Save calls _formKey.currentState!.validate(), which runs every validator inside the form, displays any returned error messages beneath their corresponding fields, and returns true only when every input passes so that showDialog() can open the summary AlertDialog



## AI DISCLOSURE

### Assignment 7
AI was used minimally for this assignment, only assisting with the hexcode for the colors I desired in menu and main, some comments and minor bugfixes. Aswell as assisting in figuring out how to add an image backdrop. As the task is still relatively simple the limitations of AI have not yet shown. Alternate use was in summarising documentation related information and to check the accuracy of my understanding of a concept(Model used: Gemini Hydrogen).

### Assignment 8
AI was used minimally for this assignment, only assisting in minor bugfixing and some small parts of implementing flutter for one of my portofolio sections. Otherwise use case is the same or similar to Assignment 7, same model was also used.