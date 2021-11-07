package bf

import (
	"list"
)

#MemoryUnit: >=0 & <memoryUnitSize & int
#Memories:   list.Repeat([#MemoryUnit], memorySize)

memoryUnitSize:  256
memorySize:      *1024 | int
initialMemories: #Memories & list.Repeat([0], memorySize)
