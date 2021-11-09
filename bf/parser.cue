package bf

import (
	"list"
)

#Parser: {
	let ts = tokens // neccessary to avoid shadowing
	tokens: [...#Token]
	brackets:   (#Brackets & {tokens:           ts}).brackets
	nestLevels: (#NestLevels & {bracketIndices: brackets}).nestLevels
}

#Brackets: {
	tokens: [...#Token]
	brackets: [ for i, t in tokens if list.Contains(["[", "]"], t) {
		idx:   i
		token: t
	}]
}

#NestLevels: {
	bracketIndices: [...{idx: int, token: ("[" | "]")}]
	// NOTE: use struct to generate each element by previous one 
	nestLevelsStruct: "0": {idx: 0, level: 0}
	nestLevelsStruct: {for i, b in bracketIndices {
		let arrIdx = i + 1
		"\(arrIdx)": {
			idx:   b.idx
			level: {
				"[": nestLevelsStruct["\(arrIdx-1)"].level + 1
				"]": nestLevelsStruct["\(arrIdx-1)"].level - 1
			}[b.token]
		}
	}}
	// convert struct to list
	nestLevels: [ for i in list.Range(0, len(nestLevelsStruct), 1) {
		nestLevelsStruct["\(i)"]
	}]
}
