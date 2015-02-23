window.onload = function() {
  var content = document.querySelector('code');
  content.innerHTML = content.innerHTML
    .replace(/"url": "(\/.*?)"/g, '"url": "<a href="$1">$1</a>"')
    .replace(/"next": "(\/.*?)"/g, '"next": "<a href="$1">$1</a>"');
};
