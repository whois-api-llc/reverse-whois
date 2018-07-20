using System;
using System.IO;
using System.Net;

using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

// Note that you need to make sure your Project is set to ".NET Framework 4"
// and NOT ".NET Framework 4 Client Profile". Once that is set, make sure the
// following references are present under the References tree under the
// project: Microsoft.CSharp, System, System.Web.Extensions, and System.XML.

namespace ReverseApiExample
{
    public static class ReverseApiExample
    {
        private static void Main()
        {
            //////////////////////////
            // Fill in your details //
            //////////////////////////
            var reverseWhois = new ReverseWhoisSample
            {
                Username = "Your reverse whois api username",
                Password = "Your reverse whois api password"
            };

            //////////////////////////
            // Send POST request    //
            //////////////////////////
            var responsePost = reverseWhois.SendPostReverseWhois();
            PrintResponse(responsePost);

            //////////////////////////
            // Send GET request     //
            //////////////////////////
            var responseGet = reverseWhois.SendGetReverseWhois();
            PrintResponse(responseGet);

            // Prevent command window from automatically closing
            Console.WriteLine("\nPress any key to continue...");
            Console.ReadKey();
        }

        private static void PrintResponse(string response)
        {
            dynamic responseObject = JsonConvert.DeserializeObject(response);

            if (responseObject != null)
            {
                Console.Write(responseObject);
                Console.WriteLine("--------------------------------");
                return;
            }

            Console.WriteLine();
        }

    }

    public class ReverseWhoisSample
    {
        public string Password { get; set; }
        
        public string Username { get; set; }
        
        private const string Url =
            "https://www.whoisxmlapi.com/reverse-whois-api/search.php";
        
        public string SendGetReverseWhois()
        {
            /////////////////////////
            // Use a JSON resource //
            /////////////////////////
            var requestParams =
                "?term1=topcoder"
                + "&mode=purchase"
                + "&username=" + Uri.EscapeDataString(Username)
                + "&password=" + Uri.EscapeDataString(Password);

            var fullUrl = Url + requestParams;

            Console.Write("Sending request to: " + fullUrl + "\n");

            // Download JSON into a string
            var result = new WebClient().DownloadString(fullUrl);
                
            // Print a nice informative string
            try
            {
                return result;
            }
            catch (Exception)
            {
                return "{\"error\":\"An unkown error has occurred!\"}";
            }
        }
        
        public string SendPostReverseWhois()
        {
            /////////////////////////
            // Use a JSON resource //
            /////////////////////////

            Console.Write("Sending request to: " + Url + "\n");

            var httpWebRequest = (HttpWebRequest)WebRequest.Create(Url);
            httpWebRequest.ContentType = "application/json";
            httpWebRequest.Method = "POST";

            using (var streamWriter =
                new StreamWriter(httpWebRequest.GetRequestStream()))
            {
                var json = @"{
                    terms: [
                        {
                            section: 'Registrant',
                            attribute: 'name',
                            value: 'n',
                            matchType: 'EndsWith',
                            exclude: false
                        }
                    ],
                    recordsCounter: false,
                    outputFormat: 'json',
                    username: 'USER_NAME',
                    password: 'USER_PASS',
                    rows: 10,
                    searchType: 'current'
                }";

                json = json.Replace("USER_NAME", Username)
                           .Replace("USER_PASS", Password);
                
                var jsonData = JObject.Parse(json).ToString();

                streamWriter.Write(jsonData);
                streamWriter.Flush();
                streamWriter.Close();
            }

            var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();

            var res = "";

            using (var responseStream = httpResponse.GetResponseStream())
            {
                if (responseStream == null || responseStream == Stream.Null)
                {
                    return res;
                }
                
                using (var streamReader = new StreamReader(responseStream))
                {
                    res = streamReader.ReadToEnd();
                }
            }

            return res;
        }
    }
}