/**
 * @file testcanvas.h
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-26
 */
struct GiCanvas;

struct TestCanvas {
    static void initRand(unsigned seed = 99999);
    static int randInt(int minv, int maxv);
    static float randFloat(float minv, float maxv, float div = 10.f);

    static void testRect(GiCanvas* canvas);
    static void testLine(GiCanvas* canvas);
    static void testDot(GiCanvas* canvas);
    static void testEllipse(GiCanvas* canvas);
    static void testQuadBezier(GiCanvas* canvas);
    static void testCubicBezier(GiCanvas* canvas);
    static void testPolygon(GiCanvas* canvas);
    
    static void testClipPath(GiCanvas* canvas);
};
