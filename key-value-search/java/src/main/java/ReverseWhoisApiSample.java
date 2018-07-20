import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.IOException;
import java.net.URL;
import java.net.URLEncoder;

import javax.net.ssl.HttpsURLConnection;

import com.google.gson.*;

import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.ResponseHandler;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

public class ReverseWhoisApiSample
{
    private static final String url =
        "https://www.whoisxmlapi.com/reverse-whois-api/search.php";

    //use getter and setter functions for accessing username and password
    private String password;
    private String username;

    public static void main(String[] args) throws Exception
    {
        ReverseWhoisApiSample query = new ReverseWhoisApiSample();

        // Fill in your details
        query.setUsername("Your reverse whois api username");
        query.setPassword("Your reverse whois api password");

        // Send POST request
        String responseStringPost= query.sendPost();
        query.prettyPrintJson(responseStringPost);

        // Send GET request
        String responseStringGet = query.sendGet();
        query.prettyPrintJson(responseStringGet);
    }

    public String getPassword(boolean quotes)
    {
        if (quotes)
            return "\"" + this.getPassword() + "\"";
        else
            return this.getPassword();
    }

    public String getUsername(boolean quotes)
    {
        if (quotes)
            return "\"" + this.getUsername() + "\"";
        else
            return this.getUsername();
    }

    public String sendGet() throws IOException
    {
        CloseableHttpClient httpclient = null;
        String responseBody = "";

        try {
            String url_api =
                url
                + "?term1=topcoder&search_type=current&mode=purchase"
                + "&username=" +URLEncoder.encode(this.getUsername(),"UTF-8")
                + "&password=" +URLEncoder.encode(this.getPassword(),"UTF-8");

            httpclient = HttpClients.createDefault();
            HttpGet httpget = new HttpGet(url_api);
            System.out.println("executing request " + httpget.getURI());

            // Create a response handler
            ResponseHandler<String> responseHandler =
                    new BasicResponseHandler();

            responseBody = httpclient.execute(httpget, responseHandler);
        } catch (IOException ex) {
            ex.printStackTrace();
        } finally{
            if (httpclient != null)
                httpclient.close();
        }

        return responseBody;
    }

    // HTTP POST request
    public String sendPost() throws Exception
    {
        URL obj = new URL(url);
        HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();

        // Add request header
        con.setRequestMethod("POST");
        con.setRequestProperty("User-Agent", "Mozilla/5.0");

        String searchTerm1 = "\"section\": \"Admin\","
                           + "\"attribute\": \"name\","
                           + "\"value\": \"J\","
                           + "\"matchType\": \"anywhere\","
                           + "\"exclude\": \"false\"";

        String requestOptions =
            "\"recordsCounter\": \"false\","
            + "\"username\":" + this.getUsername(true) + ","
            + "\"password\":" + this.getPassword(true) + ","
            + "\"outputFormat\": \"json\"";

        String requestObject =
            "{\"terms\":[{" + searchTerm1 + "}], " + requestOptions +"}";

        // Send POST request
        con.setDoOutput(true);
        DataOutputStream wr = new DataOutputStream(con.getOutputStream());
        wr.writeBytes(requestObject);
        wr.flush();
        wr.close();

        System.out.println("\nSending 'POST' request to URL : " + url);

        BufferedReader in = new BufferedReader(
                new InputStreamReader(con.getInputStream()));

        String inputLine;
        StringBuilder response = new StringBuilder();

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        return response.toString();
    }

    public void setPassword(String password)
    {
        this.password = password;
    }

    public void setUsername(String username)
    {
        this.username = username;
    }

    private String getPassword()
    {
        return this.password;
    }

    private String getUsername()
    {
        return this.username;
    }

    private void prettyPrintJson(String jsonString){

        Gson gson = new GsonBuilder().setPrettyPrinting().create();

        JsonParser jp = new JsonParser();
        JsonElement je = jp.parse(jsonString);
        String prettyJsonString = gson.toJson(je);

        System.out.println("\n\n" + prettyJsonString);
        System.out.println("----------------------------------------");
    }
}