CodeMirror.defineMode("T2Tasks", (config, parserConfig)->

  return {
    startState:(base)->
      verb: ''
      noun: ''
      milestone: ''
      stack: []
      baseIndent: base || 0
    
		token:(stream, state)->
			return null if stream.eatSpace()
			#caution: must eat at least one next character
			ch = stream.next()
			stream.eatWhile(/\S/)
			word = stream.string.slice(stream.start, stream.pos)
			console.log(word)
			return 'detail-link' if word is 'Details...'
  }
)

CodeMirror.defineMIME("text/x-t2tasks", "T2Tasks")
