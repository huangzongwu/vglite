/**
 * @file GraphView01.java
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-29
 */
package demo.view;

import android.content.Context;
import touchvg.canvas.GiCanvasEx;
import touchvg.jni.TestCanvas;

public class GraphView01 extends GraphView {
	
	public GraphView01() {
	}
	
	protected GraphView01(Context context) {
		super(context);
	}
	
	@Override
	protected void onDraw(GiCanvasEx canvas) {
		if (hasFlag(0x01))
	        TestCanvas.testRect(canvas);
	    if (hasFlag(0x02))
	        TestCanvas.testLine(canvas);
	    if (hasFlag(0x08))
	        TestCanvas.testEllipse(canvas);
	    if (hasFlag(0x10))
	        TestCanvas.testQuadBezier(canvas);
	    if (hasFlag(0x20))
	        TestCanvas.testCubicBezier(canvas);
	    if (hasFlag(0x40))
	        TestCanvas.testPolygon(canvas);
        if (hasFlag(0x80)) {
            canvas.clearRect(100, 100, 400, 400);
        }
        if (hasFlag(0x100))
            TestCanvas.testClipPath(canvas);
	}
}
