package bf

import (
	"list"
)

#Evaluator: {
	initial: initialState
	states: "0": initial
	states: {for i in list.Range(1, maxStates, 1) {
		// if tokens remain
		if states["\(i-1)"].cursor < len(states["\(i-1)"].tokens) {
			"\(i)": (#Command & {
				token: input.tokens[input.cursor]
				input: states["\(i-1)"]
			}).output
		}
	}}
	result: states["\(len(states)-1)"]
}
