import 'package:intl/intl.dart';
// Updated ObjectCreationRequest to include Name property
class ObjectCreationRequest {
  final int objectTypeId;
  final int classId;
  final List<PropertyValueRequest> propertyValues;
  final String? uploadId;

  ObjectCreationRequest({
    required this.objectTypeId,
    required this.classId,
    required this.propertyValues,
    this.uploadId,
  });

  Map<String, dynamic> toJson() => {
    'ObjectTypeId': objectTypeId,
    'ClassId': classId,
    'PropertyValues': propertyValues.map((value) => value.toJson()).toList(),
    if (uploadId != null) 'UploadId': uploadId,
  };
}

// Updated PropertyValueRequest with better date handling
class PropertyValueRequest {
  final int propertyId;
  final dynamic value;
  final int dataType;

  PropertyValueRequest({
    required this.propertyId,
    required this.value,
    required this.dataType,
  });

  Map<String, dynamic> toJson() {
    final hasValue = value != null && value != '';
    
    return {
      'PropertyDef': propertyId,
      'TypedValue': {
        'DataType': dataType,
        'Value': _formatValue(value, dataType),
        'HasValue': hasValue,
      }
    };
  }

  dynamic _formatValue(dynamic value, int dataType) {
    if (value == null) return null;
    
    switch (dataType) {
      case 1: // MFDatatypeText
        return value.toString();
      
      case 2: // MFDatatypeInteger
        return value is int ? value : int.tryParse(value.toString()) ?? 0;
      
      case 5: // MFDatatypeDate
        if (value is DateTime) {
        return DateFormat('yyyy-MM-dd').format(value);
      } else if (value is String) {
        try {
          final parsed = DateFormat('dd/MM/yyyy').parseStrict(value);
          return DateFormat('yyyy-MM-dd').format(parsed);
        } catch (_) {
          return value;
        }
      }
        return value;
      
      case 7: // MFDatatypeTimestamp
        if (value is DateTime) {
        return DateFormat("yyyy-MM-ddTHH:mm:ss").format(value);
      } else if (value is String) {
        try {
          final parsed = DateFormat('dd/MM/yyyy HH:mm').parseStrict(value);
          return DateFormat("yyyy-MM-ddTHH:mm:ss").format(parsed);
        } catch (_) {
          return value;
        }
      }
        return value;
      
      default:
        return value;
    }
  }
}

// FIXED: Method to create student object with proper Name property
ObjectCreationRequest createStudentObject({
  required String studentName,
  required int admissionNumber,
  required DateTime dateOfAdmission,
  required String additionalDescriptor,
  required DateTime admissionTime,
}) {
  return ObjectCreationRequest(
    objectTypeId: 137,
    classId: 43,
    propertyValues: [
      // 🔥 CRITICAL: Add the Object Name property (PropertyDef 0)
      PropertyValueRequest(
        propertyId: 0, // Object Name - THIS WAS MISSING!
        value: studentName, // Use student name as object name
        dataType: 1, // Text
      ),
      
      // Your existing properties
      PropertyValueRequest(
        propertyId: 1121, // Student Name
        value: studentName,
        dataType: 1, // MFDatatypeText
      ),
      PropertyValueRequest(
        propertyId: 1122, // Admission Number
        value: admissionNumber,
        dataType: 2, // MFDatatypeInteger
      ),
      PropertyValueRequest(
        propertyId: 1130, // Date of Admission
        value: dateOfAdmission,
        dataType: 5, // MFDatatypeDate
      ),
      PropertyValueRequest(
        propertyId: 1125, // Additional Descriptor
        value: additionalDescriptor,
        dataType: 1, // MFDatatypeText
      ),
      PropertyValueRequest(
        propertyId: 1131, // Admission Time
        value: admissionTime,
        dataType: 7, // MFDatatypeTimestamp
      ),
    ],
  );
}

// Usage example
void exampleUsage() {
  final studentRequest = createStudentObject(
    studentName: "Alex Eddy",
    admissionNumber: 8009,
    dateOfAdmission: DateTime(2025, 7, 17),
    additionalDescriptor: "Came with all the required items.",
    admissionTime: DateTime(2025, 7, 17, 11, 37),
  );

  // This will now include PropertyDef 0 (Object Name)
  final json = studentRequest.toJson();
  print('Fixed payload: ${json.toString()}');
  
  // Expected output should include:
  // PropertyDef 0: Object Name
  // PropertyDef 1121: Student Name (required)
  // PropertyDef 1122: Admission Number
  // PropertyDef 1130: Date of Admission
  // PropertyDef 1125: Additional Descriptor
  // PropertyDef 1131: Admission Time
}