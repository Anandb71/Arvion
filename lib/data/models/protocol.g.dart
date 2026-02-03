// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'protocol.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProtocolCollection on Isar {
  IsarCollection<Protocol> get protocols => this.collection();
}

const ProtocolSchema = CollectionSchema(
  name: r'Protocol',
  id: -5760239004301737085,
  properties: {
    r'colorTheme': PropertySchema(
      id: 0,
      name: r'colorTheme',
      type: IsarType.string,
    ),
    r'conditions': PropertySchema(
      id: 1,
      name: r'conditions',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'customColorHex': PropertySchema(
      id: 3,
      name: r'customColorHex',
      type: IsarType.string,
    ),
    r'daysRemaining': PropertySchema(
      id: 4,
      name: r'daysRemaining',
      type: IsarType.long,
    ),
    r'deadline': PropertySchema(
      id: 5,
      name: r'deadline',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 6,
      name: r'description',
      type: IsarType.string,
    ),
    r'failedWeeks': PropertySchema(
      id: 7,
      name: r'failedWeeks',
      type: IsarType.long,
    ),
    r'failureRules': PropertySchema(
      id: 8,
      name: r'failureRules',
      type: IsarType.string,
    ),
    r'isAchieved': PropertySchema(
      id: 9,
      name: r'isAchieved',
      type: IsarType.bool,
    ),
    r'isActive': PropertySchema(
      id: 10,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'isOverdue': PropertySchema(
      id: 11,
      name: r'isOverdue',
      type: IsarType.bool,
    ),
    r'linkedTaskIds': PropertySchema(
      id: 12,
      name: r'linkedTaskIds',
      type: IsarType.longList,
    ),
    r'name': PropertySchema(
      id: 13,
      name: r'name',
      type: IsarType.string,
    ),
    r'progressPercent': PropertySchema(
      id: 14,
      name: r'progressPercent',
      type: IsarType.double,
    ),
    r'successfulWeeks': PropertySchema(
      id: 15,
      name: r'successfulWeeks',
      type: IsarType.long,
    ),
    r'totalCommits': PropertySchema(
      id: 16,
      name: r'totalCommits',
      type: IsarType.long,
    ),
    r'weeklyTarget': PropertySchema(
      id: 17,
      name: r'weeklyTarget',
      type: IsarType.long,
    )
  },
  estimateSize: _protocolEstimateSize,
  serialize: _protocolSerialize,
  deserialize: _protocolDeserialize,
  deserializeProp: _protocolDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isActive': IndexSchema(
      id: 8092228061260947457,
      name: r'isActive',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isActive',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _protocolGetId,
  getLinks: _protocolGetLinks,
  attach: _protocolAttach,
  version: '3.1.0+1',
);

int _protocolEstimateSize(
  Protocol object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.colorTheme.length * 3;
  {
    final value = object.conditions;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.customColorHex;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.failureRules;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.linkedTaskIds.length * 8;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _protocolSerialize(
  Protocol object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.colorTheme);
  writer.writeString(offsets[1], object.conditions);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.customColorHex);
  writer.writeLong(offsets[4], object.daysRemaining);
  writer.writeDateTime(offsets[5], object.deadline);
  writer.writeString(offsets[6], object.description);
  writer.writeLong(offsets[7], object.failedWeeks);
  writer.writeString(offsets[8], object.failureRules);
  writer.writeBool(offsets[9], object.isAchieved);
  writer.writeBool(offsets[10], object.isActive);
  writer.writeBool(offsets[11], object.isOverdue);
  writer.writeLongList(offsets[12], object.linkedTaskIds);
  writer.writeString(offsets[13], object.name);
  writer.writeDouble(offsets[14], object.progressPercent);
  writer.writeLong(offsets[15], object.successfulWeeks);
  writer.writeLong(offsets[16], object.totalCommits);
  writer.writeLong(offsets[17], object.weeklyTarget);
}

Protocol _protocolDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Protocol();
  object.colorTheme = reader.readString(offsets[0]);
  object.conditions = reader.readStringOrNull(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.customColorHex = reader.readStringOrNull(offsets[3]);
  object.deadline = reader.readDateTimeOrNull(offsets[5]);
  object.description = reader.readStringOrNull(offsets[6]);
  object.failedWeeks = reader.readLong(offsets[7]);
  object.failureRules = reader.readStringOrNull(offsets[8]);
  object.id = id;
  object.isActive = reader.readBool(offsets[10]);
  object.linkedTaskIds = reader.readLongList(offsets[12]) ?? [];
  object.name = reader.readString(offsets[13]);
  object.progressPercent = reader.readDouble(offsets[14]);
  object.successfulWeeks = reader.readLong(offsets[15]);
  object.totalCommits = reader.readLong(offsets[16]);
  object.weeklyTarget = reader.readLong(offsets[17]);
  return object;
}

P _protocolDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readLongList(offset) ?? []) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readDouble(offset)) as P;
    case 15:
      return (reader.readLong(offset)) as P;
    case 16:
      return (reader.readLong(offset)) as P;
    case 17:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _protocolGetId(Protocol object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _protocolGetLinks(Protocol object) {
  return [];
}

void _protocolAttach(IsarCollection<dynamic> col, Id id, Protocol object) {
  object.id = id;
}

extension ProtocolQueryWhereSort on QueryBuilder<Protocol, Protocol, QWhere> {
  QueryBuilder<Protocol, Protocol, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterWhere> anyIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isActive'),
      );
    });
  }
}

