import libc

public func popen2(_ arguments: [String], redirectStandardError: Bool = false, environment: [String: String] = [:]) throws
{
    do {
        // Create the file actions to use for spawning.
        #if os(macOS)
            var fileActions: posix_spawn_file_actions_t? = nil
        #else
            var fileActions = posix_spawn_file_actions_t()
        #endif
        posix_spawn_file_actions_init(&fileActions)

        posix_spawn_file_actions_addinherit_np(&fileActions, 0)
        posix_spawn_file_actions_addinherit_np(&fileActions, 1)
        posix_spawn_file_actions_addinherit_np(&fileActions, 2)

        // Launch the command.
        let pid = try posix_spawnp(arguments[0], args: arguments, environment: environment, fileActions: fileActions)

        // Clean up the file actions.
        posix_spawn_file_actions_destroy(&fileActions)

        // Wait for the command to exit.
        let exitStatus = try waitpid(pid)

        guard exitStatus == 0 else {
            throw Error.exitStatus(exitStatus, arguments)
        }

    } catch let underlyingError as SystemError {
        throw ShellError.popen(arguments: arguments, underlyingError)
    }
}
