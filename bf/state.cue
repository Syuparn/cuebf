package bf

#State: {
	memories: #Memories
	pointer:  int | >=0 | <memorySize
	cursor:   int | >=0 | <len(sourceTokens)
	inputValues: [...#MemoryUnit]
	outputValues: [...#MemoryUnit]
}
