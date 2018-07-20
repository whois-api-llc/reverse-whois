import java.net.URL;
import java.net.URLEncoder;
import java.util.Scanner;

import com.google.gson.*;

public class ReverseWhoisClassic
{
    public static void main(String[]args)
    {
        String apiUrl =
            "https://www.whoisxmlapi.com/reverse-whois-api/search.php";

        String term = "wikimedia";
        String username = "Your reverse whois api username";
        String password = "Your reverse whois api password";
        String mode = "purchase";

        String url = "";
        try {
            url = apiUrl
                + "?mode=" + URLEncoder.encode(mode, "UTF-8")
                + "&term1=" + URLEncoder.encode(term, "UTF-8")
                + "&output_format=json"
                + "&username=" + URLEncoder.encode(username, "UTF-8")
                + "&password=" + URLEncoder.encode(password, "UTF-8");
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }

        try {
            Scanner s = new Scanner(new URL(url).openStream());
            prettyPrintJson(s.useDelimiter("\\A").next());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    private static void prettyPrintJson(String jsonString)
    {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();

        JsonParser jp = new JsonParser();
        JsonElement je = jp.parse(jsonString);
        String prettyJsonString = gson.toJson(je);

        System.out.println("\n\n" + prettyJsonString);
        System.out.println("----------------------------------------");
    }
}