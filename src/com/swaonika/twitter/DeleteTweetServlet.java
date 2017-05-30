package com.swaonika.twitter;
import java.io.PrintWriter;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import java.io.IOException;
import javax.servlet.http.*;
/**
 * This class will connect to the twitter entity in GAE and delete the tweet
 * @author swapnika
 *
 */
@SuppressWarnings("serial")
public class DeleteTweetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
		PrintWriter writer = response.getWriter();
		response.setContentType("text/html");
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		String id = request.getParameter("delete");
		Key key = KeyFactory.stringToKey(id);
		datastore.delete(key);
		response.sendRedirect("tweets.jsp");
	}
}
