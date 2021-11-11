package main

import (
	"tool/cli"
	"tool/file"

	interpreter "github.com/syuparn/cuebf/bf"
	"github.com/syuparn/cuebf/view"
)

command: bf: {
	task: read: file.Read & {
		filename: "hello.bf"
		contents: string
	}

	task: eval: cli.Print & {
		outputValues: (interpreter & {
			memorySize: 8
			source:     task.read.contents
			inputValues: [97, 98, 99]
			maxStates: 10
		}).#Evaluator.result.outputValues
		text: (view.bytesToStr & {byteInts: outputValues}).str
	}
}
