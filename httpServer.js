var http = require("http"),
	path = require("path"),
	url = require('url') ;

var server = http.createServer(function(request, response) {

  var uri = url.parse(request.url).pathname;
  console.log('uri: '+uri);

  //模拟一个text/html响应
  if (uri=='/'){
  	var queryObject = url.parse(request.url,true).query;
	console.log('request GET params: '+queryObject);

	response.writeHead(200, {"Content-Type": "text/html"});
	response.write("<!DOCTYPE 'html'>");
	response.write("<html>");
	response.write("<head>");
	response.write("<title>世界你好</title>");
	response.write("</head>");
	response.write("<body>");
	response.write("世界你好");
	response.write("</body>");
	response.write("</html>");
	response.end();
  }

  //模拟一个JSON响应
  if(uri=='/json'){
	response.writeHead(200, { 'Content-Type': 'application/json' });
	response.end(JSON.stringify({ message: 'OK' }));
  }

  if(uri=='/upload'){
  	response.writeHead(200, { 'Content-Type': 'application/json' });
  	response.end(JSON.stringify({ message: 'OK' }));
  }
  
});
 
server.listen(80);
console.log("Server is listening");