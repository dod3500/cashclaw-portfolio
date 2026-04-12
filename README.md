# 🚀 Portable AI USB

> **Run powerful AI coding agents from any computer — no installation required.**  
> Plug in. Launch. Code. Works on Windows, Linux, and macOS.

---

## 📦 What's Inside

This is a fully portable, zero-footprint AI coding environment that runs directly from a USB drive (or any folder). It bundles everything — Node.js runtime, AI engine, and a web dashboard — so you never install anything on the host computer.

### Features
- 🤖 **5 AI Providers** — OpenRouter (200+ models), Gemini, Claude, OpenAI, Ollama (offline)
- 🌐 **Web Dashboard** — ChatGPT-style interface with agent mode, tool execution, and thinking visualization
- 🔧 **Coding Agent** — Creates files, runs commands, searches code, reads files — autonomously
- 🔒 **Zero Footprint** — Nothing touches the host PC. All data stays on the USB
- 🔄 **Cross-Platform Settings** — Configure on Windows, plug into Linux — it just works
- ⚡ **Limitless Mode** — Full autonomous execution with no confirmations

---

## ⚡ Quick Start

### Windows
```
1. Download/clone this repo to a USB drive or folder
2. Double-click:  Windows\Setup_First_Time.bat
3. Follow the prompts (picks provider, model, API key)
4. Done! Use Start_AI.bat or Open_Dashboard.bat anytime
```

### Linux
```bash
cd Portable_AI_USB/Linux
chmod +x *.sh
./setup_first_time.sh
```

### macOS
```bash
cd Portable_AI_USB/Mac
bash setup.sh
```

> **First-time setup requires internet** to download Node.js (~25MB) and the AI engine (~5MB).  
> After that, everything runs offline (except API calls to your AI provider).

---

## 🗂 Project Structure

```
Portable_AI_USB/
│
├── 📂 dashboard/          ← Web Dashboard (shared across all platforms)
│   ├── server.mjs             Node.js server with agent system
│   └── index.html             Full-featured chat UI
│
├── 📂 data/               ← Settings & Chat History (shared)
│   ├── ai_settings.env        Your API keys and model config
│   └── chats/                 Saved conversations
│
├── 📂 Windows/            ← Windows scripts + Node.js binary
│   ├── Setup_First_Time.bat   One-time setup
│   ├── Start_AI.bat           Main launcher (CLI mode)
│   ├── Open_Dashboard.bat     Web dashboard launcher
│   ├── Change_Model_or_Provider.bat
│   ├── Uninstall.bat
│   └── bin/                   Node.js + engine (created by setup)
│
├── 📂 Linux/              ← Linux scripts
│   ├── setup_first_time.sh
│   ├── start_ai.sh
│   ├── open_dashboard.sh
│   ├── change_model_or_provider.sh
│   ├── uninstall.sh
│   └── bin/                   (created by setup)
│
├── 📂 Mac/                ← macOS scripts
│   ├── setup.sh
│   ├── start_ai.sh
│   ├── open_dashboard.sh
│   ├── change_model.sh
│   ├── uninstall.sh
│   └── bin/                   (created by setup)
│
└── README.md
```

---

## 🛠 Available Scripts

| Script | What it does |
|--------|-------------|
| **Setup_First_Time** | Downloads Node.js, installs AI engine. Run once. |
| **Start_AI** | Configure provider → select model → launch CLI agent. Use `--quick` for instant limitless mode. |
| **Open_Dashboard** | Starts the web dashboard at `http://localhost:3000` |
| **Change_Model_or_Provider** | Clears your current config and lets you pick a new provider/model |
| **Uninstall** | Removes engine (bin/) and optionally all data (settings + chats) |

### Command-Line Flags (Start_AI)
```
--quick     Skip menus, launch in Limitless mode instantly
--offline   Skip engine update check
```

---

## 🌐 Supported AI Providers

| Provider | Free? | Setup |
|----------|-------|-------|
| **OpenRouter** | ✅ Free + Paid models | Get API key at [openrouter.ai](https://openrouter.ai) |
| **Google Gemini** | ✅ Free tier available | Get API key at [aistudio.google.com](https://aistudio.google.com) |
| **Anthropic Claude** | ❌ Paid only | Get API key at [console.anthropic.com](https://console.anthropic.com) |
| **OpenAI** | ❌ Paid only | Get API key at [platform.openai.com](https://platform.openai.com) |
| **Ollama** | ✅ Fully free & offline | Install [ollama.com](https://ollama.com), run `ollama pull llama3.2:3b` |

---

## 🖥 Web Dashboard

The web dashboard provides a ChatGPT-style interface with agent superpowers:

- **Chat Mode** — Simple conversation with streaming responses
- **Agent Mode** — AI can create files, run commands, search code
- **Thinking Cards** — See the AI's reasoning process (expand/collapse with ▼)
- **Tool Execution** — Visual cards showing what the agent is doing
- **Normal Mode** — Asks for approval before writing files or running commands
- **Limitless Mode** — Full autonomous execution

Launch it:
```
Windows:  Open_Dashboard.bat
Linux:    ./open_dashboard.sh
macOS:    bash open_dashboard.sh
```
Then open **http://localhost:3000** in your browser.

---

## 🔄 Cross-Platform: Configure Once, Use Everywhere

The `data/` folder is shared across all platforms. This means:

1. ✅ Set up your API key on **Windows**
2. ✅ Plug the USB into a **Linux** machine — your settings are already there
3. ✅ Move to a **Mac** — same thing, zero reconfiguration

Each platform only needs its own `bin/` folder (created by running setup on that platform).

---

## 🔒 Security & Privacy

- **Zero Footprint** — No files are written outside the USB/project folder
- **Portable Data** — XDG directories are redirected to `data/`
- **API Key Masking** — Keys are masked in all display output (e.g., `sk-abc1****xyz9`)
- **Approval System** — In Normal mode, write operations require your explicit OK
- **No Telemetry** — Nothing is sent anywhere except your chosen AI provider

---

## 📋 System Requirements

| Platform | Requirements |
|----------|-------------|
| **Windows** | Windows 10+ (nothing else needed — Node.js is bundled) |
| **Linux** | `curl` (pre-installed on most distros). Git/Python recommended. |
| **macOS** | `curl` (pre-installed). For git: `xcode-select --install` |

**Disk Space:** ~150 MB for Node.js + engine per platform

---

## 🔧 Troubleshooting

| Problem | Solution |
|---------|----------|
| "Node.js not found" | Run `Setup_First_Time` first |
| "Port 3000 in use" | Dashboard is already running, or another app uses port 3000 |
| API key rejected | Double-check your key at the provider's website |
| "No internet" | Setup requires internet. After setup, only API calls need internet. |
| Models not loading | OpenRouter API may be slow. Try again, or enter a model name manually. |

---

## 📄 License

MIT — Use it however you want.
