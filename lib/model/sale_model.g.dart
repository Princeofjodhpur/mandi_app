// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSaleModelCollection on Isar {
  IsarCollection<SaleModel> get saleModels => this.collection();
}

const SaleModelSchema = CollectionSchema(
  name: r'SaleModel',
  id: 8410161235942925352,
  properties: {
    r'avgWeight': PropertySchema(
      id: 0,
      name: r'avgWeight',
      type: IsarType.double,
    ),
    r'basicAmt': PropertySchema(
      id: 1,
      name: r'basicAmt',
      type: IsarType.double,
    ),
    r'bikriAmt': PropertySchema(
      id: 2,
      name: r'bikriAmt',
      type: IsarType.double,
    ),
    r'creationDate': PropertySchema(
      id: 3,
      name: r'creationDate',
      type: IsarType.dateTime,
    ),
    r'customerName': PropertySchema(
      id: 4,
      name: r'customerName',
      type: IsarType.string,
    ),
    r'customerNug': PropertySchema(
      id: 5,
      name: r'customerNug',
      type: IsarType.long,
    ),
    r'customerRate': PropertySchema(
      id: 6,
      name: r'customerRate',
      type: IsarType.double,
    ),
    r'cut': PropertySchema(
      id: 7,
      name: r'cut',
      type: IsarType.string,
    ),
    r'farmerName': PropertySchema(
      id: 8,
      name: r'farmerName',
      type: IsarType.string,
    ),
    r'frightRate': PropertySchema(
      id: 9,
      name: r'frightRate',
      type: IsarType.double,
    ),
    r'grossWeight': PropertySchema(
      id: 10,
      name: r'grossWeight',
      type: IsarType.double,
    ),
    r'itemName': PropertySchema(
      id: 11,
      name: r'itemName',
      type: IsarType.string,
    ),
    r'labourRate': PropertySchema(
      id: 12,
      name: r'labourRate',
      type: IsarType.double,
    ),
    r'lot': PropertySchema(
      id: 13,
      name: r'lot',
      type: IsarType.double,
    ),
    r'netWeight': PropertySchema(
      id: 14,
      name: r'netWeight',
      type: IsarType.double,
    ),
    r'otherCharges': PropertySchema(
      id: 15,
      name: r'otherCharges',
      type: IsarType.double,
    ),
    r'sellerNug': PropertySchema(
      id: 16,
      name: r'sellerNug',
      type: IsarType.long,
    ),
    r'sellerRate': PropertySchema(
      id: 17,
      name: r'sellerRate',
      type: IsarType.double,
    ),
    r'srNo': PropertySchema(
      id: 18,
      name: r'srNo',
      type: IsarType.long,
    ),
    r'supplierName': PropertySchema(
      id: 19,
      name: r'supplierName',
      type: IsarType.string,
    ),
    r'vclNo': PropertySchema(
      id: 20,
      name: r'vclNo',
      type: IsarType.string,
    ),
    r'w': PropertySchema(
      id: 21,
      name: r'w',
      type: IsarType.longList,
    )
  },
  estimateSize: _saleModelEstimateSize,
  serialize: _saleModelSerialize,
  deserialize: _saleModelDeserialize,
  deserializeProp: _saleModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _saleModelGetId,
  getLinks: _saleModelGetLinks,
  attach: _saleModelAttach,
  version: '3.1.0+1',
);

int _saleModelEstimateSize(
  SaleModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.customerName.length * 3;
  bytesCount += 3 + object.cut.length * 3;
  bytesCount += 3 + object.farmerName.length * 3;
  bytesCount += 3 + object.itemName.length * 3;
  bytesCount += 3 + object.supplierName.length * 3;
  bytesCount += 3 + object.vclNo.length * 3;
  bytesCount += 3 + object.w.length * 8;
  return bytesCount;
}

void _saleModelSerialize(
  SaleModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.avgWeight);
  writer.writeDouble(offsets[1], object.basicAmt);
  writer.writeDouble(offsets[2], object.bikriAmt);
  writer.writeDateTime(offsets[3], object.creationDate);
  writer.writeString(offsets[4], object.customerName);
  writer.writeLong(offsets[5], object.customerNug);
  writer.writeDouble(offsets[6], object.customerRate);
  writer.writeString(offsets[7], object.cut);
  writer.writeString(offsets[8], object.farmerName);
  writer.writeDouble(offsets[9], object.frightRate);
  writer.writeDouble(offsets[10], object.grossWeight);
  writer.writeString(offsets[11], object.itemName);
  writer.writeDouble(offsets[12], object.labourRate);
  writer.writeDouble(offsets[13], object.lot);
  writer.writeDouble(offsets[14], object.netWeight);
  writer.writeDouble(offsets[15], object.otherCharges);
  writer.writeLong(offsets[16], object.sellerNug);
  writer.writeDouble(offsets[17], object.sellerRate);
  writer.writeLong(offsets[18], object.srNo);
  writer.writeString(offsets[19], object.supplierName);
  writer.writeString(offsets[20], object.vclNo);
  writer.writeLongList(offsets[21], object.w);
}

