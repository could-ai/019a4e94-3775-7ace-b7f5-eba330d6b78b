import 'package:flutter/material.dart';

void main() {
  runApp(const FinauraAiApp());
}

class FinauraAiApp extends StatelessWidget {
  const FinauraAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FINAURA AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> sections = [
      {
        'title': 'AI managed retail hub',
        'icon': Icons.storefront,
      },
      {
        'title': 'AI powered Banking and finance centre',
        'icon': Icons.account_balance,
      },
      {
        'title': 'Smart Industry and production',
        'icon': Icons.precision_manufacturing,
      },
      {
        'title': 'Green energy and sustainable sector',
        'icon': Icons.eco,
      },
      {
        'title': 'AI logistics and drone delivery',
        'icon': Icons.local_shipping,
      },
      {
        'title': 'AI commerce Control centre',
        'icon': Icons.hub,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FINAURA AI'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.0,
        ),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final section = sections[index];
          return Card(
            elevation: 4.0,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SectionDetailPage(title: section['title']),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(section['icon'] as IconData, size: 50.0),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      section['title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SectionDetailPage extends StatefulWidget {
  final String title;

  const SectionDetailPage({super.key, required this.title});

  @override
  State<SectionDetailPage> createState() => _SectionDetailPageState();
}

class _SectionDetailPageState extends State<SectionDetailPage> {
  final TextEditingController _chatController = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;
    _chatController.clear();
    setState(() {
      _messages.insert(0, {'sender': 'user', 'text': text});
      // Simple bot reply
      _messages.insert(0, {'sender': 'bot', 'text': "I am a bot for ${widget.title}. You said: '$text'"});
    });
  }

  Widget _buildChatbot() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            padding: const EdgeInsets.all(8.0),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              final isUser = message['sender'] == 'user';
              return Align(
                alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.blue[100] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text(message['text']!),
                ),
              );
            },
          ),
        ),
        const Divider(height: 1.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _chatController,
                  onSubmitted: _handleSubmitted,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Send a message...',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_chatController.text),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Work Related to ${widget.title}', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8.0),
            const Text('Here you can find details about the ongoing projects and tasks related to this section.'),
            const SizedBox(height: 24.0),
            Text('Real-time Progress', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8.0),
            const LinearProgressIndicator(value: 0.65),
            const SizedBox(height: 8.0),
            const Text('Overall Progress: 65%'),
            const SizedBox(height: 24.0),
            Text('AI Chatbot', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: _buildChatbot(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
