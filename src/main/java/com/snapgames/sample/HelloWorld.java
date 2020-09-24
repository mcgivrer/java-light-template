package main.java.com.snapgames.sample;

import java.util.Arrays;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;

public class HelloWorld {
    private static Logger logger = Logger.getLogger(HelloWorld.class.getName());
    private static ResourceBundle messages = ResourceBundle.getBundle("res/messages");

    private String title;

    private HelloWorld() {
        title = messages.getString("app.title");
    }

    public static void main(String[] args) {
        HelloWorld hw = new HelloWorld();

        logger.log(Level.INFO, "Welcome to {}", hw.title);

        Arrays.asList(args).stream().forEach(arg -> {
            logger.log(Level.INFO, "arg: {0}", arg);
        });
    }

}
