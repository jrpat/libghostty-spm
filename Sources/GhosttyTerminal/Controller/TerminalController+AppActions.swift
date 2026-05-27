//
//  TerminalController+AppActions.swift
//  libghostty-spm
//
//  App-level (non-surface-targeted) Ghostty actions, e.g. `quit`,
//  `new_window`, `close_window`. Surface-targeted actions still flow
//  through `TerminalCallbackBridge.handleAction` and that surface's
//  delegate (see `TerminalSurfaceUnhandledActionDelegate`).
//

import Foundation
import GhosttyKit

extension TerminalController {
    /// Invoked when libghostty fires an action whose target is the app
    /// (`GHOSTTY_TARGET_APP`) — that is, the action carries no surface.
    /// Hosts implement this when they own the surrounding application
    /// structure (windows, menu, app lifecycle) and want to react to
    /// keybinds like `quit`, `new_window`, `close_window`, etc.
    ///
    /// Set this on every `TerminalController` whose app should react to
    /// app-level keybinds (typically all of them, since each controller
    /// owns its own `ghostty_app_t`).
    public var onAppAction: ((ghostty_action_s) -> Void)? {
        get { appActionHandler }
        set { appActionHandler = newValue }
    }

    @MainActor
    func handleAppAction(_ action: ghostty_action_s) {
        appActionHandler?(action)
    }
}
