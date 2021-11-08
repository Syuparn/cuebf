package bf

import (
	"list"
	"strings"
)

// TODO: how to obtain these fields?
inputValues: [...#MemoryUnit]

source: string
sourceTokens: [ for t in strings.Split(source, "") if list.Contains(validTokens, t) {t}]
nestLevels: (#Parser & {tokens: sourceTokens}).nestLevels

#Token: "+" | "-" | ">" | "<" | "[" | "]" | "." | ","
validTokens: [
	"+",
	"-",
	">",
	"<",
	"[",
	"]",
	".",
	",",
]
