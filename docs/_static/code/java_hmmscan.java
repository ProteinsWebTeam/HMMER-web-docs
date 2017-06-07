import java.net.*;
import java.io.*;

public class RESTClient{
  public static void main(String[] args) {
    try {
        URL url = new URL("https://www.ebi.ac.uk/Tools/hmmer/search/hmmscan");
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setDoOutput(true);
        connection.setDoInput(true);
        connection.setInstanceFollowRedirects(false);
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        connection.setRequestProperty("Accept", "application/json");

        //Add the database and the sequence. Add more options as you wish!
        String urlParameters = "hmmdb=" + URLEncoder.encode("pfam", "UTF-8") +
        "&seq=" + ">seq\nEMGPSENDPNLFVALYDFVASGDNTLSITKGEKLRVLGYNHNGEWCEAQTKNGQGWVPSNYITPV" +
        "NSLEKHSWYHGPVSRNAAEYLLSSGINGSFLVRESESSPGQRSISLRYEG" +
        "RVYHYRINTASDGKLYVSSESRFNTLAELVHHHSTVADGLITTLHYPAP";

         connection.setRequestProperty("Content-Length", "" +
               Integer.toString(urlParameters.getBytes().length));


        //Send request
        DataOutputStream wr = new DataOutputStream (
                  connection.getOutputStream ());
        wr.writeBytes (urlParameters);
        wr.flush ();
        wr.close ();



        //Now get the redirect URL
        URL respUrl = new URL( connection.getHeaderField( "Location" ));
        HttpURLConnection connection2 = (HttpURLConnection) respUrl.openConnection();
        connection2.setRequestMethod("GET");
        connection2.setRequestProperty("Accept", "application/json");


        //Get the response and print it to the screen
        BufferedReader in = new BufferedReader(
                                new InputStreamReader(
                                connection2.getInputStream()));

        String inputLine;

        while ((inputLine = in.readLine()) != null)
            System.out.println(inputLine);
        in.close();


    } catch(Exception e) {
        throw new RuntimeException(e);
    }
  }
}
