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
			// NOTE: command disjunction cannot be used because it spends too long time
			// (O(commands ** maxStates))
			"\(i)": (#Commands[states["\(i-1)"].tokens[states["\(i-1)"].cursor]] & {
				input: states["\(i-1)"]
			}).output
		}
	}}
	result: states["\(len(states)-1)"]
}
