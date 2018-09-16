import vibe.vibe, std.conv, std.string;

void main()
{
    auto settings = new HTTPServerSettings;
    settings.port = 8080;
    settings.bindAddresses = ["::1", "0.0.0.0"];
	listenHTTP(settings, &handler);

	logInfo("Please open http://0.0.0.1:8080/ in your browser.");
	runApplication();
}

// @return fib i number
int fib(int i)
{
    if (i <=0)
    {
        return 0;
    }
    return i <= 2 ? 1 : fib(i - 2) + fib(i - 1);
}

// @return cleaned uri or empty string
string cleanReqPath(string reqUri)
{
    if (reqUri.length > 1 && reqUri != "/favicon.ico")
    {
        return reqUri[1 .. reqUri.length];
    }
    return "";
}

// @return true, if uri is numeric
bool isNumber(string uri)
{
    return uri.length > 0 && isNumeric(uri);
}

// main requests handler
void handler(HTTPServerRequest req, HTTPServerResponse res)
{
    string clientAddress = req.clientAddress.toAddressString();
    logInfo("Request from: "~clientAddress);
    string uri = cleanReqPath(req.path);
    if (isNumber(uri))
    {
        immutable int value = parse!int(uri);
        logInfo(clientAddress~" sent request Fibanocci("~to!string(value)~")");
        immutable string result = "Fibanocci("~to!string(value)~")="~to!string(fib(value));
        logInfo(result);
        res.writeBody(result);
    }
    else
    {
        res.writeBody("Usage: localhost:8080/[NUMBER]");
    }
}
