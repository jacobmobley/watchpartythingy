(function() {
  // detect debug flag
  const isDebug = new URL(window.location.href).searchParams.has('debug');

  // build control bar
  const bar = document.createElement('div');
  bar.id = 'wp-controls';
  bar.innerHTML = `
    <button id="wp-back">Back</button>
    <button id="wp-home">Home</button>
  `;
  document.body.appendChild(bar);

  document.getElementById('wp-back')
    .addEventListener('click', () => window.history.back());
  document.getElementById('wp-home')
    .addEventListener('click', () => window.location.href = 'file:///opt/homescreen/index.html');

  // hide on fullscreen
  document.addEventListener('fullscreenchange', () => {
    bar.style.display = document.fullscreenElement ? 'none' : 'flex';
  });

  if (!isDebug) {
    // block context menu
    window.addEventListener('contextmenu', e => e.preventDefault(), true);

    // block common close and dev-key combos
    window.addEventListener('keydown', e => {
      // list of forbidden keys: F11, Ctrl+W, Ctrl+Shift+I, Alt+F4
      const blocked = (
        (e.ctrlKey && e.key.toLowerCase() === 'w') ||
        (e.ctrlKey && e.shiftKey && ['i','j','c'].includes(e.key.toLowerCase())) ||
        (e.altKey && e.key === 'F4')
      );
      if (blocked) {
        e.stopImmediatePropagation();
        e.preventDefault();
      }
    }, true);
  } else {
    // Only show leave prompt in debug mode
    window.addEventListener('beforeunload', e => {
      e.preventDefault();
      e.returnValue = '';
    });
  }
})();
