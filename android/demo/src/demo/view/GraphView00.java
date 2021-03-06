﻿/**
 * @file GraphView00.java
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-29
 */
package demo.view;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;

public class GraphView00 extends TestView {
	private Paint mPen = new Paint();
	
	public GraphView00() {
	}
	
	protected GraphView00(Context context) {
		super(context);
	}
	
	@Override
	protected void onDraw(Canvas canvas) {
		mPen.setStyle(Paint.Style.STROKE);
		canvas.drawLine(10, 10, 100, 200, mPen);
	}
}
