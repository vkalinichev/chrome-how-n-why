let isFound = false;

const dictionaries = [
  {
    test: /^как\s/i,
    replacement: {
      prefix: ', а главное — ',
      question: 'зачем?',
    },
  },
  {
    test: /^how(-to)?/i,
    replacement: {
      prefix: ', and most importantly — ',
      question: 'why?',
    },
  },
];

function template(options) {
  return `<span class='howandwhy'>${options.prefix}
  <span class='howandwhy__term'>
    <span class='howandwhy__baloon'></span>
    <span class='howandwhy__why'>${options.question}</span>
  </span>
</span>`;
}


function processHeader(selectors, element = document) {
  const headers = element.querySelectorAll(selectors);

  headers.forEach((header) => {
    let html = header.innerHTML;
    const isAlreadyWhyed = header.classList.contains('howandwhy__target');

    if (!html || isAlreadyWhyed) return;

    dictionaries.forEach((dictionary) => {
      const isMatches = !!html.match(dictionary.test);

      if (isMatches) {
        header.classList.add('howandwhy__target');
        header.innerHTML = html
          .replace(/(:|,|\.|!|\?|\\|\/)$/, '') + template(dictionary.replacement);
      }
    });

    if (!isFound) {
      injectStyle();
      isFound = true;
    }
  });
}

function process(element) {
  processHeader('h1 *,h2 *,h3 *', element);
  return processHeader('h1,h2,h3', element);
}

function onDOMChanged(event) {
  if (!event.target.nodeName.match(/^#/)) {
    return process(event.target);
  }
}

function injectStyle() {
  const linkElement = document.createElement('link');
  linkElement.rel = chrome.extension.getURL('hnw.css');
  document.body.appendChild(linkElement);
}

process();

document.documentElement.addEventListener('DOMNodeInserted', onDOMChanged);
