extension ConsoleProtocol {
    public func printUsage(executable: String, commands: [Runnable], group: Group) {
        print("Usage: ", newLine: false)
        print("\(executable) COMMAND\n")

        printDescription(group: group)

        if commands.count > 0 {
			print("\nCommands: ")
            print(commands.map { command in
                var line = "   "
				line += command.id
				line += "\t"
				line += command.signature
				line += "\n"

				return line
                }.joined())
        } else {
            print()
        }
    }

    public func printHelp(executable: String, group: Group) {
        printHelp(group.help)
    }

    public func printDescription(group: Group) {
        print(group.description)
    }

    public func printHelp(executable: String, command: Command) {
        command.printUsage(executable: executable)
        printHelp(command.help)
        command.printSignatureHelp()
    }

    public func printHelp(_ help: [String]) {
        for help in help {
            print(help)
        }
    }
}
