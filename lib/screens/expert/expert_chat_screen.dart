import 'package:flutter/material.dart';
import '../../data/dummy_chat_data.dart';
import '../../models/chat_message_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/chat_bubble.dart';

/// Screen 6: Expert Chat Consultation Screen
/// Matches the Figma "Expert Chat" design precisely.
class ExpertChatScreen extends StatefulWidget {
  const ExpertChatScreen({super.key});

  @override
  State<ExpertChatScreen> createState() => _ExpertChatScreenState();
}

class _ExpertChatScreenState extends State<ExpertChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late List<ChatMessageModel> _messages;
  bool _isExpertTyping = false;

  @override
  void initState() {
    super.initState();
    _messages = List.from(dummyChatMessages);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Scroll smoothly to the newest bottom message
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// Handle sending farmer message and simulated expert reply
  void _sendMessage([String? customText]) {
    final String text = customText ?? _messageController.text.trim();
    if (text.isEmpty) return;

    final String currentTime = _formatCurrentTime();

    // 1. Add user message locally and immediately
    setState(() {
      _messages.add(
        ChatMessageModel(
          id: 'user_${DateTime.now().millisecondsSinceEpoch}',
          sender: MessageSender.user,
          type: ChatMessageType.text,
          text: text,
          timestamp: currentTime,
        ),
      );
      _isExpertTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    // 2. Simulate AI/Expert response after a short delay
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;

      final String expertReply = _getExpertReplyForQuery(text);

      setState(() {
        _isExpertTyping = false;
        _messages.add(
          ChatMessageModel(
            id: 'expert_${DateTime.now().millisecondsSinceEpoch}',
            sender: MessageSender.expert,
            type: ChatMessageType.text,
            text: expertReply,
            timestamp: _formatCurrentTime(),
          ),
        );
      });

      _scrollToBottom();
    });
  }

  /// Determine simulated expert response based on query
  String _getExpertReplyForQuery(String query) {
    final String lower = query.toLowerCase();

    for (final entry in contextualExpertResponses.entries) {
      if (lower.contains(entry.key)) {
        return entry.value;
      }
    }

    return defaultSimulatedExpertResponse;
  }

  String _formatCurrentTime() {
    final DateTime now = DateTime.now();
    final int hour = now.hour > 12
        ? now.hour - 12
        : (now.hour == 0 ? 12 : now.hour);
    final String minute = now.minute.toString().padLeft(2, '0');
    final String period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackground,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Expert Profile Header Card
            _buildExpertProfileHeader(),

            // 2. Active Session Banner
            _buildActiveSessionBanner(),

            // 3. Scrollable Chat Message List
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                physics: const BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return ChatBubble(message: message);
                },
              ),
            ),

            // 4. "Dr. Raj is typing..." Indicator
            if (_isExpertTyping) _buildTypingIndicator(),

            // 5. Suggested Quick Reply Chips
            _buildQuickRepliesRow(),

            // 6. Message Input Composer
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }

  /// Custom AppBar with AgriAssist branding and profile
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final bool canPop = Navigator.canPop(context);

    return AppBar(
      backgroundColor: AppTheme.scaffoldBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: canPop
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppTheme.textPrimary,
                size: 22,
              ),
              onPressed: () => Navigator.maybePop(context),
            )
          : null,
      titleSpacing: canPop ? 0 : 16,
      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.eco,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'AgriAssist',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primaryGreen,
                    height: 1.1,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Expert Chat',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: AppTheme.textPrimary,
                size: 24,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No new notifications'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppTheme.alertRed,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 2.0),
          child: Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: AppTheme.primaryGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 19,
            ),
          ),
        ),
      ],
    );
  }

  /// Expert Profile Header matching Figma
  Widget _buildExpertProfileHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Doctor Avatar with Online green dot
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: 44,
                  height: 44,
                  color: AppTheme.primaryGreen,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&auto=format&fit=crop',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 11,
                  height: 11,
                  decoration: BoxDecoration(
                    color: AppTheme.accentGreen,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),

          // Name, Title, and Status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Dr. Raj Patel',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.verified_rounded,
                      color: AppTheme.primaryGreen,
                      size: 15,
                    ),
                  ],
                ),
                const Text(
                  'Agricultural Expert • Plant Pathology',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: AppTheme.accentGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Flexible(
                      child: Text(
                        'Online • Replies in ~5m',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryGreen,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),

          // Action Icon 1: Phone Call
          IconButton(
            icon: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppTheme.softGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.call_outlined,
                color: AppTheme.primaryGreen,
                size: 17,
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Calling Dr. Raj Patel via Kisan Helpline...'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),

          // Action Icon 2: Expert Info
          IconButton(
            icon: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppTheme.softGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.info_outline_rounded,
                color: AppTheme.primaryGreen,
                size: 17,
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Dr. Raj Patel • 12+ years experience in Crop Pathology & Disease Management.',
                  ),
                  duration: Duration(seconds: 3),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Active Session Sector Banner
  Widget _buildActiveSessionBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: AppTheme.softGreen,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.mintContainer, width: 0.8),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.eco,
                  color: AppTheme.primaryGreen,
                  size: 13,
                ),
                SizedBox(width: 5),
                Flexible(
                  child: Text(
                    'Active Session: Field Sector 4 (Tomatoes)',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primaryGreen,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Text(
            'Free Support',
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryGreenMedium,
            ),
          ),
        ],
      ),
    );
  }

  /// "Dr. Raj Patel is typing..." Animated typing indicator
  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.surfaceWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderLight, width: 0.8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  'Dr. Raj Patel is typing...',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Suggested Quick Reply Action Chips
  Widget _buildQuickRepliesRow() {
    return Container(
      height: 38,
      margin: const EdgeInsets.only(bottom: 6.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        physics: const BouncingScrollPhysics(),
        children: dummyQuickReplies.map((reply) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () => _sendMessage(reply),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceWhite,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderLight, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.forum_outlined,
                      size: 12,
                      color: AppTheme.primaryGreen,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      reply,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Bottom Message Input Composer Bar
  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceWhite,
        border: Border(
          top: BorderSide(color: AppTheme.borderLight, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Attachment Icon Button
          IconButton(
            icon: const Icon(
              Icons.attach_file_rounded,
              color: AppTheme.textSecondary,
              size: 22,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Attach field soil report or lab test document'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),

          // Camera Icon Button
          IconButton(
            icon: const Icon(
              Icons.camera_alt_outlined,
              color: AppTheme.textSecondary,
              size: 22,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Capture photo of affected leaf for Dr. Raj'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),

          // Text Input Field
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.scaffoldBackground,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppTheme.borderLight, width: 0.8),
              ),
              child: TextField(
                controller: _messageController,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                ),
                decoration: const InputDecoration(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Send Button
          InkWell(
            onTap: () => _sendMessage(),
            borderRadius: BorderRadius.circular(22),
            child: Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: AppTheme.primaryGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
