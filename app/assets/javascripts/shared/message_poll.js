
var intID = self.setInterval("check_for_messages()",1000);
var calls_since_last_message = 0;
var current_time_interval = 5000;

function check_for_messages()
{
	$.ajax({
		url: '/messages',
		complete: processMessage,
	});
	calls_since_last_message++;
	// slow it down to 5 sec after a minute of nothing
	if (calls_since_last_message * current_time_interval / 60000 > 1)
	{
		self.clearInterval(intID);
		current_time_interval = 5000;
		intID = self.setInterval("check_for_messages()",current_time_interval);	
	}
	// after ten minutes of nothing shut it down
	if (calls_since_last_message * current_time_interval / 60000 > 10) 
		self.clearInterval(intID);
}
function processMessage(data)
{
	//alert(JSON.stringify(data.responseText));
	var m = eval("(" + data.responseText + ")");

	if (m != null)
	{
		calls_since_last_message = 0;

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
			current_time_interval = 1000;
		}
		else
		{
			alert(message);
			self.location.reload(true);
		}
		intID = self.setInterval("check_for_messages()", current_time_interval);
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
			log("in createGameWith got response: " + data.responseText);
			var g = eval("(" + data.responseText + ")");
			game_id = g.id;
		}
	});
	current_time_interval = 1000; // speed up response when playing
	return game_id;
}
function log(msg) {
   setTimeout(function() {
        throw new Error(msg);
    }, 0);
}

