/*var promptworker = new Worker('/scripts/prompt.js');
promptworker.addEventListener('message', function(e) {
  console.log('Prompt worker said: ', e.data);
}, false);
promptworker.postMessage('start'); 
*/

function checkSystemStatus() {
	try {
		var prompting = loadJSON("/data/prompts.json");
		if (prompting.length>0) {
			self.postMessage("data");
		}
		var s = loadJSON("/data/status.json");
		if (s.status == "busy") {
			self.postMessage("busy");
		}
	} catch (e) {
		console.log(e.message);
		// Silently quit
	}	
}

setInterval(function () {
	
}, 5000);
