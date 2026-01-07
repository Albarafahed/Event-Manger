import 'package:flutter/material.dart';

class SmartChatScreen extends StatefulWidget {
  const SmartChatScreen({super.key});

  @override
  State<SmartChatScreen> createState() => _SmartChatScreenState();
}

class _SmartChatScreenState extends State<SmartChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = [];

  // قائمة الأسئلة المحتملة مع الكلمات المفتاحية
  final List<Map<String, dynamic>> _faq = [
    {
      "keywords": ["اضف حدث", "اضافة حدث", "create event", "new event"],
      "answer": "اضغط على زر 'Create Event' لإضافة حدث جديد.",
    },
    {
      "keywords": ["عرض الأحداث", "events list", "شوف الأحداث"],
      "answer": "اذهب إلى 'Events List' لرؤية جميع الأحداث.",
    },
    {
      "keywords": ["تعديل حساب", "edit profile", "change account"],
      "answer": "اذهب إلى الإعدادات لتعديل معلومات حسابك.",
    },
    {
      "keywords": ["تسجيل خروج", "logout", "خروج"],
      "answer": "اضغط على زر 'Logout' في القائمة لتسجيل الخروج.",
    },
    {
      "keywords": ["اضافة صورة", "profile image", "تغيير صورة"],
      "answer": "اضغط على أيقونة '+' في البروفايل لتغيير الصورة.",
    },
    {
      "keywords": ["مساعدة", "help", "كيف", "كيفية", "how"],
      "answer":
          "يمكنك استخدام قائمة التطبيق للتنقل بين إضافة الأحداث، عرض الأحداث، تعديل الحساب وتسجيل الخروج.",
    },
  ];

  // قائمة الاقتراحات أثناء الكتابة
  List<String> _suggestions = [];

  // ===== إرسال رسالة =====
  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": text});
      _controller.clear();
      _suggestions = [];
    });

    String response = "عذرًا، لم أفهم سؤالك.";

    for (var item in _faq) {
      for (var keyword in item["keywords"] as List<String>) {
        if (text.toLowerCase().contains(keyword.toLowerCase())) {
          response = item["answer"];
          break;
        }
      }
      if (response != "عذرًا، لم أفهم سؤالك.") break;
    }

    setState(() {
      _messages.add({"role": "ai", "text": response});
    });

    // تمرير الرسائل تلقائيًا للأسفل
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ===== تحديث الاقتراحات أثناء الكتابة =====
  void _updateSuggestions(String input) {
    if (input.isEmpty) {
      setState(() => _suggestions = []);
      return;
    }

    List<String> matches = [];
    for (var item in _faq) {
      for (var keyword in item["keywords"] as List<String>) {
        if (keyword.toLowerCase().contains(input.toLowerCase())) {
          matches.add(keyword);
        }
      }
    }

    setState(() => _suggestions = matches.toSet().toList()); // إزالة التكرارات
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Smart App Chat")),
      body: Column(
        children: [
          // ===== قائمة الرسائل =====
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                var msg = _messages[index];
                bool isUser = msg["role"] == "user";
                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg["text"]!,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ===== الاقتراحات =====
          if (_suggestions.isNotEmpty)
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _sendMessage(_suggestions[index]),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          _suggestions[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          const Divider(height: 1),

          // ===== حقل الكتابة =====
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "اكتب سؤالك هنا...",
                    ),
                    onChanged: _updateSuggestions,
                    onSubmitted: _sendMessage,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
