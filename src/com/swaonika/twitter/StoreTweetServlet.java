package com.swaonika.twitter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.datastore.*;
import com.google.appengine.api.users.*;
import java.io.IOException;
import javax.servlet.http.*;

/**
 * This class will connect to the twitter entity in GAE and store the tweet
 * along with some meta data
 * 
 * @author swapnika
 */
@SuppressWarnings("serial")
public class StoreTweetServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		response.setContentType("text/html");
		String uname = request.getParameter("uname");
		HttpSession session = request.getSession(true);
		session.setAttribute("name", uname);
		RequestDispatcher rd = request.getRequestDispatcher("tweets.jsp");
		rd.forward(request, response);

	}

	@SuppressWarnings("serial")
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html");
		// getting the datastore
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		// create entity Tweets and put the tweet message into the datastore
		String message = request.getParameter("message");
		String name = request.getParameter("Username");
		String uid = request.getParameter("UserId");
		String image = request.getParameter("image");
		Key tkey = KeyFactory.createKey("tweetid", name);
		Entity twitter = new Entity("Twitter", tkey);
		twitter.setProperty("TweetMessage", message);
		twitter.setProperty("Username", name);
		twitter.setProperty("userID", uid);
		twitter.setProperty("picture", image);
		twitter.setProperty("visit_counter", 0);
		datastore.put(twitter);
		response.sendRedirect("tweets.jsp");

	}
}
