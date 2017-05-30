<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="twitter.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Facebook App</title>
<style>
label textarea{
 vertical-align: middle;
}
</style>
</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	getUserDetails();
});
</script>
   <nav>
   	<ul>
   		<li><a href="tweets.jsp">Tweets</a></li>
   		<li><a href="friends.jsp">Friends</a></li>
   		<li><a href="toptweets.jsp">Top Tweets</a></li>
   	</ul>
   	</nav>
   	
   	<p align="justify">
   	
   		<h2 align="center"></h2>
   		<div id="display_tweet" display="inline" align="center" style="width:60%;margin: 0 auto;border: solid black 2px;">
   		<!--  <iframe onload="getUserDetails()" src="#" width="0" height="0" scrolling="no"></iframe> -->
   			<form action="/store" method="post">
   			<div >
   				<div>
   				<p class="formfield">
   				<label for="message">Write Tweet: </label>
   				<textarea id="message" name="message" rows="7" cols="100" id="message" onchange="getUserDetails()"></textarea>
   				<input type="hidden" id="Username" name="Username"/>
   				<input type="hidden" id="UserId" name="UserId"/>
   				<input type="hidden" id="image" name="image"/>
   				</p>
   				</div>
   				<div style="width:500px;margin: 2% auto;">
	   			<ul >	
		   			<li style="display: block; padding: 10px 10px;"><input type="checkbox" id="post" value="post_checkbox" onclick="create_message();"> <label for="post">Post On Timeline</label></li>   			
		   			<li style="display: block; padding: 10px 10px;"><input type="checkbox" id="send" value="Send Message" onclick="sendmessage();"> <label for="send">Send Message</label> </li>
		   			<li style="display: block; padding: 10px 20px;"><input type="submit" value="Post Tweet" /></li>	
		   		</ul>
		   		</div>
		   		</div>
   			</form>
   		 </div>	
   		 <script type="text/javascript">
   		
   		 </script>
   		 <br>
   		 
   		<%
   		   String name=(String)session.getAttribute("name");
   		   DatastoreService ds=DatastoreServiceFactory.getDatastoreService();
   		   Filter keyfilter = new FilterPredicate("Username",FilterOperator.EQUAL,name); 
   		   Query q= new Query("Twitter"); 
   		   List<Entity> tweets = ds.prepare(q).asList(FetchOptions.Builder.withLimit(30));
   		 
   		 %>
   		 <div style="height: 200px; overflow: auto">
   		 <table align="center" id="tblid">
   		 <tbody>
   		 <tr>
   		 <th style="font-size:16px">
   		 Tweets
   		 </th>
   		 <th style="font-size:16px">
   		 User Name
   		 </th>
         <th>
         <form action="${pageContext.request.contextPath}/delete" method="post">
  			<input type="submit" value="Delete"/>
  			<input type="hidden" id="delete" name="delete"/>  
  	    </form>
         </th>
   		 </tr>
 		 <% 
   		   for(Entity twitter: tweets)
   			{ 
  				  String message=(String)twitter.getProperty("TweetMessage");
  				  String usrname=(String)twitter.getProperty("Username"); 
  				  String usrid=(String)twitter.getProperty("UserId");
  				  String image=(String)twitter.getProperty("picture");
  				  //String tweetid=(String)tweet.getProperty("Name/ID");
  				  //Long id=tweet.getKey().getId();
  	   	  %>
            	<tr> 
  				<td>
  				<%=message %>
  				</td>
  				<td>
  				<%=usrname %>
  			   </td>
  			   <td hidden="true"> <%= KeyFactory.keyToString(twitter.getKey()) %> </td>
  			   <td>
  			   &nbsp;&nbsp;&nbsp;<input type="checkbox" id="chkbox" name="chkbox" onclick="deleteTweet()"/>
  			   </td>
  			   </tr>
   		
        <%  }  %>
      
        </tbody>
        </table>
        </div>
   	<div id="the_Text">
   	</div>
   	<div id="the msg">
   	</div>
   	<div id="the name">
   	</div>
   	</p>
   	<!--<script type="text/javascript" src="fb.js"></script>-->
   	<script type="text/javascript">
   	 
   	function showform()
   	{
   		document.getElementById('display_tweet').style.display='inline';
   		getUserDetails();
   	}
   	function create_message()
   	{
   		var tweetmessage=document.getElementById('message').value;
   		post_tweet(tweetmessage);
   	}
   	function sendmessage()
   	{
   		send_message();
   	}
   	function deleteTweet()
   	{
   		var table = document.getElementById("tblid");
   		var rows = table.getElementsByTagName("tr");
   		for (i = 0; i < rows.length; i++) {
   	        var currentRow = table.rows[i];
   	        var createHandler=
   	        	function(row) 
   	            {
   	                return function() { 
   	                                        var cell = row.getElementsByTagName("td")[2];
   	                                        var id = cell.innerText;
   	                                        document.getElementById('delete').value=id;
   	                                        //var id=document.getElementById('delete').value
   	                                        //alert("ID: "+id);
   	                                        //document.write(id);
   	                                       
   	                                 };
   	            };
   	        currentRow.onclick = createHandler(currentRow);
   	    }
   	}
   	
 function post_tweet(tweetmessage)
   	{
	 
	 document.getElementById('post').checked=false;
   	FB.login(function() {
   	       // var typed_text = document.getElementById("message").value;
   		    
   			FB.api('/me/feed', 'post', {message: tweetmessage});
   			//document.getElementById('the_Text').innerHTML='Thanks for posting the message';
   	    }, {scope: 'publish_actions'});
   	
   	  //document.getElementById('display_tweet').style.display='none';
   	  //window.location="tweet.jsp";
   	}
 function getUserDetails()
 {
 		FB.api('/me?fields=name,id,picture',function(response){
 			document.getElementById('Username').value=response.name;
 			document.getElementById('UserId').value=response.id;
 			document.getElementById('uname').value=response.name;
 			document.getElementById('image').value=response.picture.data.url;
 		});
 }
 function send_message()
 {
	 document.getElementById('send').checked=false;
 		FB.ui({
 		method: 'share',
 		href:'https://apps.facebook.com/twitter/tweets.jsp'
 		});		
 }
 window.fbAsyncInit = function() {
	  FB.init({
	        appId : '1527227393983743',
	        cookie : true, // enable cookies to allow the server to access 
	        // the session
	        xfbml : true, // parse social plugins on this page
	        version : 'v2.5' // use version 2.5
	  });
	  
	  function checkLoginState() {
	      FB.getLoginStatus(function(response) {
	            statusChangeCallback(response);
	      });
	}
	  
	  // function to check the login status
	  
	  function statusChangeCallback(response) {
	      console.log('statusChangeCallback');
	      console.log(response);
	      // The response object is returned with a status field that lets the
	      // app know the current login status of the person.
	      // Full docs on the response object can be found in the documentation
	      // for FB.getLoginStatus().
	      if (response.status === 'connected') {
	            // Logged into your app and Facebook.
	             //testAPI();
	    	  //document.getElementById('status').innerHTML='succesfully connected';
	       } else if (response.status === 'not_authorized') {
	            // The person is logged into Facebook, but not your app.
	             document.getElementById('status').innerHTML = 'Please log ' +'into this app.';
	       } else {
	             // The person is not logged into Facebook, so we're not sure if
	             // they are logged into this app or not.
	             document.getElementById('status').innerHTML = 'Please log ' + 'into Facebook.';
	       }
	}
	  
	  FB.getLoginStatus(function(response) {
	        statusChangeCallback(response);
	        },{scope:'user_friends,user_birthday,email,publish_actions'});
	  };
	// Load the Facebook SDK asynchronously
	  (function(d, s, id) {
	        var js, fjs = d.getElementsByTagName(s)[0];
	        if (d.getElementById(id)) return;
	        js = d.createElement(s); js.id = id;
	        js.src = "//connect.facebook.net/en_US/sdk.js";
	        fjs.parentNode.insertBefore(js, fjs);
	  }(document, 'script', 'facebook-jssdk'));
   	 	
   	</script>
</body>
</html>