extension ProtocolQueryWhere on QueryBuilder<Protocol, Protocol, QWhereClause> {
  QueryBuilder<Protocol, Protocol, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterWhereClause> nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterWhereClause> nameNotEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterWhereClause> createdAtEqualTo(
      DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterWhereClause> createdAtNotEqualTo(
      DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterWhereClause> createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterWhereClause> createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterWhereClause> createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterWhereClause> isActiveEqualTo(
      bool isActive) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isActive',
        value: [isActive],
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterWhereClause> isActiveNotEqualTo(
      bool isActive) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [],
              upper: [isActive],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [isActive],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [isActive],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [],
              upper: [isActive],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ProtocolQueryFilter
    on QueryBuilder<Protocol, Protocol, QFilterCondition> {
  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> colorThemeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorTheme',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> colorThemeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'colorTheme',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> colorThemeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'colorTheme',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> colorThemeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'colorTheme',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> colorThemeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'colorTheme',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> colorThemeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'colorTheme',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> colorThemeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'colorTheme',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> colorThemeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'colorTheme',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> colorThemeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorTheme',
        value: '',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      colorThemeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'colorTheme',
        value: '',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> conditionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'conditions',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      conditionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'conditions',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> conditionsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conditions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> conditionsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'conditions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> conditionsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'conditions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> conditionsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'conditions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> conditionsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'conditions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> conditionsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'conditions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> conditionsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'conditions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> conditionsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'conditions',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> conditionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conditions',
        value: '',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      conditionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'conditions',
        value: '',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      customColorHexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customColorHex',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      customColorHexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customColorHex',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> customColorHexEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customColorHex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      customColorHexGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customColorHex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      customColorHexLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customColorHex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> customColorHexBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customColorHex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      customColorHexStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customColorHex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      customColorHexEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customColorHex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      customColorHexContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customColorHex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> customColorHexMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customColorHex',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      customColorHexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customColorHex',
        value: '',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      customColorHexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customColorHex',
        value: '',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      daysRemainingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'daysRemaining',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      daysRemainingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'daysRemaining',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> daysRemainingEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'daysRemaining',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      daysRemainingGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'daysRemaining',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> daysRemainingLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'daysRemaining',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> daysRemainingBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'daysRemaining',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> deadlineIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deadline',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> deadlineIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deadline',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> deadlineEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deadline',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> deadlineGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deadline',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> deadlineLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deadline',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> deadlineBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deadline',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> failedWeeksEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'failedWeeks',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      failedWeeksGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'failedWeeks',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> failedWeeksLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'failedWeeks',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> failedWeeksBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'failedWeeks',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> failureRulesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'failureRules',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      failureRulesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'failureRules',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> failureRulesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'failureRules',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      failureRulesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'failureRules',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> failureRulesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'failureRules',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> failureRulesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'failureRules',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      failureRulesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'failureRules',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> failureRulesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'failureRules',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> failureRulesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'failureRules',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> failureRulesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'failureRules',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      failureRulesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'failureRules',
        value: '',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      failureRulesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'failureRules',
        value: '',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> isAchievedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isAchieved',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> isActiveEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> isOverdueEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isOverdue',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      linkedTaskIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkedTaskIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      linkedTaskIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'linkedTaskIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      linkedTaskIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'linkedTaskIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      linkedTaskIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'linkedTaskIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      linkedTaskIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'linkedTaskIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      linkedTaskIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'linkedTaskIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      linkedTaskIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'linkedTaskIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      linkedTaskIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'linkedTaskIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      linkedTaskIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'linkedTaskIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      linkedTaskIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'linkedTaskIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      progressPercentEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'progressPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      progressPercentGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'progressPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      progressPercentLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'progressPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      progressPercentBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'progressPercent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      successfulWeeksEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'successfulWeeks',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      successfulWeeksGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'successfulWeeks',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      successfulWeeksLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'successfulWeeks',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      successfulWeeksBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'successfulWeeks',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> totalCommitsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalCommits',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      totalCommitsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalCommits',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> totalCommitsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalCommits',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> totalCommitsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalCommits',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> weeklyTargetEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weeklyTarget',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition>
      weeklyTargetGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weeklyTarget',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> weeklyTargetLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weeklyTarget',
        value: value,
      ));
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterFilterCondition> weeklyTargetBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weeklyTarget',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ProtocolQueryObject
    on QueryBuilder<Protocol, Protocol, QFilterCondition> {}

extension ProtocolQueryLinks
    on QueryBuilder<Protocol, Protocol, QFilterCondition> {}

extension ProtocolQuerySortBy on QueryBuilder<Protocol, Protocol, QSortBy> {
  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByColorTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorTheme', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByColorThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorTheme', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByConditions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conditions', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByConditionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conditions', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByCustomColorHex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customColorHex', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByCustomColorHexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customColorHex', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByDaysRemaining() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysRemaining', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByDaysRemainingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysRemaining', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByDeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByFailedWeeks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failedWeeks', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByFailedWeeksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failedWeeks', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByFailureRules() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failureRules', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByFailureRulesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failureRules', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByIsAchieved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAchieved', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByIsAchievedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAchieved', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByIsOverdue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOverdue', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByIsOverdueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOverdue', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByProgressPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressPercent', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByProgressPercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressPercent', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortBySuccessfulWeeks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'successfulWeeks', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortBySuccessfulWeeksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'successfulWeeks', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByTotalCommits() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCommits', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByTotalCommitsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCommits', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByWeeklyTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyTarget', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> sortByWeeklyTargetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyTarget', Sort.desc);
    });
  }
}

