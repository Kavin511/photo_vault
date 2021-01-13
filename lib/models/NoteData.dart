/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the NoteData type in your schema. */
@immutable
class NoteData extends Model {
  static const classType = const NoteDataType();
  final String id;
  final String name;
  final String description;
  final String image;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const NoteData._internal(
      {@required this.id, @required this.name, this.description, this.image});

  factory NoteData(
      {@required String id,
      @required String name,
      String description,
      String image}) {
    return NoteData._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        description: description,
        image: image);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NoteData &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        image == other.image;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("NoteData {");
    buffer.write("id=" + id + ", ");
    buffer.write("name=" + name + ", ");
    buffer.write("description=" + description + ", ");
    buffer.write("image=" + image);
    buffer.write("}");

    return buffer.toString();
  }

  NoteData copyWith(
      {String id, String name, String description, String image}) {
    return NoteData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image);
  }

  NoteData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        image = json['image'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'description': description, 'image': image};

  static final QueryField ID = QueryField(fieldName: "noteData.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField IMAGE = QueryField(fieldName: "image");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "NoteData";
    modelSchemaDefinition.pluralName = "NoteData";

    modelSchemaDefinition.authRules = [
      AuthRule(
          authStrategy: AuthStrategy.OWNER,
          ownerField: "owner",
          identityClaim: "cognito:username",
          operations: [
            ModelOperation.CREATE,
            ModelOperation.UPDATE,
            ModelOperation.DELETE,
            ModelOperation.READ
          ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: NoteData.NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: NoteData.DESCRIPTION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: NoteData.IMAGE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class NoteDataType extends ModelType<NoteData> {
  const NoteDataType();

  @override
  NoteData fromJson(Map<String, dynamic> jsonData) {
    return NoteData.fromJson(jsonData);
  }
}
