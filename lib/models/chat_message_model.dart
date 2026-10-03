enum MessageSender { user, expert }

enum ChatMessageType { text, image, diagnosisCard }

/// Model representing chat consultation messages between farmer and agronomist.
class ChatMessageModel {
  final String id;
  final MessageSender sender;
  final ChatMessageType type;
  final String text;
  final String? mediaUrl;
  final String? mediaCaption;
  final String? diagnosisTitle;
  final String? immediateStep;
  final String timestamp;
  final bool isRead;

  const ChatMessageModel({
    required this.id,
    required this.sender,
    this.type = ChatMessageType.text,
    required this.text,
    this.mediaUrl,
    this.mediaCaption,
    this.diagnosisTitle,
    this.immediateStep,
    required this.timestamp,
    this.isRead = true,
  });
}
