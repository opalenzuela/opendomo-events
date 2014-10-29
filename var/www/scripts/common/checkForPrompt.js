
setInterval(function {
	try {
		var prompting = loadJSON("/data/prompt.json");
		if (prompting.length>0) {
			$("#cat-config").addClass("prompting");
		}
	} catch (e) {
		// Silently quit
	}
}, 10000);