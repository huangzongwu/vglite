/**
 * @file DummyContent.java
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-25
 */
package demo.app;

import java.util.ArrayList;
import java.util.List;

public class DummyContent {

    public static class DummyItem {

        public String id;
        public String title;
        public int flags;

        public DummyItem(String id, int flags, String title) {
            this.id = id;
            this.flags = flags;
            this.title = title;
        }

        @Override
        public String toString() {
            return title;
        }
    }

    public static List<DummyItem> ITEMS = new ArrayList<DummyItem>();

    static {
    	addItem("demo.view.GraphView00", 0,    "Simple view");
    	addItem("demo.view.GraphView01", 0x01, "testRect");
    	addItem("demo.view.GraphView01", 0x02, "testLine");
    	addItem("demo.view.GraphView01", 0x08, "testEllipse");
    	addItem("demo.view.GraphView01", 0x10, "testQuadBezier");
    	addItem("demo.view.GraphView01", 0x20, "testCubicBezier");
    	addItem("demo.view.GraphView01", 0x40, "testPolygon");
        addItem("demo.view.GraphView01", 0x80|0x40|0x02, "testClearRect");
        addItem("demo.view.GraphView01", 0x100, "testClipPath");
    }
    
    private static void addItem(String id, int flags, String title) {
    	ITEMS.add(new DummyItem(id, flags, title));
    }
}
