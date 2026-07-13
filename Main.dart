import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const LuyandoApp());
}

class LuyandoApp extends StatelessWidget {
  const LuyandoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luyando AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
      ),
      home: const AuthPage(),
    );
  }
}

// 1. AUTH PAGE
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.orange, Colors.red, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                ClipOval(
                  child: Image.network("https://i.imgur.com/8Km9tLL.png", height: 120, width: 120, fit: BoxFit.cover, errorBuilder: (_,__,___)=>const Icon(Icons.person, size: 120, color: Colors.white)),
                ),
                const SizedBox(height: 20),
                const Text("Welcome Mulibwaji 🙏", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                const Text("My name is Luyando Katengula", style: TextStyle(fontSize: 18, color: Colors.white70)),
                const Text("Created by Professor Katengula", style: TextStyle(fontSize: 14, color: Colors.orange)),
                const SizedBox(height: 30),

                TextField(controller: emailController, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: "Email", filled: true, fillColor: Colors.white10, labelStyle: const TextStyle(color: Colors.white70))),
                const SizedBox(height: 10),
                TextField(controller: passwordController, obscureText: true, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: "Password", filled: true, fillColor: Colors.white10, labelStyle: const TextStyle(color: Colors.white70))),
                if (!isLogin)...[
                  const SizedBox(height: 10),
                  TextField(controller: phoneController, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: "Phone Number", filled: true, fillColor: Colors.white10, labelStyle: const TextStyle(color: Colors.white70))),
                ],
                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
                  },
                  child: Text(isLogin? "LOGIN" : "SIGN UP", style: const TextStyle(fontSize: 18)),
                ),
                TextButton(
                  onPressed: () => setState(() => isLogin =!isLogin),
                  child: Text(isLogin? "Don't have an account? Sign Up" : "Already have an account? Login", style: const TextStyle(color: Colors.white)),
                ),
                const Text("Verification code will be sent to email & phone", style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 2. HOME PAGE WITH 7 TABS
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const TradingPage(),
    const PsychologyPage(),
    const ChatPage(),
    const CommunityPage(),
    const VipPage(),
    const AboutPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LUYANDO AI"), backgroundColor: Colors.grey[900], centerTitle: true),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white54,
        backgroundColor: Colors.grey[900],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Trading"),
          BottomNavigationBarItem(icon: Icon(Icons.psychology), label: "Psychology"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "AI Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Community"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "VIP"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "About"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}

// 3. TRADING PAGE
class TradingPage extends StatelessWidget {
  const TradingPage({super.key});

  void _showBrokerDialog(BuildContext context, String broker) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text("Connect $broker"),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: "$broker Login ID", labelStyle: const TextStyle(color: Colors.white70))),
          const SizedBox(height: 10),
          TextField(style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: "$broker Server", labelStyle: const TextStyle(color: Colors.white70))),
          const SizedBox(height: 10),
          TextField(style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Password", labelStyle: TextStyle(color: Colors.white70)), obscureText: true),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL")),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () { Navigator.pop(context); }, child: const Text("CONNECT"))
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(children: [
      Card(color: Colors.grey[900], child: const ListTile(title: Text("Account Balance"), trailing: Text("\$5.00", style: TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold)))),
      const SizedBox(height: 20),
      const Text("SELECT BROKER", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
      const SizedBox(height: 10),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red), onPressed: () => _showBrokerDialog(context, "DERIV"), child: const Text("CONNECT DERIV")),
      const SizedBox(height: 10),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), onPressed: () => _showBrokerDialog(context, "WELTRADE"), child: const Text("CONNECT WELTRADE")),
      const SizedBox(height: 10),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), onPressed: (){}, child: const Text("START AUTO HF - \$0.10 RISK")),
      const SizedBox(height: 10),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.purple), onPressed: (){}, child: const Text("START AUTO SWING - \$0.50 RISK")),
      const SizedBox(height: 10),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]), onPressed: (){}, child: const Text("VIEW TRADE HISTORY")),
    ]));
  }
}

// 4. PSYCHOLOGY PAGE
class PsychologyPage extends StatefulWidget {
  const PsychologyPage({super.key});
  @override
  State<PsychologyPage> createState() => _PsychologyPageState();
}

class _PsychologyPageState extends State<PsychologyPage> {
  int losses = 0;
  String mood = "Calm";

  void addLoss() {
    setState(() {
      losses++;
      if (losses == 1) mood = "Calm";
      if (losses == 2) mood = "Careful: Take Break";
      if (losses >= 3) mood = "DANGER: Stop Trading";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(children: [
      const Text("TRADING PSYCHOLOGY COACH", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
      const SizedBox(height: 20),
      Text("Mindset: $mood", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: losses >= 3? Colors.red : losses >= 2? Colors.orange : Colors.green)),
      const SizedBox(height: 20),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), onPressed: addLoss, child: const Text("I Just Lost a Trade")),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () => setState(() { losses = 0; mood = "Calm"; }), child: const Text("Reset Day")),
      const SizedBox(height: 20),
      const Text("Luyando's 5 Rules:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 10),
      const Text("1. Don't revenge trade\n2. 2 losses = 30min break\n3. Pray before trading\n4. Protect your capital\n5. God is with you", textAlign: TextAlign.center),
      const SizedBox(height: 20),
      const Text("Daily Quote from Professor Katengula:", style: TextStyle(color: Colors.orange)),
      const Text("Discipline is the bridge between goals and achievement.", textAlign: TextAlign.center),
    ]));
  }
}

