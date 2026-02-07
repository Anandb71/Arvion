// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_time_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetScreenTimeLogCollection on Isar {
  IsarCollection<ScreenTimeLog> get screenTimeLogs => this.collection();
}

const ScreenTimeLogSchema = CollectionSchema(
  name: r'ScreenTimeLog',
  id: -5230470071382222010,
  properties: {
    r'appName': PropertySchema(id: 0, name: r'appName', type: IsarType.string),
    r'dayIndex': PropertySchema(id: 1, name: r'dayIndex', type: IsarType.long),
    r'durationSeconds': PropertySchema(
      id: 2,
      name: r'durationSeconds',
      type: IsarType.long,
    ),
    r'hourOfDay': PropertySchema(
      id: 3,
      name: r'hourOfDay',
      type: IsarType.long,
    ),
    r'isActive': PropertySchema(id: 4, name: r'isActive', type: IsarType.bool),
    r'month': PropertySchema(id: 5, name: r'month', type: IsarType.long),
    r'timestamp': PropertySchema(
      id: 6,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'windowTitle': PropertySchema(
      id: 7,
      name: r'windowTitle',
      type: IsarType.string,
    ),
    r'year': PropertySchema(id: 8, name: r'year', type: IsarType.long),
  },
  estimateSize: _screenTimeLogEstimateSize,
  serialize: _screenTimeLogSerialize,
  deserialize: _screenTimeLogDeserialize,
  deserializeProp: _screenTimeLogDeserializeProp,
  idName: r'id',
  indexes: {
    r'timestamp': IndexSchema(
      id: 1852253767416892198,
      name: r'timestamp',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'timestamp',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'appName': IndexSchema(
      id: -8960787409846452456,
      name: r'appName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'appName',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'dayIndex': IndexSchema(
      id: 8120396275912827524,
      name: r'dayIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dayIndex',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _screenTimeLogGetId,
  getLinks: _screenTimeLogGetLinks,
  attach: _screenTimeLogAttach,
  version: '3.1.0+1',
);

int _screenTimeLogEstimateSize(
  ScreenTimeLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.appName.length * 3;
  bytesCount += 3 + object.windowTitle.length * 3;
  return bytesCount;
}

void _screenTimeLogSerialize(
  ScreenTimeLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.appName);
  writer.writeLong(offsets[1], object.dayIndex);
  writer.writeLong(offsets[2], object.durationSeconds);
  writer.writeLong(offsets[3], object.hourOfDay);
  writer.writeBool(offsets[4], object.isActive);
  writer.writeLong(offsets[5], object.month);
  writer.writeDateTime(offsets[6], object.timestamp);
  writer.writeString(offsets[7], object.windowTitle);
  writer.writeLong(offsets[8], object.year);
}

ScreenTimeLog _screenTimeLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ScreenTimeLog();
  object.appName = reader.readString(offsets[0]);
  object.durationSeconds = reader.readLong(offsets[2]);
  object.id = id;
  object.isActive = reader.readBool(offsets[4]);
  object.timestamp = reader.readDateTime(offsets[6]);
  object.windowTitle = reader.readString(offsets[7]);
  return object;
}

P _screenTimeLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _screenTimeLogGetId(ScreenTimeLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _screenTimeLogGetLinks(ScreenTimeLog object) {
  return [];
}

void _screenTimeLogAttach(
  IsarCollection<dynamic> col,
  Id id,
  ScreenTimeLog object,
) {
  object.id = id;
}

extension ScreenTimeLogQueryWhereSort
    on QueryBuilder<ScreenTimeLog, ScreenTimeLog, QWhere> {
  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhere> anyTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'timestamp'),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhere> anyDayIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dayIndex'),
      );
    });
  }
}

