;(function () {
  var flavors = [
    'is a web developer',
    'writes code',
    'drives an Asp Explorer',
    'has a tilde page',
    'is online',
    'is offline',
    'is typing',
    'plays video games',
    'has a phone',
    'takes photos',
    'is afraid of dogs',
    'hates TV',
    'likes vaporwave',
    'does React',
    'does TypeScript',
    'does JavaScript',
    'does node.js',
    'listens to music',
    'has a laptop',
    'wrote this flavor text',
    'has an internet connection',
    'sleeps at night',
    'is not a furry',
    'probably likes you'
  ]

  var colors = [
    'bg-base0A',
    'bg-base0B',
    'bg-base0C',
    'bg-base0D'
  ]

  // select our random flavor text from the above array
  var flavorText = document.getElementById('flavorText')

  flavorText.innerHTML = flavors[Math.floor(Math.random() * flavors.length)]
})()
