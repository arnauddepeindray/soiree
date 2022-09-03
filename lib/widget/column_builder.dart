import 'package:flutter/material.dart';

class ColumnBuilder extends StatelessWidget {
	final IndexedWidgetBuilder? itemBuilder;
	final MainAxisAlignment mainAxisAlignment;
	final MainAxisSize mainAxisSize;
	final CrossAxisAlignment crossAxisAlignment;
	final TextDirection? textDirection;
	final VerticalDirection verticalDirection;
	final int? itemCount;

	const ColumnBuilder({
		super.key,
		this.itemBuilder,
		this.itemCount,
		this.mainAxisAlignment: MainAxisAlignment.start,
		this.mainAxisSize: MainAxisSize.max,
		this.crossAxisAlignment: CrossAxisAlignment.center,
		this.textDirection,
		this.verticalDirection: VerticalDirection.down,
	}) ;

	@override
	Widget build(BuildContext context) {
		return new Column(
			children: new List.generate(this.itemCount!,
					(index) => this.itemBuilder!(context, index)).toList(),
		);
	}
}