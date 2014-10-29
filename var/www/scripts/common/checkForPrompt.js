
setInterval(function {
	try {
		var prompting = loadJSON("/data/prompts.txt");
		if (prompting.length>0) {
			$("#cat-config").addClass("prompting");
		}
	} catch (e) {
		// Silently quit
	}
}, 10000);