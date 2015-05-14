setInterval(function () {
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
}, 10000);

self.addEventListener('message', function(e) {
  self.postMessage(e.data);
}, false);
