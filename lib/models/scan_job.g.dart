// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_job.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetScanJobCollection on Isar {
  IsarCollection<ScanJob> get scanJobs => this.collection();
}

const ScanJobSchema = CollectionSchema(
  name: r'ScanJob',
  id: -7190018832374939473,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'idempotencyKey': PropertySchema(
      id: 1,
      name: r'idempotencyKey',
      type: IsarType.string,
    ),
    r'imagePath': PropertySchema(
      id: 2,
      name: r'imagePath',
      type: IsarType.string,
    ),
    r'jobId': PropertySchema(
      id: 3,
      name: r'jobId',
      type: IsarType.string,
    ),
    r'lastAttemptAt': PropertySchema(
      id: 4,
      name: r'lastAttemptAt',
      type: IsarType.dateTime,
    ),
    r'lastError': PropertySchema(
      id: 5,
      name: r'lastError',
      type: IsarType.string,
    ),
    r'retryCount': PropertySchema(
      id: 6,
      name: r'retryCount',
      type: IsarType.long,
    ),
    r'serverBelegId': PropertySchema(
      id: 7,
      name: r'serverBelegId',
      type: IsarType.string,
    ),
    r'serverPayloadJson': PropertySchema(
      id: 8,
      name: r'serverPayloadJson',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 9,
      name: r'status',
      type: IsarType.byte,
      enumMap: _ScanJobstatusEnumValueMap,
    ),
    r'missingJson': PropertySchema(
      id: 10,
      name: r'missingJson',
      type: IsarType.string,
    ),
    r'serverMessage': PropertySchema(
      id: 11,
      name: r'serverMessage',
      type: IsarType.string,
    ),
    r'serverStatus': PropertySchema(
      id: 12,
      name: r'serverStatus',
      type: IsarType.string,
    )
  },
  estimateSize: _scanJobEstimateSize,
  serialize: _scanJobSerialize,
  deserialize: _scanJobDeserialize,
  deserializeProp: _scanJobDeserializeProp,
  idName: r'id',
  indexes: {
    r'jobId': IndexSchema(
      id: 7916160552736803877,
      name: r'jobId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'jobId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'idempotencyKey': IndexSchema(
      id: 6522471565226449816,
      name: r'idempotencyKey',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'idempotencyKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _scanJobGetId,
  getLinks: _scanJobGetLinks,
  attach: _scanJobAttach,
  version: '3.1.0+1',
);

int _scanJobEstimateSize(
  ScanJob object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.idempotencyKey.length * 3;
  bytesCount += 3 + object.imagePath.length * 3;
  bytesCount += 3 + object.jobId.length * 3;
  {
    final value = object.lastError;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.serverBelegId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.serverPayloadJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.missingJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.serverMessage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.serverStatus;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _scanJobSerialize(
  ScanJob object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.idempotencyKey);
  writer.writeString(offsets[2], object.imagePath);
  writer.writeString(offsets[3], object.jobId);
  writer.writeDateTime(offsets[4], object.lastAttemptAt);
  writer.writeString(offsets[5], object.lastError);
  writer.writeLong(offsets[6], object.retryCount);
  writer.writeString(offsets[7], object.serverBelegId);
  writer.writeString(offsets[8], object.serverPayloadJson);
  writer.writeByte(offsets[9], object.status.index);
  writer.writeString(offsets[10], object.missingJson);
  writer.writeString(offsets[11], object.serverMessage);
  writer.writeString(offsets[12], object.serverStatus);
}

ScanJob _scanJobDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ScanJob();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.id = id;
  object.idempotencyKey = reader.readString(offsets[1]);
  object.imagePath = reader.readString(offsets[2]);
  object.jobId = reader.readString(offsets[3]);
  object.lastAttemptAt = reader.readDateTimeOrNull(offsets[4]);
  object.lastError = reader.readStringOrNull(offsets[5]);
  object.retryCount = reader.readLong(offsets[6]);
  object.serverBelegId = reader.readStringOrNull(offsets[7]);
  object.serverPayloadJson = reader.readStringOrNull(offsets[8]);
  object.status =
      _ScanJobstatusValueEnumMap[reader.readByteOrNull(offsets[9])] ??
          ScanJobStatus.pending;
  object.missingJson = reader.readStringOrNull(offsets[10]);
  object.serverMessage = reader.readStringOrNull(offsets[11]);
  object.serverStatus = reader.readStringOrNull(offsets[12]);
  return object;
}

P _scanJobDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (_ScanJobstatusValueEnumMap[reader.readByteOrNull(offset)] ??
          ScanJobStatus.pending) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ScanJobstatusEnumValueMap = {
  'pending': 0,
  'sending': 1,
  'needsFix': 2,
  'done': 3,
  'failed': 4,
};
const _ScanJobstatusValueEnumMap = {
  0: ScanJobStatus.pending,
  1: ScanJobStatus.sending,
  2: ScanJobStatus.needsFix,
  3: ScanJobStatus.done,
  4: ScanJobStatus.failed,
};

Id _scanJobGetId(ScanJob object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _scanJobGetLinks(ScanJob object) {
  return [];
}

void _scanJobAttach(IsarCollection<dynamic> col, Id id, ScanJob object) {
  object.id = id;
}

extension ScanJobByIndex on IsarCollection<ScanJob> {
  Future<ScanJob?> getByJobId(String jobId) {
    return getByIndex(r'jobId', [jobId]);
  }

  ScanJob? getByJobIdSync(String jobId) {
    return getByIndexSync(r'jobId', [jobId]);
  }

  Future<bool> deleteByJobId(String jobId) {
    return deleteByIndex(r'jobId', [jobId]);
  }

  bool deleteByJobIdSync(String jobId) {
    return deleteByIndexSync(r'jobId', [jobId]);
  }

  Future<List<ScanJob?>> getAllByJobId(List<String> jobIdValues) {
    final values = jobIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'jobId', values);
  }

  List<ScanJob?> getAllByJobIdSync(List<String> jobIdValues) {
    final values = jobIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'jobId', values);
  }

  Future<int> deleteAllByJobId(List<String> jobIdValues) {
    final values = jobIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'jobId', values);
  }

  int deleteAllByJobIdSync(List<String> jobIdValues) {
    final values = jobIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'jobId', values);
  }

  Future<Id> putByJobId(ScanJob object) {
    return putByIndex(r'jobId', object);
  }

  Id putByJobIdSync(ScanJob object, {bool saveLinks = true}) {
    return putByIndexSync(r'jobId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByJobId(List<ScanJob> objects) {
    return putAllByIndex(r'jobId', objects);
  }

  List<Id> putAllByJobIdSync(List<ScanJob> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'jobId', objects, saveLinks: saveLinks);
  }

  Future<ScanJob?> getByIdempotencyKey(String idempotencyKey) {
    return getByIndex(r'idempotencyKey', [idempotencyKey]);
  }

  ScanJob? getByIdempotencyKeySync(String idempotencyKey) {
    return getByIndexSync(r'idempotencyKey', [idempotencyKey]);
  }

  Future<bool> deleteByIdempotencyKey(String idempotencyKey) {
    return deleteByIndex(r'idempotencyKey', [idempotencyKey]);
  }

  bool deleteByIdempotencyKeySync(String idempotencyKey) {
    return deleteByIndexSync(r'idempotencyKey', [idempotencyKey]);
  }

  Future<List<ScanJob?>> getAllByIdempotencyKey(
      List<String> idempotencyKeyValues) {
    final values = idempotencyKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'idempotencyKey', values);
  }

  List<ScanJob?> getAllByIdempotencyKeySync(List<String> idempotencyKeyValues) {
    final values = idempotencyKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'idempotencyKey', values);
  }

  Future<int> deleteAllByIdempotencyKey(List<String> idempotencyKeyValues) {
    final values = idempotencyKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'idempotencyKey', values);
  }

  int deleteAllByIdempotencyKeySync(List<String> idempotencyKeyValues) {
    final values = idempotencyKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'idempotencyKey', values);
  }

  Future<Id> putByIdempotencyKey(ScanJob object) {
    return putByIndex(r'idempotencyKey', object);
  }

  Id putByIdempotencyKeySync(ScanJob object, {bool saveLinks = true}) {
    return putByIndexSync(r'idempotencyKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByIdempotencyKey(List<ScanJob> objects) {
    return putAllByIndex(r'idempotencyKey', objects);
  }

  List<Id> putAllByIdempotencyKeySync(List<ScanJob> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'idempotencyKey', objects, saveLinks: saveLinks);
  }
}