extension ScreenTimeLogQueryWhere
    on QueryBuilder<ScreenTimeLog, ScreenTimeLog, QWhereClause> {
  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhereClause>
  timestampEqualTo(DateTime timestamp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'timestamp', value: [timestamp]),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhereClause>
  timestampNotEqualTo(DateTime timestamp) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'timestamp',
                lower: [],
                upper: [timestamp],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'timestamp',
                lower: [timestamp],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'timestamp',
                lower: [timestamp],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'timestamp',
                lower: [],
                upper: [timestamp],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhereClause>
  timestampGreaterThan(DateTime timestamp, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'timestamp',
          lower: [timestamp],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhereClause>
  timestampLessThan(DateTime timestamp, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'timestamp',
          lower: [],
          upper: [timestamp],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhereClause>
  timestampBetween(
    DateTime lowerTimestamp,
    DateTime upperTimestamp, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'timestamp',
          lower: [lowerTimestamp],
          includeLower: includeLower,
          upper: [upperTimestamp],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhereClause> appNameEqualTo(
    String appName,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'appName', value: [appName]),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhereClause>
  appNameNotEqualTo(String appName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'appName',
                lower: [],
                upper: [appName],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'appName',
                lower: [appName],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'appName',
                lower: [appName],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'appName',
                lower: [],
                upper: [appName],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhereClause> dayIndexEqualTo(
    int dayIndex,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'dayIndex', value: [dayIndex]),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhereClause>
  dayIndexNotEqualTo(int dayIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dayIndex',
                lower: [],
                upper: [dayIndex],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dayIndex',
                lower: [dayIndex],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dayIndex',
                lower: [dayIndex],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dayIndex',
                lower: [],
                upper: [dayIndex],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhereClause>
  dayIndexGreaterThan(int dayIndex, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'dayIndex',
          lower: [dayIndex],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhereClause>
  dayIndexLessThan(int dayIndex, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'dayIndex',
          lower: [],
          upper: [dayIndex],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterWhereClause> dayIndexBetween(
    int lowerDayIndex,
    int upperDayIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'dayIndex',
          lower: [lowerDayIndex],
          includeLower: includeLower,
          upper: [upperDayIndex],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ScreenTimeLogQueryFilter
    on QueryBuilder<ScreenTimeLog, ScreenTimeLog, QFilterCondition> {
  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  appNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'appName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  appNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'appName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  appNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'appName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  appNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'appName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  appNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'appName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  appNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'appName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  appNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'appName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  appNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'appName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  appNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'appName', value: ''),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  appNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'appName', value: ''),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  dayIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dayIndex', value: value),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  dayIndexGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dayIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  dayIndexLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dayIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  dayIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dayIndex',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  durationSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'durationSeconds', value: value),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  durationSecondsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'durationSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  durationSecondsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'durationSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  durationSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'durationSeconds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  hourOfDayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hourOfDay', value: value),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  hourOfDayGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'hourOfDay',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  hourOfDayLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'hourOfDay',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  hourOfDayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'hourOfDay',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isActive', value: value),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  monthEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'month', value: value),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  monthGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'month',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  monthLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'month',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  monthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'month',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timestamp', value: value),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  timestampGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timestamp',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  timestampLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timestamp',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timestamp',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  windowTitleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'windowTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  windowTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'windowTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  windowTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'windowTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  windowTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'windowTitle',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  windowTitleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'windowTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  windowTitleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'windowTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  windowTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'windowTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  windowTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'windowTitle',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  windowTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'windowTitle', value: ''),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  windowTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'windowTitle', value: ''),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition> yearEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'year', value: value),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  yearGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'year',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition>
  yearLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'year',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterFilterCondition> yearBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'year',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ScreenTimeLogQueryObject
    on QueryBuilder<ScreenTimeLog, ScreenTimeLog, QFilterCondition> {}

extension ScreenTimeLogQueryLinks
    on QueryBuilder<ScreenTimeLog, ScreenTimeLog, QFilterCondition> {}

extension ScreenTimeLogQuerySortBy
    on QueryBuilder<ScreenTimeLog, ScreenTimeLog, QSortBy> {
  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> sortByAppName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appName', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> sortByAppNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appName', Sort.desc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> sortByDayIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayIndex', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy>
  sortByDayIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayIndex', Sort.desc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy>
  sortByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy>
  sortByDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.desc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> sortByHourOfDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hourOfDay', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy>
  sortByHourOfDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hourOfDay', Sort.desc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy>
  sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> sortByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> sortByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy>
  sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> sortByWindowTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windowTitle', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy>
  sortByWindowTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windowTitle', Sort.desc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> sortByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> sortByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension ScreenTimeLogQuerySortThenBy
    on QueryBuilder<ScreenTimeLog, ScreenTimeLog, QSortThenBy> {
  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> thenByAppName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appName', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> thenByAppNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appName', Sort.desc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> thenByDayIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayIndex', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy>
  thenByDayIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayIndex', Sort.desc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy>
  thenByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy>
  thenByDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.desc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> thenByHourOfDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hourOfDay', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy>
  thenByHourOfDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hourOfDay', Sort.desc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy>
  thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> thenByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> thenByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy>
  thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> thenByWindowTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windowTitle', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy>
  thenByWindowTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windowTitle', Sort.desc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> thenByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QAfterSortBy> thenByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension ScreenTimeLogQueryWhereDistinct
    on QueryBuilder<ScreenTimeLog, ScreenTimeLog, QDistinct> {
  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QDistinct> distinctByAppName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QDistinct> distinctByDayIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayIndex');
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QDistinct>
  distinctByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationSeconds');
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QDistinct> distinctByHourOfDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hourOfDay');
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QDistinct> distinctByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'month');
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QDistinct> distinctByWindowTitle({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'windowTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ScreenTimeLog, ScreenTimeLog, QDistinct> distinctByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'year');
    });
  }
}

extension ScreenTimeLogQueryProperty
    on QueryBuilder<ScreenTimeLog, ScreenTimeLog, QQueryProperty> {
  QueryBuilder<ScreenTimeLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ScreenTimeLog, String, QQueryOperations> appNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appName');
    });
  }

  QueryBuilder<ScreenTimeLog, int, QQueryOperations> dayIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayIndex');
    });
  }

  QueryBuilder<ScreenTimeLog, int, QQueryOperations> durationSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationSeconds');
    });
  }

  QueryBuilder<ScreenTimeLog, int, QQueryOperations> hourOfDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hourOfDay');
    });
  }

  QueryBuilder<ScreenTimeLog, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<ScreenTimeLog, int, QQueryOperations> monthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'month');
    });
  }

  QueryBuilder<ScreenTimeLog, DateTime, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<ScreenTimeLog, String, QQueryOperations> windowTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'windowTitle');
    });
  }

  QueryBuilder<ScreenTimeLog, int, QQueryOperations> yearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'year');
    });
  }
}
