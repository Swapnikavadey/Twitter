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
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.users.*;
import javax.servlet.http.*;

/**
 * This class will connect to the twitter entity in GAE and Update the view
 * count of tweet
 * 
 * @author swapnika
 *
 */
@SuppressWarnings("serial")
public class UpdateCounterServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		response.setContentType("text/html");
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		String key = request.getParameter("tID");
		Key k = KeyFactory.stringToKey(key);
		Query query = new Query("Twitter");
		Filter fl = new Query.FilterPredicate(Entity.KEY_RESERVED_PROPERTY, FilterOperator.EQUAL, k);
		query.setFilter(fl);
		PreparedQuery pQuery = datastore.prepare(query);
		Entity tweets = pQuery.asSingleEntity();
		tweets.setProperty("visit_counter", ((Long) tweets.getProperty("visit_counter")).intValue() + 1);
		datastore.put(tweets);
		PrintWriter writer = response.getWriter();
		writer.write("Tweet: " + tweets.getProperty("TweetMessage") + "\n");
		writer.write("</br>");
		writer.println("Visited Counter: " + tweets.getProperty("visit_counter") + "\n");
		writer.write("</br>");
		writer.println("User: " + tweets.getProperty("Username") + "\n");
	}
}