extension ScanJobQueryWhereSort on QueryBuilder<ScanJob, ScanJob, QWhere> {
  QueryBuilder<ScanJob, ScanJob, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ScanJobQueryWhere on QueryBuilder<ScanJob, ScanJob, QWhereClause> {
  QueryBuilder<ScanJob, ScanJob, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<ScanJob, ScanJob, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterWhereClause> idBetween(
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

  QueryBuilder<ScanJob, ScanJob, QAfterWhereClause> jobIdEqualTo(String jobId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'jobId',
        value: [jobId],
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterWhereClause> jobIdNotEqualTo(
      String jobId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'jobId',
              lower: [],
              upper: [jobId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'jobId',
              lower: [jobId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'jobId',
              lower: [jobId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'jobId',
              lower: [],
              upper: [jobId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterWhereClause> idempotencyKeyEqualTo(
      String idempotencyKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'idempotencyKey',
        value: [idempotencyKey],
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterWhereClause> idempotencyKeyNotEqualTo(
      String idempotencyKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'idempotencyKey',
              lower: [],
              upper: [idempotencyKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'idempotencyKey',
              lower: [idempotencyKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'idempotencyKey',
              lower: [idempotencyKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'idempotencyKey',
              lower: [],
              upper: [idempotencyKey],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ScanJobQueryFilter
    on QueryBuilder<ScanJob, ScanJob, QFilterCondition> {
  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> idempotencyKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idempotencyKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      idempotencyKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idempotencyKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> idempotencyKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idempotencyKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> idempotencyKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idempotencyKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      idempotencyKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'idempotencyKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> idempotencyKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'idempotencyKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> idempotencyKeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'idempotencyKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> idempotencyKeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'idempotencyKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      idempotencyKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idempotencyKey',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      idempotencyKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'idempotencyKey',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> imagePathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> imagePathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> imagePathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> imagePathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> imagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> imagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> imagePathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> imagePathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> imagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> imagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> jobIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jobId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> jobIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jobId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> jobIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jobId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> jobIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jobId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> jobIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'jobId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> jobIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'jobId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> jobIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'jobId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> jobIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'jobId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> jobIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jobId',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> jobIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'jobId',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> lastAttemptAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastAttemptAt',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      lastAttemptAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastAttemptAt',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> lastAttemptAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastAttemptAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      lastAttemptAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastAttemptAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> lastAttemptAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastAttemptAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> lastAttemptAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastAttemptAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> lastErrorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastError',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> lastErrorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastError',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> lastErrorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> lastErrorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> lastErrorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> lastErrorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastError',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> lastErrorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> lastErrorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> lastErrorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> lastErrorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastError',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> lastErrorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastError',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> lastErrorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastError',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> retryCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'retryCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> retryCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'retryCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> retryCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'retryCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> retryCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'retryCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverBelegIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'serverBelegId',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverBelegIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'serverBelegId',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverBelegIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverBelegId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverBelegIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serverBelegId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverBelegIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serverBelegId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverBelegIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serverBelegId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverBelegIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'serverBelegId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverBelegIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'serverBelegId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverBelegIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'serverBelegId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverBelegIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'serverBelegId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverBelegIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverBelegId',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverBelegIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'serverBelegId',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverPayloadJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'serverPayloadJson',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverPayloadJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'serverPayloadJson',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverPayloadJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverPayloadJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverPayloadJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serverPayloadJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverPayloadJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serverPayloadJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverPayloadJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serverPayloadJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverPayloadJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'serverPayloadJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverPayloadJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'serverPayloadJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverPayloadJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'serverPayloadJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverPayloadJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'serverPayloadJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverPayloadJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverPayloadJson',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverPayloadJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'serverPayloadJson',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> missingJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'missingJson',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      missingJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'missingJson',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> missingJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'missingJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> missingJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'missingJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> missingJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'missingJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> missingJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'missingJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> missingJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'missingJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> missingJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'missingJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      missingJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'missingJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> missingJsonMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'missingJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> missingJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'missingJson',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      missingJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'missingJson',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'serverMessage',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'serverMessage',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverMessageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverMessageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serverMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverMessageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serverMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverMessageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serverMessage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverMessageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'serverMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverMessageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'serverMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'serverMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverMessageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'serverMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'serverMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverStatusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'serverStatus',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverStatusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'serverStatus',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverStatusEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverStatusGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serverStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverStatusLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serverStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverStatusBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serverStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'serverStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'serverStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'serverStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> serverStatusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'serverStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition>
      serverStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'serverStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> statusEqualTo(
      ScanJobStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> statusGreaterThan(
    ScanJobStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> statusLessThan(
    ScanJobStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterFilterCondition> statusBetween(
    ScanJobStatus lower,
    ScanJobStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ScanJobQueryObject
    on QueryBuilder<ScanJob, ScanJob, QFilterCondition> {}

extension ScanJobQueryLinks
    on QueryBuilder<ScanJob, ScanJob, QFilterCondition> {}

extension ScanJobQuerySortBy on QueryBuilder<ScanJob, ScanJob, QSortBy> {
  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByIdempotencyKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idempotencyKey', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByIdempotencyKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idempotencyKey', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByJobId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobId', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByJobIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobId', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByLastAttemptAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByLastAttemptAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByLastError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastError', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByLastErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastError', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByRetryCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retryCount', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByRetryCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retryCount', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByServerBelegId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverBelegId', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByServerBelegIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverBelegId', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByServerPayloadJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverPayloadJson', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByServerPayloadJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverPayloadJson', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension ScanJobQuerySortThenBy
    on QueryBuilder<ScanJob, ScanJob, QSortThenBy> {
  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByIdempotencyKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idempotencyKey', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByIdempotencyKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idempotencyKey', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByJobId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobId', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByJobIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobId', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByLastAttemptAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByLastAttemptAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByLastError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastError', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByLastErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastError', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByRetryCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retryCount', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByRetryCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retryCount', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByServerBelegId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverBelegId', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByServerBelegIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverBelegId', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByServerPayloadJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverPayloadJson', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByServerPayloadJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverPayloadJson', Sort.desc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension ScanJobQueryWhereDistinct
    on QueryBuilder<ScanJob, ScanJob, QDistinct> {
  QueryBuilder<ScanJob, ScanJob, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ScanJob, ScanJob, QDistinct> distinctByIdempotencyKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idempotencyKey',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QDistinct> distinctByImagePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QDistinct> distinctByJobId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jobId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QDistinct> distinctByLastAttemptAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastAttemptAt');
    });
  }

  QueryBuilder<ScanJob, ScanJob, QDistinct> distinctByLastError(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastError', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QDistinct> distinctByRetryCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'retryCount');
    });
  }

  QueryBuilder<ScanJob, ScanJob, QDistinct> distinctByServerBelegId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'serverBelegId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QDistinct> distinctByServerPayloadJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'serverPayloadJson',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ScanJob, ScanJob, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }
}

extension ScanJobQueryProperty
    on QueryBuilder<ScanJob, ScanJob, QQueryProperty> {
  QueryBuilder<ScanJob, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ScanJob, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ScanJob, String, QQueryOperations> idempotencyKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idempotencyKey');
    });
  }

  QueryBuilder<ScanJob, String, QQueryOperations> imagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagePath');
    });
  }

  QueryBuilder<ScanJob, String, QQueryOperations> jobIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jobId');
    });
  }

  QueryBuilder<ScanJob, DateTime?, QQueryOperations> lastAttemptAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastAttemptAt');
    });
  }

  QueryBuilder<ScanJob, String?, QQueryOperations> lastErrorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastError');
    });
  }

  QueryBuilder<ScanJob, int, QQueryOperations> retryCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'retryCount');
    });
  }

  QueryBuilder<ScanJob, String?, QQueryOperations> serverBelegIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serverBelegId');
    });
  }

  QueryBuilder<ScanJob, String?, QQueryOperations> serverPayloadJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serverPayloadJson');
    });
  }

  QueryBuilder<ScanJob, ScanJobStatus, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