SaleModel _saleModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SaleModel();
  object.avgWeight = reader.readDouble(offsets[0]);
  object.basicAmt = reader.readDouble(offsets[1]);
  object.bikriAmt = reader.readDouble(offsets[2]);
  object.creationDate = reader.readDateTime(offsets[3]);
  object.customerName = reader.readString(offsets[4]);
  object.customerNug = reader.readLong(offsets[5]);
  object.customerRate = reader.readDouble(offsets[6]);
  object.cut = reader.readString(offsets[7]);
  object.farmerName = reader.readString(offsets[8]);
  object.frightRate = reader.readDouble(offsets[9]);
  object.grossWeight = reader.readDouble(offsets[10]);
  object.id = id;
  object.itemName = reader.readString(offsets[11]);
  object.labourRate = reader.readDouble(offsets[12]);
  object.lot = reader.readDouble(offsets[13]);
  object.netWeight = reader.readDouble(offsets[14]);
  object.otherCharges = reader.readDouble(offsets[15]);
  object.sellerNug = reader.readLong(offsets[16]);
  object.sellerRate = reader.readDouble(offsets[17]);
  object.srNo = reader.readLong(offsets[18]);
  object.supplierName = reader.readString(offsets[19]);
  object.vclNo = reader.readString(offsets[20]);
  object.w = reader.readLongList(offsets[21]) ?? [];
  return object;
}

