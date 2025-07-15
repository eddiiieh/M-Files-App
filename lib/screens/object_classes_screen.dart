import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/mfiles_service.dart';
import '../models/vault_object_type.dart';
import '../models/object_class.dart';
import 'dynamic_form_screen.dart';

class ObjectClassesScreen extends StatefulWidget {
  final VaultObjectType objectType;

  const ObjectClassesScreen({
    super.key,
    required this.objectType,
  });

  @override
  State<ObjectClassesScreen> createState() => _ObjectClassesScreenState();
}

class _ObjectClassesScreenState extends State<ObjectClassesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MFilesService>().fetchObjectClasses(widget.objectType.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classes - ${widget.objectType.displayName}'),
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
                      service.fetchObjectClasses(widget.objectType.id);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (service.objectClasses.isEmpty) {
            return const Center(
              child: Text('No classes found for this object type'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: service.objectClasses.length,
            itemBuilder: (context, index) {
              final objectClass = service.objectClasses[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(objectClass.displayName),
                  subtitle: Text('ID: ${objectClass.id}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DynamicFormScreen(
                          objectType: widget.objectType,
                          objectClass: objectClass,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}