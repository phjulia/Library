package com.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Home")
public class Home extends HttpServlet {
	private static Connection con;
	private static Statement stmt;
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 List<String> books = new ArrayList<>();
		
		if(request.getParameter("all")!=null) {
			books=getBooks();
			request.setAttribute("books", books);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("search.jsp");
			requestDispatcher.forward(request, response);
		}else if(request.getParameter("next")!=null) {
		
		 String title = request.getParameter("booktitle").trim();
		 String author = request.getParameter("author").trim();
		 String isbn = request.getParameter("isbn").trim();
		 if(title.equals("") && author.equals("") && isbn.equals("")) {
			 String error = "Fields cannot be empty";
			 request.setAttribute("error",error);
			 RequestDispatcher requestDispatcher = request.getRequestDispatcher("home.jsp");
			    requestDispatcher.forward(request, response);
		 }else if(!isbn.equals("") && isbn.length()!=13) {
			 String error = "ISBN code's length should be 13 numbers";
			 request.setAttribute("error",error);
			 RequestDispatcher requestDispatcher = request.getRequestDispatcher("home.jsp");
			    requestDispatcher.forward(request, response);   	
			    
		 }else {
		    books=findBook(title,author,isbn);
		    if(books.size()==0) {
		    	 String noResults="Search returned 0 results by given parameters";
		    	 request.setAttribute("noResults", noResults);
		    }
		    request.setAttribute("books", books);
		    
		    RequestDispatcher requestDispatcher = request.getRequestDispatcher("search.jsp");
		    requestDispatcher.forward(request, response);
		 }
		}
	}
	 public static List<String> findBook(String title, String author, String isbn) {
			List<String> book = new ArrayList<String>();
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:8889/Library","root","root");
			stmt=con.createStatement();  
			String query = "SELECT title, a.name, p.name,ISBN FROM Book b "
					+ "JOIN Author a ON a.id=b.authorID "
					+ "JOIN Publisher p ON p.id=b.PublisherID "
					+ "WHERE ";
			String options = "";
			String hasTitle="b.title='"+title+"'";
			String hasAuthor="a.name='"+author+"'";
			
			String hasIsbn="b.isbn='"+isbn+"'";
			if(isbn!=null && isbn!="") {
				options+=hasIsbn;
			}
			if(title!=null && title!="") {
				options+=hasTitle;
				if(author!=null && author!="") {
					options+=" AND "+hasAuthor;
				}
			}else if(author!=null && author!="") {
				options+=hasAuthor;
			}
			query=query+options;
			ResultSet rs=stmt.executeQuery(query);  
		
			while(rs.next()) {
				String result=rs.getString(2)+","+rs.getString(1)+","+rs.getString(3)+","+rs.getString(4);
				book.add(result);
			}
			
		} catch (ClassNotFoundException e) {

			e.printStackTrace();
		}   catch (SQLException e) {

			e.printStackTrace();
		}
		
		
		return book;
		}
public static List<String> getBooks(){
	List<String> books = new ArrayList<>();
	try {
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:8889/Library","root","root");
		stmt=con.createStatement();  
		String query = "SELECT title, a.name, p.name,ISBN FROM Book b "
				+ "JOIN Author a ON a.id=b.authorID "
				+ "JOIN Publisher p ON p.id=b.PublisherID";
		ResultSet rs=stmt.executeQuery(query);  
		while(rs.next()) {
			String result=rs.getString(1)+", "+rs.getString(2)+", "+rs.getString(3)+","+rs.getString(4);
			books.add(result);
		}
		
	} catch (ClassNotFoundException e) {

		e.printStackTrace();
	}   catch (SQLException e) {

		e.printStackTrace();
	}
	return books;	
}
	 

}