P _saleModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readDouble(offset)) as P;
    case 13:
      return (reader.readDouble(offset)) as P;
    case 14:
      return (reader.readDouble(offset)) as P;
    case 15:
      return (reader.readDouble(offset)) as P;
    case 16:
      return (reader.readLong(offset)) as P;
    case 17:
      return (reader.readDouble(offset)) as P;
    case 18:
      return (reader.readLong(offset)) as P;
    case 19:
      return (reader.readString(offset)) as P;
    case 20:
      return (reader.readString(offset)) as P;
    case 21:
      return (reader.readLongList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _saleModelGetId(SaleModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _saleModelGetLinks(SaleModel object) {
  return [];
}

void _saleModelAttach(IsarCollection<dynamic> col, Id id, SaleModel object) {
  object.id = id;
}

extension SaleModelQueryWhereSort
    on QueryBuilder<SaleModel, SaleModel, QWhere> {
  QueryBuilder<SaleModel, SaleModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SaleModelQueryWhere
    on QueryBuilder<SaleModel, SaleModel, QWhereClause> {
  QueryBuilder<SaleModel, SaleModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<SaleModel, SaleModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterWhereClause> idBetween(
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
}

extension SaleModelQueryFilter
    on QueryBuilder<SaleModel, SaleModel, QFilterCondition> {
  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> avgWeightEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avgWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      avgWeightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avgWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> avgWeightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avgWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> avgWeightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avgWeight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> basicAmtEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'basicAmt',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> basicAmtGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'basicAmt',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> basicAmtLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'basicAmt',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> basicAmtBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'basicAmt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> bikriAmtEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bikriAmt',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> bikriAmtGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bikriAmt',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> bikriAmtLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bikriAmt',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> bikriAmtBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bikriAmt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> creationDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creationDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      creationDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creationDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      creationDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creationDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> creationDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creationDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> customerNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      customerNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      customerNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> customerNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customerName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      customerNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      customerNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      customerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> customerNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      customerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerName',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      customerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customerName',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> customerNugEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerNug',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      customerNugGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customerNug',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> customerNugLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customerNug',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> customerNugBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customerNug',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> customerRateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      customerRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customerRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      customerRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customerRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> customerRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customerRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> cutEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> cutGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> cutLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> cutBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cut',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> cutStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> cutEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> cutContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> cutMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cut',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> cutIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cut',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> cutIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cut',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> farmerNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'farmerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      farmerNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'farmerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> farmerNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'farmerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> farmerNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'farmerName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      farmerNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'farmerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> farmerNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'farmerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> farmerNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'farmerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> farmerNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'farmerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      farmerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'farmerName',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      farmerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'farmerName',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> frightRateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frightRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      frightRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frightRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> frightRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frightRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> frightRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frightRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> grossWeightEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grossWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      grossWeightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'grossWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> grossWeightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'grossWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> grossWeightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'grossWeight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> itemNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> itemNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'itemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> itemNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'itemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> itemNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'itemName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> itemNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'itemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> itemNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'itemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> itemNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'itemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> itemNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'itemName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> itemNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemName',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      itemNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'itemName',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> labourRateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'labourRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      labourRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'labourRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> labourRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'labourRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> labourRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'labourRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> lotEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lot',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> lotGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lot',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> lotLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lot',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> lotBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lot',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> netWeightEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'netWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      netWeightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'netWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> netWeightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'netWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> netWeightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'netWeight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> otherChargesEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otherCharges',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      otherChargesGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'otherCharges',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      otherChargesLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'otherCharges',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> otherChargesBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'otherCharges',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> sellerNugEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sellerNug',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      sellerNugGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sellerNug',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> sellerNugLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sellerNug',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> sellerNugBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sellerNug',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> sellerRateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sellerRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      sellerRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sellerRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> sellerRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sellerRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> sellerRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sellerRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> srNoEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'srNo',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> srNoGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'srNo',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> srNoLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'srNo',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> srNoBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'srNo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> supplierNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supplierName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      supplierNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'supplierName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      supplierNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'supplierName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> supplierNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'supplierName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      supplierNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'supplierName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      supplierNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'supplierName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      supplierNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'supplierName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> supplierNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'supplierName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      supplierNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supplierName',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      supplierNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'supplierName',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> vclNoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vclNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> vclNoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vclNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> vclNoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vclNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> vclNoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vclNo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> vclNoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vclNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> vclNoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vclNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> vclNoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vclNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> vclNoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vclNo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> vclNoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vclNo',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> vclNoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vclNo',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> wElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'w',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> wElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'w',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> wElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'w',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> wElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'w',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> wLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'w',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> wIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'w',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> wIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'w',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> wLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'w',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> wLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'w',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> wLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'w',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension SaleModelQueryObject
    on QueryBuilder<SaleModel, SaleModel, QFilterCondition> {}

extension SaleModelQueryLinks
    on QueryBuilder<SaleModel, SaleModel, QFilterCondition> {}

extension SaleModelQuerySortBy on QueryBuilder<SaleModel, SaleModel, QSortBy> {
  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByAvgWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgWeight', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByAvgWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgWeight', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByBasicAmt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basicAmt', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByBasicAmtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basicAmt', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByBikriAmt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bikriAmt', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByBikriAmtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bikriAmt', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByCreationDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creationDate', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByCreationDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creationDate', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByCustomerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByCustomerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByCustomerNug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerNug', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByCustomerNugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerNug', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByCustomerRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerRate', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByCustomerRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerRate', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByCut() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cut', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByCutDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cut', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByFarmerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'farmerName', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByFarmerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'farmerName', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByFrightRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frightRate', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByFrightRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frightRate', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByGrossWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grossWeight', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByGrossWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grossWeight', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByItemName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemName', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByItemNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemName', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByLabourRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'labourRate', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByLabourRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'labourRate', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByLot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lot', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByLotDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lot', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByNetWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'netWeight', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByNetWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'netWeight', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByOtherCharges() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otherCharges', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByOtherChargesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otherCharges', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortBySellerNug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerNug', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortBySellerNugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerNug', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortBySellerRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerRate', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortBySellerRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerRate', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortBySrNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'srNo', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortBySrNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'srNo', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortBySupplierName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supplierName', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortBySupplierNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supplierName', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByVclNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vclNo', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByVclNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vclNo', Sort.desc);
    });
  }
}

extension SaleModelQuerySortThenBy
    on QueryBuilder<SaleModel, SaleModel, QSortThenBy> {
  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByAvgWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgWeight', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByAvgWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgWeight', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByBasicAmt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basicAmt', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByBasicAmtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basicAmt', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByBikriAmt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bikriAmt', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByBikriAmtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bikriAmt', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByCreationDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creationDate', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByCreationDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creationDate', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByCustomerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByCustomerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByCustomerNug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerNug', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByCustomerNugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerNug', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByCustomerRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerRate', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByCustomerRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerRate', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByCut() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cut', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByCutDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cut', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByFarmerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'farmerName', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByFarmerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'farmerName', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByFrightRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frightRate', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByFrightRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frightRate', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByGrossWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grossWeight', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByGrossWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grossWeight', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByItemName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemName', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByItemNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemName', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByLabourRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'labourRate', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByLabourRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'labourRate', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByLot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lot', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByLotDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lot', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByNetWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'netWeight', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByNetWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'netWeight', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByOtherCharges() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otherCharges', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByOtherChargesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otherCharges', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenBySellerNug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerNug', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenBySellerNugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerNug', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenBySellerRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerRate', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenBySellerRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellerRate', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenBySrNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'srNo', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenBySrNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'srNo', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenBySupplierName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supplierName', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenBySupplierNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supplierName', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByVclNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vclNo', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByVclNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vclNo', Sort.desc);
    });
  }
}

