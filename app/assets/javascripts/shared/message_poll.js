
var intID = self.setInterval("check_for_messages()",5000);

function check_for_messages()
{
	$.ajax({
		url: '/messages',
		complete: processMessage,
		//data: { player_id: 99 } // this works, so should remap the routes to standard REST ones
								// and use the data: construct to pass what part of the REST
								// action we want.  
	});
}
function processMessage(data)
{
	//alert(JSON.stringify(data.responseText));
	var m = eval("(" + data.responseText + ")");

	if (m != null)
	{
		self.clearInterval(intID);
		
		var fr_id = m.from_player;
		var to_id = m.to_player;
		var message = m.message;
		log("recieved message " + message + " from player " + fr_id + " to player " + to_id);
		
		if (message.indexOf("Play Greed with ") == 0)
		{
			var answ = confirm(message) ? "Yes" : "No";
			
			replyTo(fr_id, answ);
		}
		else if (message == "Yes") {
			var game_id = createGameWith(fr_id);
			log("created game " + game_id);
			replyTo(fr_id, "Please join game " + game_id);
			self.location = "/games/" + game_id;
		}
		else if (message == "No") {
			alert("Other player refused.  Sorry.");
			self.location = "/players";
		}
		else if (message.indexOf("Please join game ") == 0)
		{
			var game_id = eval(message.substring(17));
			self.location = "/games/" + game_id;
		}
		else if (message == "Update")
		{
			self.location.reload(true);
		}
		else
		{
			alert(message);
			self.location.reload(true);
		}
		intID = self.setInterval("check_for_messages()", 5000)
	}		
}

function replyTo(id, message)
{
	$.ajax(	{ 	
		url: '/messages',
     	type: 'POST',
		async: false,
     	data: { 
			to: ""+id, message: message, 
		}
	} );		
}
function createGameWith(player)
{
	var game_id = 0;
	$.ajax( {
		url: '/games',
		type: 'POST',
		data: { 
			player2: player
		},
		async: false,
		complete: function(data) {
			log(data.responseText);
			var g = eval("(" + data.responseText + ")");
			game_id = g.id;
		}
	});
	return game_id;
}
function log(msg) {
   setTimeout(function() {
        throw new Error(msg);
    }, 0);
}

