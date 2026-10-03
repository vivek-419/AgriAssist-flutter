import '../models/chat_message_model.dart';

/// Initial dummy chat conversation dataset matching the Figma Expert Chat screen.
final List<ChatMessageModel> dummyChatMessages = [
  const ChatMessageModel(
    id: 'msg_1',
    sender: MessageSender.expert,
    type: ChatMessageType.text,
    text: 'Hello! How can I help you with your crop?',
    timestamp: '10:30 AM',
  ),
  const ChatMessageModel(
    id: 'msg_2',
    sender: MessageSender.user,
    type: ChatMessageType.text,
    text: 'My tomato leaves have started developing dark spots.',
    timestamp: '10:31 AM',
  ),
  const ChatMessageModel(
    id: 'msg_3',
    sender: MessageSender.expert,
    type: ChatMessageType.text,
    text: 'Please share a clear image of the affected leaves.',
    timestamp: '10:32 AM',
  ),
];

/// Simulated expert follow-up responses based on context keywords
const String defaultSimulatedExpertResponse =
    'Thank you for the information. Please upload a clear image of the affected leaves so I can help you further.';

final Map<String, String> contextualExpertResponses = {
  'dosage':
      'For Early Blight in tomatoes, apply Copper Hydroxide (2g per liter) or Mancozeb 75 WP (2.5g per liter) uniformly over the foliage.',
  'organic':
      'You can apply Neem seed kernel extract (5%) or Trichoderma viride bio-fungicide as an organic preventative spray.',
  'water':
      'Avoid overhead sprinkler irrigation to keep the leaves dry. Direct water to the base of the tomato plants or use drip lines.',
  'blight':
      'That confirms typical Early Blight symptoms. Prune the lowest infected leaves and spray with a copper-based fungicide before evening.',
};

final List<String> dummyQuickReplies = [
  'Recommended dosage?',
  'Organic alternative',
  'Watering schedule',
  'Preventive care steps',
];
