<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="css/Search.css" rel="stylesheet"/>
 <style>
table, th, td {
  border: 1px solid black;
  }
  </style>


<meta charset="UTF-8">
<title>Library Search</title>
</head>
<body>
<input type="button" name="back" id="submit" value="Return to search" onclick="window.location='home.jsp'"/>
 <div id="main">

 <table style="width:100%">
  <tr>
    <th>Author</th>
    <th>Book title</th>
    <th>Publisher</th>
    <th>ISBN</th>
  </tr>
  
<% 


List<String> books = (List<String>) request.getAttribute("books");
			if(books.size()==0){
				out.println(request.getAttribute("noResults")+"\n");
			}
				
				for(String book: books){
					String s[]=book.split(",");
					out.println("<tr>");
					int i=0;
				while(i<s.length){
					out.print("<td>" + s[i++] + "</td>");//<td>"+s[1]+"</td><td>"+s[2]);
	
				}
				}
				    %>
				    </table>
        </div>
</body>
</html>