package bf

import (
	"list"
)

#MemoryUnit: >=0 & <memoryUnitSize & int
#Memories:   list.Repeat([#MemoryUnit], memorySize)

initialMemories: #Memories & list.Repeat([0], memorySize)
