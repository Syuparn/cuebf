package bf

#State: {
	memories: #Memories
	pointer:  int
	// NOTE: actually, tokens have [...#Token] but disjunction spends more time to be evaluated
	tokens: [...string]
	nestLevels: [...{idx: int, level: int}]
	cursor: int
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
