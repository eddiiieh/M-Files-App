import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mfiles_app/screens/property_form_field.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../services/mfiles_service.dart';
import '../models/vault_object_type.dart';
import '../models/object_class.dart';
import '../models/object_creation_request.dart';

class DynamicFormScreen extends StatefulWidget {
  final VaultObjectType objectType;
  final ObjectClass objectClass;

  const DynamicFormScreen({
    super.key,
    required this.objectType,
    required this.objectClass,
  });

  @override
  State<DynamicFormScreen> createState() => _DynamicFormScreenState();
}

class _DynamicFormScreenState extends State<DynamicFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<int, dynamic> _formValues = {};
  File? _selectedFile;
  String? _selectedFileName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MFilesService>().fetchClassProperties(
            widget.objectType.id,
            widget.objectClass.id,
          );
    });
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _selectedFileName = result.files.single.name;
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final service = context.read<MFilesService>();
    
    // Check if required file is selected for document objects
    if (widget.objectType.isDocument && _selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a file for document objects'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String? uploadId;
    
    // Upload file if document object
    if (widget.objectType.isDocument && _selectedFile != null) {
      uploadId = await service.uploadFile(_selectedFile!);
      if (uploadId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to upload file'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    // Prepare property values
    final propertyValues = <PropertyValueRequest>[];
    for (final entry in _formValues.entries) {
      propertyValues.add(PropertyValueRequest(
        propertyId: entry.key,
        value: entry.value,
      ));
    }

    // Create object request
    final request = ObjectCreationRequest(
      objectTypeId: widget.objectType.id,
      classId: widget.objectClass.id,
      propertyValues: propertyValues,
      uploadId: uploadId,
    );

    // Submit the request
    final success = await service.createObject(request);
    
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Object created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create object: ${service.error}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create ${widget.objectClass.name}'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<MFilesService>(
        builder: (context, service, child) {
          if (service.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (service.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${service.error}',
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      service.clearError();
                      service.fetchClassProperties(
                        widget.objectType.id,
                        widget.objectClass.id,
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (service.classProperties.isEmpty) {
            return const Center(
              child: Text('No properties found for this class'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // File picker for document objects
                  if (widget.objectType.isDocument) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'File Upload',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _selectedFileName ?? 'No file selected',
                                    style: TextStyle(
                                      color: _selectedFileName != null
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: _pickFile,
                                  icon: const Icon(Icons.attach_file),
                                  label: const Text('Select File'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  
                  // Property form fields
                  ...service.classProperties
                      .where((property) => !property.isHidden)
                      .map((property) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: PropertyFormField(
                              property: property,
                              onChanged: (value) {
                                setState(() {
                                  _formValues[property.id] = value;
                                });
                              },
                            ),
                          )),
                  
                  const SizedBox(height: 24),
                  
                  // Submit button
                  ElevatedButton(
                    onPressed: service.isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: service.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Create Object'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}