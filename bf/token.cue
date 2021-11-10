package bf

import (
	"list"
	"strings"
)

sourceTokens: [ for t in strings.Split(source, "") if list.Contains(validTokens, t) {t}]
sourceNestLevels: (#Parser & {tokens: sourceTokens}).nestLevels

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
