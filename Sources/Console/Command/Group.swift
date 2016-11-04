public class Group: Runnable {
    public var id: String
    public var commands: [Runnable]
    public var help: [String]
    public var signature: String
    public var description: String
    public var options: [String: Any]

    public init(id: String, commands: [Runnable], help: [String], signature: String, description: String, options: [String: Any]) {
        self.id = id
        self.commands = commands
        self.help = help
        self.signature = signature
        self.description = description
        self.options = options
    }
}
