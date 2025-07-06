import 'package:flutter/material.dart';

class PriceSlider extends StatefulWidget {
  final double min;
  final double max;
  final RangeValues currentRangeValues;
  final ValueChanged<RangeValues> onChanged;

  const PriceSlider({
    super.key,
    required this.min,
    required this.max,
    required this.currentRangeValues,
    required this.onChanged,
  });

  @override
  State<PriceSlider> createState() => _PriceSliderState();
}

class _PriceSliderState extends State<PriceSlider> {
  late RangeValues _values;

  @override
  void initState() {
    super.initState();
    _values = widget.currentRangeValues;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 1,
      color: Colors.grey.shade100,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter by Price',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            RangeSlider(
              values: _values,
              min: widget.min,
              max: widget.max,
              divisions: 20,
              activeColor: Colors.teal,
              inactiveColor: Colors.teal.withOpacity(0.2),
              labels: RangeLabels(
                '\$${_values.start.toStringAsFixed(0)}',
                '\$${_values.end.toStringAsFixed(0)}',
              ),
              onChanged: (newRange) {
                setState(() {
                  _values = newRange;
                });
                widget.onChanged(newRange);
              },
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Selected Range: \$${_values.start.toStringAsFixed(0)} - \$${_values.end.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
