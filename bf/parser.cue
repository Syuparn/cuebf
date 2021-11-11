package bf

import (
	"list"
)

#Parser: {
	let ts = tokens // neccessary to avoid shadowing
	// NOTE: actually, tokens have [...#Token] but disjunction spends more time to be evaluated
	tokens: [...string]
	brackets:   (#Brackets & {tokens:           ts}).brackets
	nestLevels: (#NestLevels & {bracketIndices: brackets}).nestLevels
}

#Brackets: {
	// NOTE: actually, tokens have [...#Token] but disjunction spends more time to be evaluated
	tokens: [...string]
	brackets: [ for i, t in tokens if list.Contains(["[", "]"], t) {
		idx:   i
		token: t
	}]
}

#NestLevels: {
	bracketIndices: [...{idx: int, token: ("[" | "]")}]
	// NOTE: use struct to generate each element by previous one 
	nestLevelsStruct: "-1": {idx: -1, level: 0, token: "["} // dummy initial element
	nestLevelsStruct: {for i, b in bracketIndices {
		"\(i)": {
			idx:   b.idx
			token: b.token
			if b.token == "[" && nestLevelsStruct["\(i-1)"].token == "[" {
				level: nestLevelsStruct["\(i-1)"].level + 1
			}
			if b.token == "]" && nestLevelsStruct["\(i-1)"].token == "]" {
				level: nestLevelsStruct["\(i-1)"].level - 1
			}
			if b.token != nestLevelsStruct["\(i-1)"].token {
				level: nestLevelsStruct["\(i-1)"].level
			}
		}
	}}
	// convert struct to list
	// NOTE: delete dummy element -1
	nestLevels: [ for i in list.Range(0, len(nestLevelsStruct)-1, 1) {
		let nl = nestLevelsStruct["\(i)"]
		idx:   nl.idx
		level: nl.level
	}]
}
