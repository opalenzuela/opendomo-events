setInterval(function () {
	try {
		var prompting = loadJSON("/data/prompts.json");
		if (prompting.length>0) {
			self.postMessage("data");
		}
	} catch (e) {
		// Silently quit
	}
}, 10000);

self.addEventListener('message', function(e) {
  self.postMessage(e.data);
}, false);