extension ProtocolQuerySortThenBy
    on QueryBuilder<Protocol, Protocol, QSortThenBy> {
  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByColorTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorTheme', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByColorThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorTheme', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByConditions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conditions', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByConditionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conditions', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByCustomColorHex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customColorHex', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByCustomColorHexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customColorHex', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByDaysRemaining() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysRemaining', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByDaysRemainingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysRemaining', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByDeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByFailedWeeks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failedWeeks', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByFailedWeeksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failedWeeks', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByFailureRules() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failureRules', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByFailureRulesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failureRules', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByIsAchieved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAchieved', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByIsAchievedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAchieved', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByIsOverdue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOverdue', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByIsOverdueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOverdue', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByProgressPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressPercent', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByProgressPercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressPercent', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenBySuccessfulWeeks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'successfulWeeks', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenBySuccessfulWeeksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'successfulWeeks', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByTotalCommits() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCommits', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByTotalCommitsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCommits', Sort.desc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByWeeklyTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyTarget', Sort.asc);
    });
  }

  QueryBuilder<Protocol, Protocol, QAfterSortBy> thenByWeeklyTargetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyTarget', Sort.desc);
    });
  }
}

extension ProtocolQueryWhereDistinct
    on QueryBuilder<Protocol, Protocol, QDistinct> {
  QueryBuilder<Protocol, Protocol, QDistinct> distinctByColorTheme(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'colorTheme', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Protocol, Protocol, QDistinct> distinctByConditions(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'conditions', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Protocol, Protocol, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Protocol, Protocol, QDistinct> distinctByCustomColorHex(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customColorHex',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Protocol, Protocol, QDistinct> distinctByDaysRemaining() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'daysRemaining');
    });
  }

  QueryBuilder<Protocol, Protocol, QDistinct> distinctByDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deadline');
    });
  }

  QueryBuilder<Protocol, Protocol, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Protocol, Protocol, QDistinct> distinctByFailedWeeks() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'failedWeeks');
    });
  }

  QueryBuilder<Protocol, Protocol, QDistinct> distinctByFailureRules(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'failureRules', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Protocol, Protocol, QDistinct> distinctByIsAchieved() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAchieved');
    });
  }

  QueryBuilder<Protocol, Protocol, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<Protocol, Protocol, QDistinct> distinctByIsOverdue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isOverdue');
    });
  }

  QueryBuilder<Protocol, Protocol, QDistinct> distinctByLinkedTaskIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'linkedTaskIds');
    });
  }

  QueryBuilder<Protocol, Protocol, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Protocol, Protocol, QDistinct> distinctByProgressPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'progressPercent');
    });
  }

  QueryBuilder<Protocol, Protocol, QDistinct> distinctBySuccessfulWeeks() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'successfulWeeks');
    });
  }

  QueryBuilder<Protocol, Protocol, QDistinct> distinctByTotalCommits() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalCommits');
    });
  }

  QueryBuilder<Protocol, Protocol, QDistinct> distinctByWeeklyTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weeklyTarget');
    });
  }
}

