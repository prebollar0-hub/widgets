import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Widgets',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B7CFA),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F7FF),
          foregroundColor: Color(0xFF1C1E2B),
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  static const List<String> _titles = ['Peoples', 'Chats', 'Calls'];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFFE8ECFF),
              child: const Icon(
                Icons.search_rounded,
                color: Color(0xFF2E3040),
              ),
            ),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [
          _PeopleTab(),
          _ChatsTab(),
          _CallsTab(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
          _pageController.animateToPage(
            value,
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutCubic,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined),
            selectedIcon: Icon(Icons.people_alt_rounded),
            label: 'Peoples',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            selectedIcon: Icon(Icons.chat_bubble_rounded),
            label: 'Chats',
          ),
          NavigationDestination(
            icon: Icon(Icons.call_outlined),
            selectedIcon: Icon(Icons.call_rounded),
            label: 'Calls',
          ),
        ],
      ),
    );
  }
}

class _PeopleTab extends StatelessWidget {
  const _PeopleTab();

  static const List<_Person> people = [
    _Person('Sofia Herrera', 'En línea', Color(0xFF7F8CFF), 'SH'),
    _Person('Mateo Cruz', 'Disponible', Color(0xFF68D5B2), 'MC'),
    _Person('Valentina Ruiz', 'En línea', Color(0xFFF6C569), 'VR'),
    _Person('Daniel Moreno', 'Ocupado', Color(0xFFFF9E8A), 'DM'),
    _Person('Camila Torres', 'En línea', Color(0xFFB09BFF), 'CT'),
    _Person('Lucas Peña', 'Offline', Color(0xFF8ECBF8), 'LP'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: people.length,
      itemBuilder: (context, index) {
        final person = people[index];
        return Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              leading: CircleAvatar(
                radius: 26,
                backgroundColor: person.avatarColor,
                child: Text(
                  person.initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              title: Text(
                person.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                person.status,
                style: TextStyle(
                  color: person.status == 'Offline'
                      ? Colors.grey
                      : const Color(0xFF5B617B),
                  fontSize: 13,
                ),
              ),
              trailing: Icon(
                Icons.message_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            if (index < people.length - 1)
              const Divider(
                height: 1,
                indent: 16,
                endIndent: 16,
                color: Color(0xFFE5E7F3),
              ),
          ],
        );
      },
    );
  }
}

class _ChatsTab extends StatelessWidget {
  const _ChatsTab();

  static const List<_Chat> chats = [
    _Chat('Sofia Herrera', '¿Puedes revisar el mockup antes de la reunión?', '09:42', 2, Color(0xFF7F8CFF), 'SH'),
    _Chat('Mateo Cruz', 'Te envié los archivos del proyecto.', 'Ayer', 1, Color(0xFF68D5B2), 'MC'),
    _Chat('Valentina Ruiz', 'Perfecto, te llamo después para cerrar detalles.', 'Lun', 0, Color(0xFFF6C569), 'VR'),
    _Chat('Daniel Moreno', 'Gracias por la ayuda con la presentación.', 'Dom', 0, Color(0xFFFF9E8A), 'DM'),
    _Chat('Camila Torres', 'La reunión quedó programada para mañana a las 10.', 'Sáb', 3, Color(0xFFB09BFF), 'CT'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: chat.avatarColor,
                child: Text(
                  chat.initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      chat.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    chat.time,
                    style: const TextStyle(
                      color: Color(0xFF7D829B),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                chat.lastMessage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF5B617B),
                  fontSize: 13,
                ),
              ),
              trailing: chat.unreadCount > 0
                  ? Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFF5B7CFA),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${chat.unreadCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  : null,
            ),
            if (index < chats.length - 1)
              const Divider(
                height: 1,
                indent: 16,
                endIndent: 16,
                color: Color(0xFFE5E7F3),
              ),
          ],
        );
      },
    );
  }
}

class _CallsTab extends StatelessWidget {
  const _CallsTab();

  static const List<_Call> calls = [
    _Call('Sofia Herrera', 'Hoy, 09:42', _CallType.incoming, Color(0xFF7F8CFF), 'SH'),
    _Call('Mateo Cruz', 'Ayer, 18:15', _CallType.outgoing, Color(0xFF68D5B2), 'MC'),
    _Call('Sofia Herrera', 'Ayer, 14:06', _CallType.missed, Color(0xFFFF9E8A), 'SH'),
    _Call('Camila Torres', 'Sábado, 10:30', _CallType.incoming, Color(0xFFB09BFF), 'CT'),
    _Call('Daniel Moreno', 'Viernes, 18:55', _CallType.missed, Color(0xFFF6C569), 'DM'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: calls.length,
      itemBuilder: (context, index) {
        final call = calls[index];
        final iconData = switch (call.type) {
          _CallType.incoming => Icons.call_received_rounded,
          _CallType.outgoing => Icons.call_made_rounded,
          _CallType.missed => Icons.call_missed_rounded,
        };
        final iconColor = switch (call.type) {
          _CallType.incoming => const Color(0xFF3EC98E),
          _CallType.outgoing => const Color(0xFF5B7CFA),
          _CallType.missed => const Color(0xFFE85C5C),
        };

        return Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: call.avatarColor,
                child: Text(
                  call.initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              title: Text(
                call.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                call.time,
                style: const TextStyle(
                  color: Color(0xFF5B617B),
                  fontSize: 13,
                ),
              ),
              trailing: Icon(
                iconData,
                color: iconColor,
              ),
            ),
            if (index < calls.length - 1)
              const Divider(
                height: 1,
                indent: 16,
                endIndent: 16,
                color: Color(0xFFE5E7F3),
              ),
          ],
        );
      },
    );
  }
}

class _Person {
  const _Person(this.name, this.status, this.avatarColor, this.initials);

  final String name;
  final String status;
  final Color avatarColor;
  final String initials;
}

class _Chat {
  const _Chat(
    this.name,
    this.lastMessage,
    this.time,
    this.unreadCount,
    this.avatarColor,
    this.initials,
  );

  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final Color avatarColor;
  final String initials;
}

class _Call {
  const _Call(this.name, this.time, this.type, this.avatarColor, this.initials);

  final String name;
  final String time;
  final _CallType type;
  final Color avatarColor;
  final String initials;
}

enum _CallType { incoming, outgoing, missed }
