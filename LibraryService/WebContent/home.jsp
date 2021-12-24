<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link href="css/Home.css" rel="stylesheet"/>
<meta charset="UTF-8">
<title>Library Search </title>
</head>
<body>

<div class="center">
	<h2>Library</h2>
<form action="Home" method="post"> 
		<label>Book Title: </label>
		<input name="booktitle" id="booktitle" type="text">
		<label>Author:</label>
		<input name="author" id="author" type="text">
		<label>ISBN:</label>
		<input name="isbn" id="pages" type="text">
		<input type="submit" name="next" id="submit" value="Search" />

  <label id="e">${error}</label>
	
<input type="submit" name="all" id="all" value="View list of books available in the library"/>
</form>
</div>

</body>
</html>