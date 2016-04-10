whyCounter = 0

dictionaries = require './modules/dictionaries'


template = ( options )->
    preamble = options.texts[ Math.floor Math.random()*options.texts.length ]

    "<span class='howandwhy'>#{preamble}<span class='howandwhy__term'>
        <span class='howandwhy__baloon'></span>
        <span class='howandwhy__why'>#{options.question}</span>
    </span></span>"


processHeader = ( selectors, element = document)->
    headers = element.querySelectorAll selectors

    for header in headers
        isAlreadyWhyed = header.classList.contains "howandwhy__target"

        if isAlreadyWhyed then continue

        html = header.innerHTML

        if not html then continue

        html = html.trim()

        for language of dictionaries
            if not dictionaries.hasOwnProperty language then break

            dictionary = dictionaries[ language ]

            isHow = html.match dictionary.test

            if isHow

                if html and html.match /(:|,|\.|!|\?|\\|\/)$/
                    html = html.slice 0, -1

                header.classList.add "howandwhy__target"
                header.innerHTML = html + template
                    texts: dictionary.replacement.texts
                    question: dictionary.replacement.question

        whyCounter++

process = ( element )->
    processHeader 'h1 *,h2 *,h3 *', element
    processHeader 'h1,h2,h3', element

onDOMChanged = ( event )->
    if not event.target.nodeName.match /^#/
        process event.target

process();

if whyCounter
    style = document.createElement 'link'
    url = chrome.extension.getURL "css/hnw.css"
    style.rel = url;
    document.body.appendChild style

document.documentElement.addEventListener 'DOMNodeInserted', onDOMChanged