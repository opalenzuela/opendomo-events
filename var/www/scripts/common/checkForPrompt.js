
setInterval(function () {
	try {
		var prompting = loadJSON("/data/prompts.json");
		if (prompting.length>0) {
			$("#cat-config").addClass("prompting");
			$("#cat-config a").prop("href","");
		}
	} catch (e) {
		// Silently quit
	}
}, 10000);