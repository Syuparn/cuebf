package bf

import (
	"list"
)

#_Command: {
	token:  string
	input:  #State
	output: #State
}

#Command: #PlusCommand | #MinusCommand | #IncCommand | #DecCommand

#PlusCommand: #_Command & {
	token: "+"
	input: #State
	output: {
		memories: list.Concat([
				input.memories[:input.pointer],
				[mod(input.memories[input.pointer]+1, memoryUnitSize)],
				input.memories[input.pointer+1:],
		])
		pointer:      input.pointer
		tokens:       input.tokens
		nestLevels:   input.nestLevels
		cursor:       input.cursor + 1
		inputValues:  input.inputValues
		outputValues: input.outputValues
	}
}

#MinusCommand: #_Command & {
	token: "-"
	input: #State
	output: {
		memories: list.Concat([
				input.memories[:input.pointer],
				[mod(input.memories[input.pointer]-1, memoryUnitSize)],
				input.memories[input.pointer+1:],
		])
		pointer:      input.pointer
		tokens:       input.tokens
		nestLevels:   input.nestLevels
		cursor:       input.cursor + 1
		inputValues:  input.inputValues
		outputValues: input.outputValues
	}
}

#IncCommand: #_Command & {
	token: ">"
	input: #State
	output: {
		memories:     input.memories
		pointer:      mod(input.pointer+1, memorySize)
		tokens:       input.tokens
		nestLevels:   input.nestLevels
		cursor:       input.cursor + 1
		inputValues:  input.inputValues
		outputValues: input.outputValues
	}
}

#DecCommand: #_Command & {
	token: "<"
	input: #State
	output: {
		memories:     input.memories
		pointer:      mod(input.pointer-1, memorySize)
		tokens:       input.tokens
		nestLevels:   input.nestLevels
		cursor:       input.cursor + 1
		inputValues:  input.inputValues
		outputValues: input.outputValues
	}
}

// TODO: delete this (only for debugging)
c: #Command & {
	token: "+"
	input: {
		tokens:     sourceTokens
		nestLevels: sourceNestLevels
		memories: [0, 0]
		pointer: 1
		cursor:  0
	}
}
