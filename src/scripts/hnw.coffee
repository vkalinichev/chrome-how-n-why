whyCounter = 0

dictionaries = require './modules/dictionaries'


template = ( options )->
    "<span class='howandwhy'>#{options.text}<span class='howandwhy__term'>
        <span class='howandwhy__baloon'></span>
        <span class='howandwhy__why'>#{options.accent}</span>
    </span></span>"


processHeader = ( selectors, element = document)->
    headers = element.querySelectorAll selectors

    for header in headers
        html = header.innerHTML
        isHow
        isAlreadyWhyed

        if not html then continue

        html = html.trim()

        for language of dictionaries
            if not dictionaries.hasOwnProperty language then break

            dictionary = dictionaries[ language ]

            isHow = html.match dictionary.test

            if isHow
                isAlreadyWhyed = html.match dictionary.punctTest

                if isAlreadyWhyed then continue

                if html && html.match /(:|,|\.|!|\?|\\|\/)$/
                    html = html.slice 0, -1

                header.innerHTML = html + template
                    text: dictionary.replacement.text
                    accent: dictionary.replacement.accent

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