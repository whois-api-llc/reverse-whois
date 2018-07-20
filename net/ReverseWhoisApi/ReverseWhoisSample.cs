using System;
using System.Xml;

// Note that you need to make sure your Project is set to ".NET Framework 4"
// and NOT ".NET Framework 4 Client Profile". Once that is set, make sure the
// following references are present under the References tree under the
// project: Microsoft.CSharp, System, System.Web.Extensions, and System.XML.

namespace ReverseWhoisApi
{
    public static class ReverseWhoisSample
    {
        private static void Main()
        {
            //////////////////////////
            // Fill in your details //
            //////////////////////////
            const string username = "Your reverse whois api username";
            const string password = "Your reverse whois api password";

            const string term1 = "test";
            const string excludeTerm1 = "online";

            /////////////////////////
            // Use an XML resource //
            /////////////////////////
            const string format = "xml";

            var url =
                "https://www.whoisxmlapi.com/reverse-whois-api/search.php"
                + "?username=" + Uri.EscapeDataString(username)
                + "&password=" + Uri.EscapeDataString(password)
                + "&output_format=" + Uri.EscapeDataString(format)
                + "&term1=" + Uri.EscapeDataString(term1)
                + "&exclude_term1=" + Uri.EscapeDataString(excludeTerm1);

            Console.WriteLine(url);

            // Download XML into a dynamic object
            dynamic result = new System.Net.WebClient().DownloadString(url);
            try
            {
                var xmlDoc = new XmlDocument();
                xmlDoc.LoadXml(result);
                WriteXml(xmlDoc);
            }
            catch (Exception)
            {
                try
                {
                    Console.WriteLine("JSON:\nErrorMessage:\n\t{0}",
                                      result.ErrorMessage.msg);
                }
                catch (Exception)
                {
                    Console.WriteLine("An unkown error has occurred!");
                }
            }
            // Prevent command window from automatically closing
            Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
        }

        private static void WriteXml(XmlNode doc)
        {
            var settings = new XmlWriterSettings
            {
                Indent = true,
                OmitXmlDeclaration = true
            };
            
            var writer = XmlWriter.Create(Console.Out, settings);

            doc.WriteTo(writer);
            writer.Flush();
            Console.WriteLine();
        }
    }
}