# The config file (`.tmux-project.yaml`)

Drop this in any project root. Example for a Node.js app:

```yaml
name: my-app        # session name (defaults to directory name if omitted)
root: ~/code/my-app # optional — defaults to CWD

windows:
  - editor: nvim .
  - server: npm run dev
  - test:   npm run test:watch
  - shell:                      # no command = plain shell
```

Or use inline shorthand (both formats work):
```yaml
windows:
  - name: editor
    cmd: nvim .
  - name: logs
    cmd: tail -f /var/log/app.log
```

---

# Auto-restore on system startup

**macOS** — create a launchd plist:

```xml
<!-- ~/.config/launchd/tmux-restore.plist -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>       <string>com.user.tmux-restore</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/sh</string>
    <string>-c</string>
    <string>tmux start-server</string>
  </array>
  <key>RunAtLoad</key>   <true/>
</dict>
</plist>
```

```bash
cp ~/.config/launchd/tmux-restore.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/tmux-restore.plist
```

`tmux-continuum` will then restore your last-saved sessions automatically when the server starts.

**Linux (systemd)**:

```ini
# ~/.config/systemd/user/tmux.service
[Unit]
Description=tmux server
After=network.target

[Service]
Type=forking
ExecStart=/usr/bin/tmux start-server
ExecStop=/usr/bin/tmux kill-server
Restart=on-failure

[Install]
WantedBy=default.target
```

```bash
systemctl --user enable --now tmux.service
```

---

# Quick reference

```bash
# From a project root with .tmux-project.yaml:
tmux-project

# Fully via flags (no config file needed):
tmux-project -n myapp -w "editor:nvim ." -w "server:npm run dev" -w "shell"

# Use a specific config file:
tmux-project --file ~/configs/backend.yaml

# Kill the project's session:
tmux-project --kill

# List all sessions:
tmux-project --list
```

**Key design decisions:**
- Zero dependencies — pure bash, works on macOS and any Linux
- Idempotent: running it twice just re-attaches instead of erroring
- The YAML parser is intentionally simple (no `yq`/`python` required) and covers both shorthand and long-form window specs
- `tmux-continuum` handles the periodic saving + restore; the script handles the *initial* structured setup per project