extension ProtocolQueryProperty
    on QueryBuilder<Protocol, Protocol, QQueryProperty> {
  QueryBuilder<Protocol, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Protocol, String, QQueryOperations> colorThemeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'colorTheme');
    });
  }

  QueryBuilder<Protocol, String?, QQueryOperations> conditionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'conditions');
    });
  }

  QueryBuilder<Protocol, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Protocol, String?, QQueryOperations> customColorHexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customColorHex');
    });
  }

  QueryBuilder<Protocol, int?, QQueryOperations> daysRemainingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'daysRemaining');
    });
  }

  QueryBuilder<Protocol, DateTime?, QQueryOperations> deadlineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deadline');
    });
  }

  QueryBuilder<Protocol, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Protocol, int, QQueryOperations> failedWeeksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'failedWeeks');
    });
  }

  QueryBuilder<Protocol, String?, QQueryOperations> failureRulesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'failureRules');
    });
  }

  QueryBuilder<Protocol, bool, QQueryOperations> isAchievedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAchieved');
    });
  }

  QueryBuilder<Protocol, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<Protocol, bool, QQueryOperations> isOverdueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isOverdue');
    });
  }

  QueryBuilder<Protocol, List<int>, QQueryOperations> linkedTaskIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'linkedTaskIds');
    });
  }

  QueryBuilder<Protocol, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Protocol, double, QQueryOperations> progressPercentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'progressPercent');
    });
  }

  QueryBuilder<Protocol, int, QQueryOperations> successfulWeeksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'successfulWeeks');
    });
  }

  QueryBuilder<Protocol, int, QQueryOperations> totalCommitsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalCommits');
    });
  }

  QueryBuilder<Protocol, int, QQueryOperations> weeklyTargetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weeklyTarget');
    });
  }
}
