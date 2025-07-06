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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price Range',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        RangeSlider(
          values: _values,
          min: widget.min,
          max: widget.max,
          divisions: 10,
          labels: RangeLabels(
            _values.start.toStringAsFixed(0),
            _values.end.toStringAsFixed(0),
          ),
          onChanged: (newRange) {
            setState(() {
              _values = newRange;
            });
            widget.onChanged(newRange);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$${widget.min.toStringAsFixed(0)}'),
            Text(
              'Selected: \$${_values.start.toStringAsFixed(0)} - \$${_values.end.toStringAsFixed(0)}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text('\$${widget.max.toStringAsFixed(0)}'),
          ],
        ),
      ],
    );
  }
}