// 5. CHAT PAGE - LUYANDO KATENGLA AI
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, String>> messages = [
    {"sender": "bot", "text": "Zikomo Mulibwaji! I am Luyando Katengula 🇿🇲 Created by Professor Katengula. \n\nMy AI brain is sleeping. Add API key to wake me up 🙏"}
  ];
  final controller = TextEditingController();
  bool isLoading = false;

  // LEAVE BLANK FOR SAFETY. WE ADD KEY LATER
  static const String API_KEY = "";

  Future<void> sendMessage() async {
    if (controller.text.isEmpty) return;
    String userText = controller.text;

    setState(() {
      messages.add({"sender": "user", "text": userText});
      messages.add({"sender": "bot", "text": "Luyando is typing..."});
      controller.clear();
      isLoading = true;
    });

    String aiReply = await getAIReply(userText);

    setState(() {
      messages.removeLast();
      messages.add({"sender": "bot", "text": aiReply});
      isLoading = false;
    });
  }

  Future<String> getAIReply(String userMessage) async {
    if(API_KEY.isEmpty){
      return "Mulibwaji, my AI brain is not connected yet. Professor Katengula needs to add the API key safely. But I am still here to support you 💚";
    }

    final url = Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$API_KEY");

    String systemPrompt = """
    You are Luyando Katengula, a Zambian AI Assistant created by Professor Katengula.
    You speak warm, caring, and like a Zambian sister. Use words like 'Mulibwaji' and 'Zikomo'.
    Your specialties: Trading psychology, Forex, Deriv, Weltrade, Faith, Bible, Motivation, Jobs for Zambians.
    Always be encouraging, mention discipline and God. Keep answers short, 2-3 sentences.
    """;

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"contents": [{"parts": [{"text": "$systemPrompt\nUser: $userMessage"}]}]}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        return "Sorry Mulibwaji, I can't connect to internet right now.";
      }
    } catch (e) {
      return "Network error. Please check internet. Zikomo.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 10),
      ClipOval(child: Image.network("https://i.imgur.com/8Km9tLL.png", height: 100, width: 100, fit: BoxFit.cover, errorBuilder: (_,__,___)=>const Icon(Icons.person, size: 100, color: Colors.white))),
      const Text("Luyando Katengula", style: TextStyle(color: Colors.orange)),
      const Divider(color: Colors.green),
      Expanded(child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, i) {
          final msg = messages[i];
          return Align(
            alignment: msg["sender"] == "user"? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: msg["sender"] == "user"? Colors.green : Colors.grey[800],
                borderRadius: BorderRadius.circular(12)
              ),
              child: Text(msg["text"]!, style: const TextStyle(color: Colors.white)),
            ),
          );
        },
      )),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Expanded(child: TextField(controller: controller, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "Talk to Luyando...", hintStyle: TextStyle(color: Colors.white54), filled: true, fillColor: Colors.white10))),
          const SizedBox(width: 8),
          isLoading? const CircularProgressIndicator(color: Colors.green) : IconButton(icon: const Icon(Icons.send, color: Colors.green, size: 30), onPressed: sendMessage),
        ]),
      ),
    ]);
  }
}

// 6. COMMUNITY PAGE
class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: (){}, child: const Text("Create Community Group - By Professor Katengula")),
      const SizedBox(height: 10),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), onPressed: (){}, child: const Text("Create VIP Subscription for Followers")),
      const SizedBox(height: 10),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), onPressed: (){}, child: const Text("Join Public Groups")),
    ]));
  }
}

// 7. VIP PAGE
class VipPage extends StatelessWidget {
  const VipPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: (){}, child: const Text("2 WEEKS - \$12")),
      const SizedBox(height: 10),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: (){}, child: const Text("MONTHLY - \$20")),
      const SizedBox(height: 10),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: (){}, child: const Text("3 MONTHS - \$50")),
      const SizedBox(height: 20),
      const Text("Pay to: MTN 0968269638 / Airtel 0779475399", style: TextStyle(fontSize: 16, color: Colors.orange)),
      const SizedBox(height: 10),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), onPressed: (){}, child: const Text("Upload Proof of Payment")),
    ]));
  }
}

// 8. ABOUT PAGE
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      const Text("ABOUT LUYANDO AI", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
      const SizedBox(height: 20),
      const Text("Creator: Professor Katengula"),
      const Text("Mission:
