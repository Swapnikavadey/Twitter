function post_tweet(tweetmessage)
{
FB.login(function() {

       // var typed_text = document.getElementById("message").value;
	    
		FB.api('/me/feed', 'post', {message: tweetmessage});
		document.getElementById('the_Text').innerHTML='Thanks for posting the message';

    }, {scope: 'publish_actions'});

   
  //document.getElementById('display_tweet').style.display='none';
}

function getUserDetails()
{
		FB.api('/me',function(response){
			document.getElementById('Username').value=response.name;
			document.getElementById('UserId').value=response.id;
			document.getElementById('uname').value=response.name;
		});
}

function send_message()
{
		FB.ui({
		method: 'share',
		href:'https://apps.facebook.com/twitter/tweets.jsp'
		});		
}
// function to initialize the Facebook with all the app details

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
    	  document.getElementById('status').innerHTML='succesfully connected';

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

        });

  };


// Load the Facebook SDK asynchronously

  (function(d, s, id) {

        var js, fjs = d.getElementsByTagName(s)[0];

        if (d.getElementById(id)) return;

        js = d.createElement(s); js.id = id;

        js.src = "//connect.facebook.net/en_US/sdk.js";

        fjs.parentNode.insertBefore(js, fjs);

  }(document, 'script', 'facebook-jssdk'));