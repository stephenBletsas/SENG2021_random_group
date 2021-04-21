// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextMessage _$TextMessageFromJson(Map<String, dynamic> json) {
  return TextMessage(
    idFrom: json['idFrom'] as String,
    content: json['content'] as String,
  )
    ..timestamp =
        const TimestampConverter().fromJson(json['timestamp'] as Timestamp)
    ..type = json['type'] as int;
}

Map<String, dynamic> _$TextMessageToJson(TextMessage instance) =>
    <String, dynamic>{
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
      'type': instance.type,
      'idFrom': instance.idFrom,
      'content': instance.content,
    };

PostCardMessage _$PostCardMessageFromJson(Map<String, dynamic> json) {
  return PostCardMessage(
    idFrom: json['idFrom'] as String,
    question: json['question'] as String,
    hiddenAnswer: json['hiddenAnswer'] as String,
    reply: json['reply'] as String,
  )
    ..timestamp =
        const TimestampConverter().fromJson(json['timestamp'] as Timestamp)
    ..type = json['type'] as int
    ..content = json['content'] as String;
}

Map<String, dynamic> _$PostCardMessageToJson(PostCardMessage instance) =>
    <String, dynamic>{
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
      'type': instance.type,
      'idFrom': instance.idFrom,
      'content': instance.content,
      'question': instance.question,
      'hiddenAnswer': instance.hiddenAnswer,
      'reply': instance.reply,
    };
