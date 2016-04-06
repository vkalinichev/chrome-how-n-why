module.exports =
    
    russian:
        test: /^как /i
        punctTest: /зачем\?$/i
        replacement:
            text: ', а главное — '
            accent: 'зачем?'

    english1:
        test: /^how /i
        punctTest: /why\?$/i
        replacement:
            text: ', and most importantly — '
            accent: 'why?'

    english2:
        test: /^how-to /i
        punctTest: /why-do\?$/i
        replacement:
            text: ', and '
            accent: 'why-do?'