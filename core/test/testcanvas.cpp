/**
 * @copyright GNU LGPL v3, https://github.com/rhcad/touchvg
 * @author Zhang Yungui
 * @version 1.0, 2012-9-26
 */
#include "testcanvas.h"
#include "gicanvas.h"
#include <stdlib.h>

void TestCanvas::initRand(unsigned seed)
{
    static bool inited = false;
    //if (!inited) {
        inited = true;
        srand(seed);
    //}
}

int TestCanvas::randInt(int minv, int maxv)
{
    return rand() % (maxv - minv + 1) + minv;
}

float TestCanvas::randFloat(float minv, float maxv, float div)
{
    int range = (int)((maxv - minv) * div);
    return (float)(rand() % range) / div + minv;
}

void TestCanvas::testRect(GiCanvas* canvas)
{
    for (int i = 0; i < 100; i++) {
        canvas->drawRect(randFloat(-20.f, 800.f), randFloat(-20.f, 800.f),
                         randFloat(-20.f, 500.f), randFloat(-20.f, 500.f),
                         randInt(0, 1) == 1, randInt(0, 1) == 1);
    }
}

void TestCanvas::testLine(GiCanvas* canvas)
{
    for (int i = 0; i < 100; i++) {
        canvas->drawLine(randFloat(-20.f, 800.f), randFloat(-20.f, 800.f),
                         randFloat(-20.f, 500.f), randFloat(-20.f, 500.f));
    }
}

void TestCanvas::testDot(GiCanvas* canvas)
{
    for (int i = 0; i < 100; i++) {
        canvas->drawDot(randFloat(-20.f, 800.f), randFloat(-20.f, 800.f),
                        randFloat(0.5f, 100.f), 0);
    }
}

void TestCanvas::testEllipse(GiCanvas* canvas)
{
    for (int i = 0; i < 100; i++) {
        canvas->drawEllipse(randFloat(-20.f, 800.f), randFloat(-20.f, 800.f),
                            randFloat(-20.f, 500.f), randFloat(-20.f, 500.f),
                            randInt(0, 1) == 1, randInt(0, 1) == 1);
    }
}

void TestCanvas::testQuadBezier(GiCanvas* canvas)
{
    for (int i = 0; i < 20; i++) {
        canvas->beginPath();
        
        float x1 = randFloat(-20.f, 800.f);
        float y1 = randFloat(-20.f, 800.f);
        float x2 = x1 + randFloat(-100.f, 100.f);
        float y2 = y1 + randFloat(-100.f, 100.f);
        float x3 = x2 + randFloat(-100.f, 100.f);
        float y3 = y2 + randFloat(-100.f, 100.f);
        
        canvas->moveTo(x1, y1);
        canvas->lineTo((x1 + x2) / 2, (y1 + y2) / 2);
        
        for (int j = randInt(1, 20); j > 0; j--) {
            canvas->quadTo(x2, y2, (x3 + x2) / 2, (y3 + y2) / 2);
            
            x1 = x2; x2 = x3;
            y1 = y2; y2 = y3;
            x3 = x2 + randFloat(-100.f, 100.f);
            y3 = y2 + randFloat(-100.f, 100.f);
        }
        canvas->lineTo(x2, y2);
        
        canvas->penChanged(0xFF000000 | randInt(0, 0xFFFFFF), -1.f, -1);
        canvas->drawPath(true, false);
    }
}

void TestCanvas::testCubicBezier(GiCanvas* canvas)
{
    for (int i = 0; i < 20; i++) {
        canvas->beginPath();
        
        float x1 = randFloat(-20.f, 800.f);
        float y1 = randFloat(-20.f, 800.f);
        float x2 = x1 + randFloat(-50.f, 50.f);
        float y2 = y1 + randFloat(-50.f, 50.f);
        float x3 = x2 + randFloat(-50.f, 50.f);
        float y3 = y2 + randFloat(-50.f, 50.f);
        float x4 = x3 + randFloat(-50.f, 50.f);
        float y4 = y3 + randFloat(-50.f, 50.f);
        
        canvas->moveTo(x1, y1);
        
        for (int j = randInt(1, 10); j > 0; j--) {
            canvas->bezierTo(x2, y2, x3, y3, x4, y4);
            
            x1 = x2; y1 = y2;
            x2 = 2 * x4 - x3;
            y2 = 2 * y4 - y3;
            x3 = 4 * (x4 - x3) + x1;
            y3 = 4 * (y4 - y3) + y1;
            x4 = x3 + randFloat(-50.f, 50.f);
            y4 = y3 + randFloat(-50.f, 50.f);
        }
        
        canvas->penChanged(0xFF000000 | randInt(0, 0xFFFFFF), -1.f, -1);
        canvas->drawPath(true, false);
    }
}

void TestCanvas::testPolygon(GiCanvas* canvas)
{
    for (int i = 0; i < 100; i++) {
        canvas->beginPath();
        
        float x = randFloat(-20.f, 800.f);
        float y = randFloat(-20.f, 800.f);
        canvas->moveTo(x, y);
        
        for (int j = randInt(1, 5); j > 0; j--) {
            canvas->lineTo(x += randFloat(-100.f, 100.f), y += randFloat(-100.f, 100.f));
        }
        canvas->closePath();
        
        canvas->penChanged(0x8F000000 | randInt(0, 0xFFFFFF), -1.f, -1);
        canvas->brushChanged(0x41000000 | randInt(0, 0xFFFFFF), 0);
        canvas->drawPath(randInt(0, 1) == 1, randInt(0, 1) == 1);
    }
}
