/*var promptworker = new Worker('/scripts/prompt.js');
promptworker.addEventListener('message', function(e) {
  console.log('Prompt worker said: ', e.data);
}, false);
promptworker.postMessage('start'); 
*/

function checkSystemStatus() {
	try {
		var s = loadJSON("/data/status.json");
		if (s && s.status == "busy") {
			console.log("busy");
		}
		var prompting = loadJSON("/data/prompts.json");
		if (prompting && prompting.length>0) {
			console.log("data");
		}		
	} catch (e) {
		console.log(e.message);
		// Silently quit
	}	
}

setInterval(checkSystemStatus, 5000);
