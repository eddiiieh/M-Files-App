import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/class_property.dart';

class PropertyFormField extends StatefulWidget {
  final ClassProperty property;
  final Function(dynamic) onChanged;

  const PropertyFormField({
    super.key,
    required this.property,
    required this.onChanged,
  });

  @override
  State<PropertyFormField> createState() => _PropertyFormFieldState();
}

class _PropertyFormFieldState extends State<PropertyFormField> {
  late TextEditingController _controller;
  dynamic _selectedValue;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.property.defaultValue);
    if (widget.property.defaultValue != null) {
      widget.onChanged(widget.property.defaultValue);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildFormField() {
    // Automatic properties - show as disabled
    if (widget.property.isAutomatic) {
      return TextFormField(
        enabled: false,
        decoration: InputDecoration(
          labelText: widget.property.displayName,
          hintText: 'Automatic',
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      );
    }

    // Based on data type, render appropriate input
    switch (widget.property.dataType) {
      case 1: // Text
        return TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: widget.property.displayName,
            border: const OutlineInputBorder(),
            hintText: widget.property.isRequired ? 'Required' : 'Optional',
          ),
          validator: widget.property.isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return '${widget.property.displayName} is required';
                  }
                  return null;
                }
              : null,
          onChanged: (value) {
            widget.onChanged(value);
          },
        );

      case 2: // Number (Integer)
        return TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: widget.property.displayName,
            border: const OutlineInputBorder(),
            hintText: widget.property.isRequired ? 'Required' : 'Optional',
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: widget.property.isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return '${widget.property.displayName} is required';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                }
              : (value) {
                  if (value != null && value.isNotEmpty && int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
          onChanged: (value) {
            final intValue = int.tryParse(value);
            widget.onChanged(intValue);
          },
        );

      case 3: // Number (Decimal)
        return TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: widget.property.displayName,
            border: const OutlineInputBorder(),
            hintText: widget.property.isRequired ? 'Required' : 'Optional',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          validator: widget.property.isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return '${widget.property.displayName} is required';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid decimal number';
                  }
                  return null;
                }
              : (value) {
                  if (value != null && value.isNotEmpty && double.tryParse(value) == null) {
                    return 'Please enter a valid decimal number';
                  }
                  return null;
                },
          onChanged: (value) {
            final doubleValue = double.tryParse(value);
            widget.onChanged(doubleValue);
          },
        );

      case 5: // Date
        return TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: widget.property.displayName,
            border: const OutlineInputBorder(),
            hintText: widget.property.isRequired ? 'Required' : 'Optional',
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          readOnly: true,
          validator: widget.property.isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return '${widget.property.displayName} is required';
                  }
                  return null;
                }
              : null,
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              final formattedDate = date.toIso8601String().split('T')[0];
              _controller.text = formattedDate;
              widget.onChanged(formattedDate);
            }
          },
        );

      case 6: // Time
        return TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: widget.property.displayName,
            border: const OutlineInputBorder(),
            hintText: widget.property.isRequired ? 'Required' : 'Optional',
            suffixIcon: const Icon(Icons.access_time),
          ),
          readOnly: true,
          validator: widget.property.isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return '${widget.property.displayName} is required';
                  }
                  return null;
                }
              : null,
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (time != null) {
              final formattedTime = time.format(context);
              _controller.text = formattedTime;
              widget.onChanged(formattedTime);
            }
          },
        );

      case 7: // DateTime
        return TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: widget.property.displayName,
            border: const OutlineInputBorder(),
            hintText: widget.property.isRequired ? 'Required' : 'Optional',
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          readOnly: true,
          validator: widget.property.isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return '${widget.property.displayName} is required';
                  }
                  return null;
                }
              : null,
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (time != null) {
                final dateTime = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  time.hour,
                  time.minute,
                );
                final formattedDateTime = dateTime.toIso8601String();
                _controller.text = formattedDateTime;
                widget.onChanged(formattedDateTime);
              }
            }
          },
        );

      case 8: // Boolean
        return Row(
          children: [
            Expanded(
              child: Text(
                widget.property.displayName,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Switch(
              value: _selectedValue ?? false,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
                widget.onChanged(value);
              },
            ),
          ],
        );

      case 9: // Lookup (Dropdown)
        if (widget.property.valuelist != null && widget.property.valuelist!.isNotEmpty) {
          return DropdownButtonFormField<dynamic>(
            decoration: InputDecoration(
              labelText: widget.property.displayName,
              border: const OutlineInputBorder(),
              hintText: widget.property.isRequired ? 'Required' : 'Optional',
            ),
            value: _selectedValue,
            items: widget.property.valuelist!.map((propertyValue) {
              return DropdownMenuItem<dynamic>(
                value: propertyValue.value,
                child: Text(propertyValue.displayValue),
              );
            }).toList(),
            validator: widget.property.isRequired
                ? (value) {
                    if (value == null) {
                      return '${widget.property.displayName} is required';
                    }
                    return null;
                  }
                : null,
            onChanged: (value) {
              setState(() {
                _selectedValue = value;
              });
              widget.onChanged(value);
            },
          );
        }
        // Fall back to text field if no value list
        return TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: widget.property.displayName,
            border: const OutlineInputBorder(),
            hintText: widget.property.isRequired ? 'Required' : 'Optional',
          ),
          validator: widget.property.isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return '${widget.property.displayName} is required';
                  }
                  return null;
                }
              : null,
          onChanged: (value) {
            widget.onChanged(value);
          },
        );

      case 10: // Multi-select Lookup
        // For simplicity, implementing as a text field
        // In a real app, you'd want a proper multi-select widget
        return TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: '${widget.property.displayName} (Multi-select)',
            border: const OutlineInputBorder(),
            hintText: widget.property.isRequired ? 'Required' : 'Optional',
          ),
          validator: widget.property.isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return '${widget.property.displayName} is required';
                  }
                  return null;
                }
              : null,
          onChanged: (value) {
            widget.onChanged(value);
          },
        );

      case 13: // Multi-line Text
        return TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: widget.property.displayName,
            border: const OutlineInputBorder(),
            hintText: widget.property.isRequired ? 'Required' : 'Optional',
          ),
          maxLines: 3,
          validator: widget.property.isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return '${widget.property.displayName} is required';
                  }
                  return null;
                }
              : null,
          onChanged: (value) {
            widget.onChanged(value);
          },
        );

      default:
        // Default to text field for unknown types
        return TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: '${widget.property.displayName} (Type: ${widget.property.dataType})',
            border: const OutlineInputBorder(),
            hintText: widget.property.isRequired ? 'Required' : 'Optional',
          ),
          validator: widget.property.isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return '${widget.property.displayName} is required';
                  }
                  return null;
                }
              : null,
          onChanged: (value) {
            widget.onChanged(value);
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.property.displayName,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                if (widget.property.isRequired)
                  const Text(
                    '*',
                    style: TextStyle(color: Colors.red),
                  ),
                if (widget.property.isAutomatic)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'AUTO',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            _buildFormField(),
            if (widget.property.isRequired)
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  'This field is required',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}