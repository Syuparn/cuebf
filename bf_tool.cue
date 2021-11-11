package main

import (
	"tool/cli"

	interpreter "github.com/syuparn/cuebf/bf"
	"github.com/syuparn/cuebf/view"
)

command: bf: {
	task: eval: cli.Print & {
		outputValues: (interpreter & {
			memorySize: 10
			source:     ",.++.++++"
			inputValues: [97, 2, 4]
			maxStates: 11
		}).#Evaluator.result.outputValues
		text: (view.bytesToStr & {byteInts: outputValues}).str
	}
}