extension SaleModelQueryWhereDistinct
    on QueryBuilder<SaleModel, SaleModel, QDistinct> {
  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByAvgWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avgWeight');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByBasicAmt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'basicAmt');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByBikriAmt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bikriAmt');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByCreationDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creationDate');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByCustomerName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByCustomerNug() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customerNug');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByCustomerRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customerRate');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByCut(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cut', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByFarmerName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'farmerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByFrightRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frightRate');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByGrossWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'grossWeight');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByItemName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itemName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByLabourRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'labourRate');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByLot() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lot');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByNetWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'netWeight');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByOtherCharges() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otherCharges');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctBySellerNug() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sellerNug');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctBySellerRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sellerRate');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctBySrNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'srNo');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctBySupplierName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supplierName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByVclNo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vclNo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByW() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'w');
    });
  }
}

extension SaleModelQueryProperty
    on QueryBuilder<SaleModel, SaleModel, QQueryProperty> {
  QueryBuilder<SaleModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SaleModel, double, QQueryOperations> avgWeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avgWeight');
    });
  }

  QueryBuilder<SaleModel, double, QQueryOperations> basicAmtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'basicAmt');
    });
  }

  QueryBuilder<SaleModel, double, QQueryOperations> bikriAmtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bikriAmt');
    });
  }

  QueryBuilder<SaleModel, DateTime, QQueryOperations> creationDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creationDate');
    });
  }

  QueryBuilder<SaleModel, String, QQueryOperations> customerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customerName');
    });
  }

  QueryBuilder<SaleModel, int, QQueryOperations> customerNugProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customerNug');
    });
  }

  QueryBuilder<SaleModel, double, QQueryOperations> customerRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customerRate');
    });
  }

  QueryBuilder<SaleModel, String, QQueryOperations> cutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cut');
    });
  }

  QueryBuilder<SaleModel, String, QQueryOperations> farmerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'farmerName');
    });
  }

  QueryBuilder<SaleModel, double, QQueryOperations> frightRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frightRate');
    });
  }

  QueryBuilder<SaleModel, double, QQueryOperations> grossWeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'grossWeight');
    });
  }

  QueryBuilder<SaleModel, String, QQueryOperations> itemNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemName');
    });
  }

  QueryBuilder<SaleModel, double, QQueryOperations> labourRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'labourRate');
    });
  }

  QueryBuilder<SaleModel, double, QQueryOperations> lotProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lot');
    });
  }

  QueryBuilder<SaleModel, double, QQueryOperations> netWeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'netWeight');
    });
  }

  QueryBuilder<SaleModel, double, QQueryOperations> otherChargesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otherCharges');
    });
  }

  QueryBuilder<SaleModel, int, QQueryOperations> sellerNugProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sellerNug');
    });
  }

  QueryBuilder<SaleModel, double, QQueryOperations> sellerRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sellerRate');
    });
  }

  QueryBuilder<SaleModel, int, QQueryOperations> srNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'srNo');
    });
  }

  QueryBuilder<SaleModel, String, QQueryOperations> supplierNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supplierName');
    });
  }

  QueryBuilder<SaleModel, String, QQueryOperations> vclNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vclNo');
    });
  }

  QueryBuilder<SaleModel, List<int>, QQueryOperations> wProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'w');
    });
  }
}
