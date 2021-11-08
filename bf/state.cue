package bf

#State: {
	memories: #Memories
	pointer:  int | >=0 | <memorySize
	tokens: [...#Token]
	nestLevels: [...{idx: int, level: int}]
	cursor: int | >=0 | <len(sourceTokens)
	inputValues: [...#MemoryUnit]
	outputValues: [...#MemoryUnit]
}
