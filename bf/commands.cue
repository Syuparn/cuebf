package bf

import (
	"list"
)

#_Command: {
	input:  #State
	output: #State
}

#Commands: {
	"+": #PlusCommand
	"-": #MinusCommand
	">": #IncCommand
	"<": #DecCommand
	"[": #StartCommand
	"]": #EndCommand
	",": #ReadCommand
	".": #WriteCommand
}

#PlusCommand: #_Command & {
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

#StartCommand: #_Command & {
	input: #State
	output: {
		memories:   input.memories
		pointer:    input.pointer
		tokens:     input.tokens
		nestLevels: input.nestLevels
		if memories[pointer] == 0 {
			cursor: (#JumpToEnd & {state: input}).jumpedCursor + 1
		}

		// else cannot be used
		if memories[pointer] != 0 {
			cursor: input.cursor + 1
		}
		inputValues:  input.inputValues
		outputValues: input.outputValues
	}
}

#EndCommand: #_Command & {
	input: #State
	output: {
		memories:   input.memories
		pointer:    input.pointer
		tokens:     input.tokens
		nestLevels: input.nestLevels
		if memories[pointer] != 0 {
			cursor: (#JumpToStart & {state: input}).jumpedCursor + 1
		}

		// else cannot be used
		if memories[pointer] == 0 {
			cursor: input.cursor + 1
		}
		inputValues:  input.inputValues
		outputValues: input.outputValues
	}
}

#ReadCommand: #_Command & {
	input: #State
	output: {
		memories: list.Concat([
				input.memories[:input.pointer],
				[input.inputValues[0]],
				input.memories[input.pointer+1:],
		])
		pointer:      input.pointer
		tokens:       input.tokens
		nestLevels:   input.nestLevels
		cursor:       input.cursor + 1
		inputValues:  list.Drop(input.inputValues, 1)
		outputValues: input.outputValues
	}
}

#WriteCommand: #_Command & {
	input: #State
	output: {
		memories:     input.memories
		pointer:      input.pointer
		tokens:       input.tokens
		nestLevels:   input.nestLevels
		cursor:       input.cursor + 1
		inputValues:  input.inputValues
		outputValues: list.Concat([
				input.outputValues,
				[input.memories[input.pointer]],
		])
	}
}

#JumpToEnd: {
	state: #State
	// NOTE: last element 0 (default value) is neccessary, otherwise non-concrete #JumpToEnd raises out-of-index
	currentNestLevel: [ for nl in state.nestLevels if nl.idx == state.cursor {nl.level}, 0][0]
	jumpedCursor:     [ for nl in state.nestLevels if (nl.idx > state.cursor) && (nl.level == currentNestLevel) {
		nl.idx
	}, len(state.tokens)][0]
}

#JumpToStart: {
	state: #State
	// NOTE: dummy element 0 (default value) is neccessary, otherwise non-concrete #JumpToEnd raises out-of-index
	currentNestLevel: [ for nl in state.nestLevels if nl.idx == state.cursor {nl.level}, 0][0]
	_cursors: [0, for nl in state.nestLevels if (nl.idx < state.cursor) && (nl.level == currentNestLevel) {
		nl.idx
	}]
	jumpedCursor: _cursors[len(_cursors)-1]
}
