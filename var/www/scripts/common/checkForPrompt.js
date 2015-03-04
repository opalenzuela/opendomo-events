var promptworker = new Worker('/scripts/prompt.js');
promptworker.addEventListener('message', function(e) {
  console.log('Prompt worker said: ', e.data);
}, false);
promptworker.postMessage('start'); 

