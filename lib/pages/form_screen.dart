import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _validateOnlyLetters(String? value) {
    return (value == null || value.isEmpty)
        ? 'Este campo es requerido'
        : !RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)
            ? 'Solo letras son permitidas 😨'
            : null;
  }

  String? _validateAlphanumeric(String? value) {
    return (value == null || value.isEmpty)
        ? 'Este campo es requerido'
        : !RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)
            ? 'Solo caracteres alfanuméricos son permitidos 😨'
            : null;
  }

  String? _validateCardNumber(String? value) {
    return (value == null || value.isEmpty)
        ? 'Este campo es requerido'
        : !RegExp(r'^[0-9]+$').hasMatch(value)
            ? 'Solo números son permitidos'
            : value.length != 15
                ? 'Debe tener 15 dígitos 😨'
                : null;
  }

  String? _validateCVV(String? value) {
    return (value == null || value.isEmpty)
        ? 'Este campo es requerido'
        : !RegExp(r'^[0-9]+$').hasMatch(value)
            ? 'Solo números son permitidos'
            : value.length != 3
                ? 'Debe tener 3 dígitos 😨'
                : null;
  }

  String? _validateMonth(String? value) {
    final int? month = int.tryParse(value ?? '');
    return (value == null || value.isEmpty)
        ? 'Este campo es requerido'
        : month == null
            ? 'Solo números son permitidos'
            : month < 1 || month > 12
                ? 'El mes debe estar entre 1 y 12 😨'
                : null;
  }

  String? _validateYear(String? value) {
    final int? year = int.tryParse(value ?? '');
    final int currentYear = DateTime.now().year;
    return (value == null || value.isEmpty)
        ? 'Este campo es requerido'
        : year == null
            ? 'Solo números son permitidos'
            : year < currentYear
                ? 'El año no puede ser menor al actual 😨'
                : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Formulario de Tarjeta',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromARGB(255, 8, 26, 44),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nombre de la Persona',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: const Icon(Icons.person),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  validator: _validateOnlyLetters,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Apellidos',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.person_outline),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  validator: _validateOnlyLetters,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Dirección (Calle, Número y Cruzamientos)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.location_on),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  validator: _validateAlphanumeric,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Número de la Tarjeta',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.credit_card),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(15),
                  ],
                  validator: _validateCardNumber,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Mes de Vencimiento (MM)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                        validator: _validateMonth,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Año de Vencimiento (YYYY)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        validator: _validateYear,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Número de CVV',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  validator: _validateCVV,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 8, 26, 44),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Formulario válido 😺')),
                      );
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Guardar Datos',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
