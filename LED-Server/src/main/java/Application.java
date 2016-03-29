import com.pi4j.wiringpi.Spi;

import static spark.Spark.*;

/**
 * Created by juleskreutzer on 29-03-16.
 */
public class Application {

    /**
     * @param 12 The number of leds that are located on the strip
     * @param 0.5F Brightness of the leds
     */
    private static final LedStrip strip = new LedStrip(12, 0.5F);

    public static void main(String[] args) throws Exception {


        /**
         * Set the port the spark server will run on to 8050
         */
        port(8050);

        boolean result = initialize();
        if(!result)
            return;

        post("/on", (request, response) -> {
            welcome();
            return null;
        });

        post("/update/:R/:G/:B", (request, response) -> {
            int r = Integer.parseInt(request.params("R"));
            int g = Integer.parseInt(request.params("G"));
            int b = Integer.parseInt(request.params("B"));

            strip.fill(r, g, b);
            strip.update();

            return null;
        });

        post("/update/brightness/:R/:G/:B/:BN", (request, response) -> {
            int r = Integer.parseInt(request.params("R"));
            int g = Integer.parseInt(request.params("G"));
            int b = Integer.parseInt(request.params("B"));
            float bn = Float.parseFloat(request.params("BN"));

            strip.fill(r, g, b, bn);
            strip.update();

            return null;
        });

        post("/off", (request, response) -> {
            strip.allOff();
           return null;
        });

        exception(IllegalArgumentException.class, (e, request, response) -> {
            response.body(e.getMessage());
        });
    }

    /**
     * Setup the communication between the RBPI and the ledstrip
     */
    private static boolean initialize() {

        int fd = Spi.wiringPiSPISetup(0, 10000000);
        if(fd <= -1) {
            System.out.println("Spi initialization failed!");
            return false;
        }

        System.out.println("Spi initialization succeeded");
        return true;
    }

    private static void welcome() throws InterruptedException {
        strip.testStrip();
    }
}
