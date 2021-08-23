library serializers;
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_collection/built_collection.dart';
import 'article.dart';
part 'Serializer.g.dart';

/// Collection of generated serializers for the built_value chat example.
@SerializersFor([
  Article,
])
final Serializers serializers =( _$serializers.toBuilder()..addPlugin(new StandardJsonPlugin())).build();