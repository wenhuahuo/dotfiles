# Personal OpenCode and NeoVim Configuration

This repository stores my personal configuration for OpenCode and NeoVim. It intentionally keeps only the configuration that I currently use.

## OpenCode

### Agents

- **Answer Agent**: A read-oriented answer agent with restricted write/edit permissions. It is used for question answering, code reading, and synthesis tasks.
- **Writing Agent**: The primary writing coordinator. It depends on `ai-vibe-writing-skill`, but the local workflow is customized for paragraph/section-level writing rather than outline-first long-form drafting.
- **Writing Subagents**: `style_extractor`, `content_writer`, `reviewer`, and optional `outline_manager`. The default loop is write -> review -> revise, with a maximum revision policy and explicit pass criteria.
- **No Figure Generation Agents**: The previous figure generation workflow and OpenRouter image plugin have been removed. There is no `generate_image` or `analyze_image` tool registered in this config.

### Skills

- **ai-vibe-writing-skill**: A customized writing skill based on [AI-Vibe-Writing-Skills](https://github.com/donghuixin/AI-Vibe-Writing-Skills/). Project-level `.ai_context/` is used only when a project needs writing memory or style context.
- **pdf**: A PDF processing skill adapted from the [Anthropic PDF skill](https://github.com/anthropics/skills/tree/main/skills/pdf). It requires the related Python dependencies such as `pypdf` and `pdfplumber`.

### Plugins

- **task-done-notify**: Plays a macOS sound and sends a desktop notification when an OpenCode session becomes idle or errors.
- **opencode-quota**: Displays OpenCode quota/session token information. Toast notifications are disabled in `opencode/opencode-quota/quota-toast.json`.

### Theme

- **vscode-diy**: A simple VSCode-like OpenCode theme.

## NeoVim

### Core

- Uses `lazy.nvim` and imports plugin specs from `nvim/lua/plugins/`.
- Uses the system clipboard via `unnamedplus`.
- The stale `minuet-ai.nvim` spec has been removed to avoid lazy.nvim startup errors.

### Plugins

- **autopairs**: Automatic bracket and quote pairing.
- **blink**: Completion UI and completion engine configuration.
- **bufferline**: Buffer/tab line display.
- **hopkey**: Fast in-buffer motion.
- **illuminate**: Symbol and variable highlighting.
- **markview**: Markdown preview and rendering.
- **mason**: LSP/tool installer management.
- **nvim-tree**: File tree explorer.
- **tree-sitter**: Syntax parsing and highlighting.
- **vscode**: VSCode-like NeoVim colorscheme.
