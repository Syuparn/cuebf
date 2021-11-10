package bf

#State: {
	memories: #Memories
	pointer:  int | >=0 | <memorySize
	tokens: [...#Token]
	nestLevels: [...{idx: int, level: int}]
	cursor: int | >=0 | <=len(sourceTokens)
	inputValues: [...#MemoryUnit]
	outputValues: [...#MemoryUnit]
}

let _inputValues = inputValues
initialState: #State & {
	memories:    initialMemories
	pointer:     0
	tokens:      sourceTokens
	nestLevels:  sourceNestLevels
	cursor:      0
	inputValues: _inputValues
	outputValues: []
}
