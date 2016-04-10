module.exports =
    
    russian:
        test: /^как /i
        punctTest: /зачем\?$/i
        replacement:
            texts: [
                ', а главное — '
                ', и '
            ]
            question: 'зачем?'

    english:
        test: /^how(-to)? /i
        punctTest: /why\?$/i
        replacement:
            texts: [
                ', and most importantly — '
                ', and '
            ]
            question: 'why?'