/*var promptworker = new Worker('/scripts/prompt.js');
promptworker.addEventListener('message', function(e) {
  console.log('Prompt worker said: ', e.data);
}, false);
promptworker.postMessage('start'); 
*/

function checkSystemStatus() {
	try {
		loadAsync("/data/status.json",function(d){
			try {
				switch(d.status) {
					case "busy":
						$("#cat-save a").css("background","rgba(0, 0, 0, 0) url(/images/default/warning.png) no-repeat scroll center center");
						break;
					case "active":
						$("#cat-save a").css("background","rgba(0, 0, 0, 0) url(/themes/default/save.png) no-repeat scroll center center");					
						break;
				}
			} catch(e) {
			}
			console.log(d);
			setTimeout(checkSystemStatus, 5000);
		});
		/*var s = loadJSON("/data/status.json");
		if (s && s.status == "busy") {
			console.log("busy");
		}
		var prompting = loadJSON("/data/prompts.json");
		if (prompting && prompting.length>0) {
			console.log("data");
		}*/		
	} catch (e) {
		console.log(e.message);
		// Silently quit
	}	
}

setTimeout(checkSystemStatus, 5000);

if (typeof loadAsync == "undefined") {
	//TODO Remove this block on 2.2.6
	function loadAsync(filePath, callback){
		jQuery.ajax({
			type : "GET",
			url : filePath
		}).success(callback);		
	}
}