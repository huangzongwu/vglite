// This example illustrates how C++ interfaces can be used from Java.
//
// 1. `cd' to the output directory (may be './build/java').
// 2. Type the following commands to run this program:
//       javac -cp ./touchvg.jar:. *.java
//       java  -cp ./touchvg.jar:. TestCanvasJNI
//

import touchvg.jni.TestCanvas;

public class TestCanvasJNI {
  static {
    try {
        try {	// for attaching to the current java process.
            Thread.currentThread().sleep(5000);
        } catch (InterruptedException e) {}

        System.loadLibrary("touchvg");
    } catch (UnsatisfiedLinkError e) {
      System.err.println("Native code library failed to load.\n" + e);
      System.exit(1);
    }
  }

  public static void main(String argv[])
  {
    System.out.println( "Hello TestCanvasJNI in Java." );

    TestCanvas.initRand();

    GiCanvasDummy canvas = new GiCanvasDummy();
    System.out.println("Created a object of GiCanvasDummy: " + canvas);

    TestCanvas.testLine(canvas);

    canvas.delete();

    canvas = new GiCanvasDummy();
    System.out.println("Created a object of GiCanvasDummy: " + canvas);
    TestCanvas.testRect(canvas);
    canvas.delete();
    canvas = null;

    System.out.println( "Goodbye" );
  }
}
