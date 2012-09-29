/**
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-29
 */
package touchvg.test;

import touchvg.canvas.GiCanvasEx;
import touchvg.jni.TestCanvas;

public class GraphView01 extends GraphView {
	
	@Override
	protected void onDraw(GiCanvasEx canvas) {
		if (hasFlag(0x01))
	        TestCanvas.testRect(canvas);
	    if (hasFlag(0x02))
	        TestCanvas.testLine(canvas);
	    if (hasFlag(0x04))
	        TestCanvas.testDot(canvas);
	    if (hasFlag(0x08))
	        TestCanvas.testEllipse(canvas);
	    if (hasFlag(0x10))
	        TestCanvas.testQuadBezier(canvas);
	    if (hasFlag(0x20))
	        TestCanvas.testCubicBezier(canvas);
	    if (hasFlag(0x40))
	        TestCanvas.testPolygon(canvas);
	}
}
